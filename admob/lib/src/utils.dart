import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utils/utils.dart';

import 'mobile_ads.dart';

part 'utils.freezed.dart';
part 'utils.g.dart';

/// Make sure the running platform is supported.
/// The currently supported platforms are:
///   - Android
void assertPlatformIsSupported() {
  // Google's AdMOB supports only Android and iOS
  assert(
    Platform.isAndroid || Platform.isIOS,
    'The current platform does not support native ads. '
    'The platforms that support it are Android and iOS',
  );

  // TODO: Support iOS
  assert(Platform.isAndroid, 'Android is the only supported platform for now');
}

/// Assert the Mobile Ads SDK is initialized.
/// It must be initialized before any ads can be loaded and must be initialized once.
void assertMobileAdsIsInitialized() {
  assert(
    MobileAds.instance.isInitialized,
    'The Mobile Ads SDK must be initialized before any ads can be loaded',
  );
}

/// Assert the current version is supported.
/// The min versions are:
///  - iOS: 9
///  - Android: 16 (19 for Native and Banner Ads)
void assertVersionIsSupported([bool usePlatformView = true]) {
  if (Platform.isAndroid) {
    /// The min required version for Android is 16
    assert(
      MobileAds.instance.osVersion >= 16,
      'The required version to use the AdMOB SDK is 16 or higher',
    );

    /// The required version by flutter to use PlatformViews is
    ///   - Hybrid composition: 19
    ///   - Virtual display: 20
    if (usePlatformView)
      assert(
        MobileAds.instance.osVersion >= 19,
        'Native and Banner Ads are not supported in versions before 19 because'
        ' flutter only support platform views on Android 19 or greater.',
      );
  } else {
    /// The min required version for iOS is 9
    assert(
      MobileAds.instance.osVersion >= 9,
      'The required version to use the AdMOB SDK is 9 or higher',
    );
  }
}

/// Ad widget builder callback.
typedef AdBuilder = Widget Function(BuildContext context, Widget child);

/// Build the android platform view
Widget buildAndroidPlatformView(
  Map<String, dynamic> params,
  String viewType, [
  bool useHybridComposition = false,
  void Function(int) onPlatformViewCreated,
]) {
  assert(useHybridComposition != null);
  const gestures = <Factory<OneSequenceGestureRecognizer>>{};
  if (!useHybridComposition)
    // virtual display
    return RepaintBoundary(
      child: AndroidView(
        viewType: viewType,
        clipBehavior: Clip.none,
        creationParamsCodec: const StandardMessageCodec(),
        creationParams: params,
        gestureRecognizers: gestures,
        onPlatformViewCreated: onPlatformViewCreated,
      ),
    );
  else
    // hybrid composition
    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: gestures,
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (PlatformViewCreationParams p) {
        return PlatformViewsService.initSurfaceAndroidView(
          id: p.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: params,
          creationParamsCodec: const StandardMessageCodec(),
        )
          ..addOnPlatformViewCreatedListener((v) {
            p.onPlatformViewCreated(v);
            onPlatformViewCreated?.call(v);
          })
          // ..setSize(Size(width, height))
          ..create();
      },
    );
}

@freezed
abstract class AdError with _$AdError {
  const factory AdError({
    /// Gets the error code. Possible error codes:
    /// - App Id Missing (The ad request was not made due to a missing app ID): 8
    /// - Invalid request (The ad request was invalid; for instance, the ad unit ID was incorrect): 1
    /// - Network error (The ad request was unsuccessful due to network connectivity): 2
    /// - No fill (The ad request was successful, but no ad was returned due to lack of ad inventory): 3
    ///
    /// See [this](https://developers.google.com/android/reference/com/google/android/gms/ads/AdRequest#constant-summary) for more info
    ///
    /// If this comes from [OpenAds], the possible error codes are:
    /// - Ad Reused (You're reusing an ad. This will rarely happen because this error is handled by the plugin): 1
    /// - Ad not ready (The ad is not ready to be shown): 2
    /// - App Not In Foreground (The app must be in foreground so the ad can be shown): 3
    ///
    /// See [this](https://developers.google.com/android/reference/com/google/android/gms/ads/FullScreenContentCallback#constants) for more info
    ///
    /// Global error codes:
    /// - Internal error (Something happened internally; for instance, an invalid response was received from the ad server): 0
    @required int code,

    /// Gets an error message. For example "Account not approved yet".
    /// See [this](https://support.google.com/admob/answer/9905175) for explanations of common errors.
    @required String message,

    /// Gets the domain from which the error came.
    @required String domain,
  }) = _AdError;

  factory AdError.fromJson(Map<String, dynamic> json) => _$AdErrorFromJson(json);
}

mixin AttachableMixin {
  int _client;
  bool get isAttached => _client != null;
  DateTime attachTime;

  /// Returns true if something attached for longer than a second.
  bool hasBeenAttachedTo() => attachTime != null && attachTime.add(const Duration(seconds: 1)).isBefore(DateTime.now());

  @mustCallSuper
  void attach(dynamic object) {
    assert(
      !isAttached,
      'This controller has already been attached to an ad. You need one controller for each',
    );

    _client = object.hashCode;
    attachTime = DateTime.now();
  }

  void detach(Object object) {
    assert(isAttached);
    assert(_client == object.hashCode, 'Tried to detatch with a different client');
    _client = null;
    if (!hasBeenAttachedTo()) attachTime = null;
  }
}

mixin _AdMethodChannelImpl {
  String get channelName;
}

abstract class AdMethodChannel<T> implements _AdMethodChannelImpl {
  AdMethodChannel() {
    init();
  }

  Memoizer<bool> initMemoizer;
  MethodChannel channel;
  bool get disposed => channel == null;
  String get id => hashCode.toString();
  Map<String, dynamic> get initParams => const <String, dynamic>{};

  @protected
  void handleMethodCall(MethodCall call);

  Future _handleMethodCall(MethodCall call) {
    handleMethodCall(call);
    return SynchronousFuture(null);
  }

  @protected
  @mustCallSuper
  Future init() {
    channel ??= MethodChannel(id)..setMethodCallHandler(_handleMethodCall);
    return (initMemoizer ??= Memoizer(
      () => MobileAds.instance.pluginChannel.invokeMethod(
        '${channelName}Create',
        {'id': id, ...initParams},
      ),
    ))
        .future;
  }

  @mustCallSuper
  Future dispose() async {
    assert(!disposed, 'Redundant dispose');
    if (channel != null) {
      await init();
      final channel = this.channel;
      this.channel = null;

      try {
        await channel.invokeMethod('dispose');
      } catch (_) {
        this.channel = channel;
        rethrow;
      }
    }
  }
}
