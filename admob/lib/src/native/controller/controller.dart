import 'dart:async';

import 'package:flutter/services.dart';
import 'package:admob/src/helpers/memoizer.dart';

import '../../../admob.dart';
import '../../utils.dart';
import 'media_content.dart';
import 'options.dart';

export 'media_content.dart';
export 'options.dart';

enum NativeAdEvent { loadFailed, loaded, loading, muted, undefined }
enum AdVideoEvent { start, play, pause, end, muted, unmuted }

/// An Native Ad Controller model to communicate with the model on the platform side.
/// It gives you methods to help in the implementation and event tracking.
/// It's supposed to work alongside `NativeAd`, the class used to show the ad in
/// the UI and add it to the widget tree.
///
/// For more info, see:
///   - https://developers.google.com/admob/android/native/start
///   - https://developers.google.com/admob/ios/native/start
class NativeAdController extends AdMethodChannel<NativeAdEvent> with AttachableMixin {
  NativeAdController({this.unitId, this.options});

  static String get testUnitId => MobileAds.nativeAdTestUnitId;
  static String get videoTestUnitId => MobileAds.nativeAdVideoTestUnitId;

  final NativeAdOptions options;
  final String unitId;
  final _onVideoEvent = StreamController<Map<AdVideoEvent, dynamic>>.broadcast();

  MediaContent _mediaContent;
  List<String> _muteThisAdReasons = [];
  bool _customMuteThisAdEnabled = false;
  Memoizer<bool> _loaded;

  MediaContent get mediaContent => _mediaContent;
  List<String> get muteThisAdReasons => _muteThisAdReasons;
  bool get isCustomMuteThisAdEnabled => _customMuteThisAdEnabled;
  bool get isLoaded => _loaded?.value == true;

  @override
  Stream<Map<NativeAdEvent, dynamic>> get onEvent => super.onEvent as Stream<Map<NativeAdEvent, dynamic>>;
  Stream<Map<AdVideoEvent, dynamic>> get onVideoEvent => _onVideoEvent.stream;

  /// Handle the messages the channel sends
  Future<void> _handleMessages(MethodCall call) async {
    if (disposed) return;
    if (call.method.startsWith('onVideo')) {
      switch (call.method) {
        case 'onVideoStart':
          _onVideoEvent.add({AdVideoEvent.start: null});
          break;
        case 'onVideoPlay':
          _onVideoEvent.add({AdVideoEvent.play: null});
          break;
        case 'onVideoPause':
          _onVideoEvent.add({AdVideoEvent.pause: null});
          break;
        case 'onVideoMute':
          if (call.arguments as bool) // Is muted.
            _onVideoEvent.add({AdVideoEvent.muted: null});
          else
            _onVideoEvent.add({AdVideoEvent.unmuted: null});
          break;
        case 'onVideoEnd':
          _onVideoEvent.add({AdVideoEvent.end: null});
          break;
      }
    } else {
      switch (call.method) {
        case 'loading':
          onEventController.add({NativeAdEvent.loading: null});
          break;
        case 'onAdFailedToLoad':
          onEventController.add({
            NativeAdEvent.loadFailed: AdError.fromJson(call.arguments as Map<String, dynamic>),
          });
          break;
        case 'onAdLoaded':
          onEventController.add({NativeAdEvent.loaded: null});
          break;
        case 'onAdMuted':
          onEventController.add({NativeAdEvent.muted: null});
          break;
        case 'undefined':
        default:
          onEventController.add({NativeAdEvent.undefined: null});
          break;
      }

      if (call.arguments != null && call.arguments is Map) {
        (call.arguments as Map).forEach((key, _value) {
          final value = Map<String, dynamic>.from(_value as Map ?? const {});
          switch (key as String) {
            case 'muteThisAdInfo':
              _muteThisAdReasons = List<String>.from(value['muteThisAdReasons'] as List ?? []);
              _customMuteThisAdEnabled = (value['isCustomMuteThisAdEnabled'] as bool) ?? false;
              break;
            case 'mediaContent':
              _mediaContent = MediaContent.fromJson(value);
              break;
            default:
              break;
          }
        });
      }
    }
  }

  /// Mutes this ad programmatically. Use `null` to mute this ad with the default reason.
  Future<void> muteThisAd([int reason]) {
    assert(!disposed);
    if (reason != null) assert(!reason.isNegative, 'You must specify a valid reason');
    return channel.invokeMethod('muteAd', {'reason': reason});
  }

  Future<bool> _callLoadAd() => channel.invokeMethod<bool>('loadAd', {
        'unitId': unitId ?? MobileAds.nativeAdUnitId ?? MobileAds.nativeAdTestUnitId,
        'options': (options ?? const NativeAdOptions()).toJson(),
      });

  @override
  Future<bool> load() {
    assert(MobileAds.isInitialized);
    assert(!disposed);
    return (_loaded ??= Memoizer(future: _callLoadAd)).future;
  }

  @override
  void init() {
    channel.setMethodCallHandler(_handleMessages);
    MobileAds.pluginChannel.invokeMethod('initNativeAdController', {'id': id});
  }

  @override
  void dispose() {
    assert(!isAttached, 'Controller disposed before its client was detached');
    _onVideoEvent.close();
    super.dispose();
    MobileAds.pluginChannel.invokeMethod('disposeNativeAdController', {'id': id});
  }
}
