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
    String unitId,
    NativeAdOptions options = const NativeAdOptions(),
    bool showVideoContent = true,
  }) : super(unitId, options, showVideoContent);

  static String get testUnitId => MobileAds.nativeAdTestUnitId;
  static String get videoTestUnitId => MobileAds.nativeAdVideoTestUnitId;

  static final _neverUsedControllers = HashMap<int, Queue<NativeAdController>>();

  static String getStaticUnitId([String unitId]) =>
      unitId ?? MobileAds.instance.nativeAdUnitId ?? MobileAds.nativeAdTestUnitId;

  /// Allow reusing never show controllers.
  static NativeAdController firstReusable({
    String unitId,
    NativeAdOptions options = const NativeAdOptions(),
    bool showVideoContent = true,
    NativeAdController Function() orElse,
  }) {
    final hash = hashValues(getStaticUnitId(unitId), options, showVideoContent);
    final queue = _neverUsedControllers[hash];

    while (queue?.isNotEmpty == true) {
      final controller = queue.removeFirst();

      // The queue could contain old controllers. Make sure they are disposed.
      if (controller.considerThisOld() == true) {
        controller.dispose();
        continue;
      }

      assert(controller.hasBeenAttachedTo == false);
      return controller;
    }

    if (queue?.isEmpty == true) _neverUsedControllers.remove(hash);
    return orElse?.call();
  }

  /// Fold a controller, if it never got used. It shouldn't be disposed.
  static void fold(NativeAdController controller) {
    assert(!controller.hasBeenAttachedTo);
    assert(!controller.disposed);

    final hash = hashValues(controller.unitId, controller.options, controller.showVideoContent);
    (_neverUsedControllers[hash] ??= Queue<NativeAdController>()).add(controller);
  }
}

abstract class _NativeAdController extends AdMethodChannel<NativeAdEvent> with AttachableMixin, Store {
  _NativeAdController(this._unitId, this.options, [this.showVideoContent = true]);

  @override
  final String channelName = 'nativeAdController';
  final String _unitId;
  final NativeAdOptions options;
  final bool showVideoContent; // Instructs the platform to build ghost views, even if the ad has video content.

  String get unitId => NativeAdController.getStaticUnitId(_unitId);
  DateTime loadTime;
  Memoizer<NativeAd> _loadAdOperation;
  bool get isLoaded => _loadAdOperation?.value != null;

  @override
  Map<String, dynamic> get initParams => <String, dynamic>{'showVideoContent': showVideoContent};

  @observable
  NativeAd nativeAd = NativeAd.loading();

  @observable
  NativeAdVideoState videoState = const NativeAdVideoState();

  @observable
  List<String> muteThisAdReasons = const <String>[];

  bool considerThisOld() => loadTime != null && nativeAd.maybeMap((_) => true, orElse: () => false)
      ? DateTime.now().difference(loadTime) > const Duration(hours: 1)
      : null; // Hasn't even been built yet.

  /// Handle the messages the channel sends
  @override
  void handleMethodCall(MethodCall call) {
    switch (call.method) {
      // Ad cases.
      case 'onAdLoading':
        nativeAd = NativeAd.loading();
        break;
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

  Future<bool> click() => channel.invokeMethod<bool>('click');

  /// Mutes this ad programmatically. Use `null` to mute this ad with the default reason.
  Future<void> muteThisAd([int reason]) => channel.invokeMethod('mute', {'reason': reason});

  Future unmountView() => channel.invokeMethod('unmountView');
  Future mountView() async {
    assert(nativeAd.maybeMap((_) => true, orElse: () => false));
    await channel.invokeMethod('mountView');
  }

  Future<NativeAd> _callLoadAd() async {
    try {
      final map = await channel.invokeMapMethod<String, dynamic>('load', {
        'unitId': unitId,
        'options': (options ?? const NativeAdOptions()).toJson(),
      });

      return map != null ? NativeAd.fromJson(map) : null;
    } finally {
      loadTime ??= DateTime.now();
    }
  }

  Future<NativeAd> load() async {
    assert(MobileAds.instance.isInitialized);
    await init();
    return (_loadAdOperation ??= Memoizer(_callLoadAd)).future;
  }

  /// If the controller was never attached to, it will be folded to a queue
  /// where you can later reuse it with [NativeAdController.firstReusable].
  @override
  Future dispose() {
    assert(!disposed, 'Redundant dispose');

    if (channel != null) {
      if (!hasBeenAttachedTo) {
        NativeAdController.fold(this as NativeAdController);
      } else {
        return super.dispose();
      }
    }

    return SynchronousFuture(null);
  }
}
