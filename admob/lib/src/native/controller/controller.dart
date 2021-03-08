import 'dart:async';
import 'dart:collection';

import 'package:admob/src/native/controller/native_ad.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utils/utils.dart';

import '../../../admob.dart';
import '../../utils.dart';
import 'options.dart';

export 'native_ad.dart';
export 'options.dart';

part 'controller.freezed.dart';
part 'controller.g.dart';

enum NativeAdEvent { loadFailed, loaded, loading, muted, undefined }
enum AdVideoEvent { start, play, pause, end, muted, unmuted }
enum NativeAdVideoPlaybackState { playing, paused }
enum NativeAdVideoLifecycle { idle, started, ended }

@freezed
abstract class NativeAdVideoState with _$NativeAdVideoState {
  const factory NativeAdVideoState({
    @Default(NativeAdVideoPlaybackState.paused) NativeAdVideoPlaybackState playback,
    @Default(NativeAdVideoLifecycle.idle) NativeAdVideoLifecycle lifecycle,
    @Default(true) bool muted,
  }) = _NativeAdVideoState;
}

/// An Native Ad Controller model to communicate with the model on the platform side.
/// It gives you methods to help in the implementation and event tracking.
/// It's supposed to work alongside `NativeAd`, the class used to show the ad in
/// the UI and add it to the widget tree.
///
/// For more info, see:
///   - https://developers.google.com/admob/android/native/start
///   - https://developers.google.com/admob/ios/native/start
class NativeAdController extends _NativeAdController with _$NativeAdController {
  NativeAdController({
    String options = NativeAdOptions.defaultKey,
  }) : super(options);

  static String get testUnitId => MobileAds.nativeAdTestUnitId;
  static String get videoTestUnitId => MobileAds.nativeAdVideoTestUnitId;

  static final _neverUsedControllers = HashMap<String, Queue<NativeAdController>>();

  static int getFoldedCount({String options = NativeAdOptions.defaultKey}) =>
      _neverUsedControllers[options]?.length ?? 0;

  static NativeAdController reuseOrCreate({String options = NativeAdOptions.defaultKey}) =>
      firstReusable(options: options) ?? NativeAdController(options: options);

  /// Allow reusing never show controllers.
  static NativeAdController firstReusable({
    String options = NativeAdOptions.defaultKey,
    NativeAdController Function() orElse,
    bool Function(NativeAdController) where,
  }) {
    final queue = _neverUsedControllers[options];
    final throwAways = Queue<NativeAdController>();

    NativeAdController value;

    while (queue?.isNotEmpty == true) {
      final controller = queue.removeFirst();

      if (controller.considerThisOld()) {
        // Dispose old controllers.
        controller.dispose();
      } else if (!(where?.call(controller) ?? true)) {
        // Skip unwanted controllers. They need to be added back to the front of the queue.
        throwAways.add(controller);
      } else {
        assert(!controller.hasBeenAttachedTo());
        value = controller;
      }
    }

    if (throwAways.isNotEmpty) {
      _neverUsedControllers[options] = throwAways..addAll(queue);
    } else if (queue?.isEmpty == true) {
      _neverUsedControllers.remove(options);
    }

    return value ?? orElse?.call();
  }

  /// Fold a controller, if it never got used. It shouldn't be disposed.
  static void fold(NativeAdController controller) {
    assert(!controller.hasBeenAttachedTo());
    assert(!controller.disposed);
    (_neverUsedControllers[controller.optionsKey] ??= Queue<NativeAdController>()).add(controller);
  }
}

abstract class _NativeAdController extends AdMethodChannel<NativeAdEvent> with AttachableMixin, Store {
  _NativeAdController(this.optionsKey);

  @override
  final String channelName = 'nativeAdController';
  final String optionsKey;

  /// Options don't exist until [MobileAds.initialize] has been called.
  NativeAdOptions get options => MobileAds.instance.nativeAd.options[optionsKey];

  DateTime loadTime;
  Memoizer _hydrateMemoizer;
  bool get isLoaded => _hydrateMemoizer?.value != null;

  @override
  Map<String, dynamic> get initParams => <String, dynamic>{'options': optionsKey};

  @observable
  NativeAd nativeAd = NativeAd.loading();

  @observable
  NativeAdVideoState videoState = const NativeAdVideoState();

  @observable
  List<String> muteThisAdReasons = const <String>[];

  bool considerThisOld() => loadTime != null && nativeAd.maybeMap((_) => true, orElse: () => false)
      ? DateTime.now().difference(loadTime) > const Duration(hours: 1)
      : false; // Hasn't even been built yet.

  /// Handle the messages the channel sends
  @override
  void handleMethodCall(MethodCall call) {
    switch (call.method) {
      // Ad cases.
      case 'onAdChanged':
        nativeAd = NativeAd.fromJson(Map<String, dynamic>.from(call.arguments as Map));
        break;
      case 'onAdMuted':
        muteThisAdReasons = List<String>.from(call.arguments as List);
        break;

      // Video cases.
      case 'onVideoStart':
        videoState = videoState.copyWith.call(lifecycle: NativeAdVideoLifecycle.started);
        break;
      case 'onVideoPlay':
        videoState = videoState.copyWith.call(playback: NativeAdVideoPlaybackState.playing);
        break;
      case 'onVideoPause':
        videoState = videoState.copyWith.call(playback: NativeAdVideoPlaybackState.paused);
        break;
      case 'onVideoMute':
        videoState = videoState.copyWith.call(muted: call.arguments as bool);
        break;
      case 'onVideoEnd':
        videoState = videoState.copyWith.call(lifecycle: NativeAdVideoLifecycle.ended);
        break;
    }
  }

  // FIXME: Maybe drop clicks, if the controller hasn't been attached to for more than a second.
  Future<bool> click() => channel.invokeMethod<bool>('click');

  /// Mutes this ad programmatically. Use `null` to mute this ad with the default reason.
  Future<void> muteThisAd([int reason]) => channel.invokeMethod('mute', {'reason': reason});

  Future unmountView() => channel.invokeMethod('unmountView');
  Future mountView() async {
    assert(nativeAd.maybeMap((_) => true, orElse: () => false));
    await channel.invokeMethod('mountView');
  }

  Future _hydrate() async {
    try {
      await channel.invokeMethod('hydrate');
    } finally {
      loadTime ??= DateTime.now();
    }
  }

  /// Will try to hydrate the controller one time. This callback doesn't wait till an
  /// ad is received.
  Future load() async {
    assert(MobileAds.instance.isInitialized);
    await init();
    await (_hydrateMemoizer ??= Memoizer(_hydrate)).future;
    await asyncWhen((_) => nativeAd.maybeMap((_) => true, loading: (_) => false, orElse: () => true));
    return nativeAd;
  }

  /// If the controller was never attached to, it will be folded to a queue
  /// where you can later reuse it with [NativeAdController.firstReusable].
  @override
  Future dispose() {
    assert(!disposed, 'Redundant dispose');

    if (channel != null) {
      if (!hasBeenAttachedTo() && !considerThisOld()) {
        NativeAdController.fold(this as NativeAdController);
      } else {
        return super.dispose();
      }
    }

    return SynchronousFuture(null);
  }
}
