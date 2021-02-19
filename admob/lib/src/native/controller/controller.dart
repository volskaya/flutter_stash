import 'dart:async';

import 'package:admob/src/helpers/memoizer.dart';
import 'package:admob/src/native/controller/native_ad.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
  NativeAdController({String unitId, NativeAdOptions options}) : super(unitId, options);

  static String get testUnitId => MobileAds.nativeAdTestUnitId;
  static String get videoTestUnitId => MobileAds.nativeAdVideoTestUnitId;
}

abstract class _NativeAdController extends AdMethodChannel<NativeAdEvent> with AttachableMixin, Store {
  _NativeAdController(this.unitId, this.options);

  final NativeAdOptions options;
  final String unitId;

  DateTime loadTime;
  Memoizer<NativeAd> _loadAdOperation;
  bool get isLoaded => _loadAdOperation?.value != null;

  @observable
  NativeAd nativeAd = NativeAd.loading();

  @observable
  NativeAdVideoState videoState = const NativeAdVideoState();

  @observable
  List<String> muteThisAdReasons = const <String>[];

  bool considerThisOld() => loadTime != null
      ? loadTime.difference(DateTime.now()) > const Duration(minutes: 30)
      : null; // Hasn't even been built yet.

  /// Handle the messages the channel sends
  Future<void> _handleMessages(MethodCall call) async {
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

  Future<bool> click() {
    assert(nativeAd != null);
    return channel.invokeMethod<bool>('click');
  }

  /// Mutes this ad programmatically. Use `null` to mute this ad with the default reason.
  Future<void> muteThisAd([int reason]) {
    assert(!disposed);
    if (reason != null) assert(!reason.isNegative, 'You must specify a valid reason');
    return channel.invokeMethod('mute', {'reason': reason});
  }

  Future<NativeAd> _callLoadAd() async {
    final map = await channel.invokeMapMethod<String, dynamic>('load', {
      'unitId': unitId ?? MobileAds.nativeAdUnitId ?? MobileAds.nativeAdTestUnitId,
      'options': (options ?? const NativeAdOptions()).toJson(),
    });

    return map != null ? NativeAd.fromJson(map) : null;
  }

  Future mountView() async {
    await load();
    await channel.invokeMethod('mountView');
  }

  Future unmountView() => channel.invokeMethod('unmountView');

  Future<NativeAd> load() {
    assert(MobileAds.isInitialized);
    assert(!disposed);
    loadTime ??= DateTime.now();
    return (_loadAdOperation ??= Memoizer(future: _callLoadAd)).future;
  }

  @override
  void init() {
    channel.setMethodCallHandler(_handleMessages);
    MobileAds.pluginChannel.invokeMethod('initNativeAdController', {'id': id});
  }

  @override
  void dispose() {
    assert(!isAttached, 'Controller disposed before its client was detached');
    super.dispose();
    MobileAds.pluginChannel.invokeMethod('disposeNativeAdController', {'id': id});
  }
}
