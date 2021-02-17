import 'dart:async';

import 'package:flutter/services.dart';
import 'package:admob/src/helpers/memoizer.dart';

import '../../admob.dart';
import '../utils.dart';

/// The events a [InterstitialAd] can receive. Listen
/// to the events using `interstitialAd.onEvent.listen((event) {})`.
///
/// Avaiable events:
///   - loading (When the ad starts loading)
///   - loaded (When the ad is loaded)
///   - loadFailed (When the ad failed to load)
///   - showed (When the ad showed successfully)
///   - failedToShow (When it failed to show the ad)
///   - closed (When the ad is closed)
enum InterstitialAdEvent { loadFailed, loaded, loading, showed, failedToShow, closed }

/// An InterstitialAd model to communicate with the model in the platform side.
/// It gives you methods to help in the implementation and event tracking.
///
/// For more info, see:
///   - https://developers.google.com/admob/android/interstitial-fullscreen
///   - https://developers.google.com/admob/ios/interstitial
class InterstitialAd extends AdMethodChannel<InterstitialAdEvent> {
  InterstitialAd({this.unitId});

  static String get testUnitId => MobileAds.interstitialAdTestUnitId;
  static String get videoTestUnitId => MobileAds.interstitialAdVideoTestUnitId;

  final String unitId;

  @override
  Stream<Map<InterstitialAdEvent, dynamic>> get onEvent => super.onEvent as Stream<Map<InterstitialAdEvent, dynamic>>;
  Memoizer<bool> _loaded;
  bool get isLoaded => _loaded?.value == true;

  @override
  void init() {
    channel.setMethodCallHandler(_handleMessages);
    MobileAds.pluginChannel.invokeMethod('initInterstitialAd', {'id': id});
  }

  @override
  void dispose() {
    super.dispose();
    MobileAds.pluginChannel.invokeMethod('disposeInterstitialAd', {'id': id});
  }

  /// Handle the messages the channel sends
  Future<void> _handleMessages(MethodCall call) async {
    if (disposed) return;
    switch (call.method) {
      case 'loading':
        onEventController.add({InterstitialAdEvent.loading: null});
        break;
      case 'onAdFailedToLoad':
        onEventController.add({
          InterstitialAdEvent.loadFailed: AdError.fromJson(call.arguments),
        });
        break;
      case 'onAdLoaded':
        onEventController.add({InterstitialAdEvent.loaded: null});
        break;
      case 'onAdShowedFullScreenContent':
        onEventController.add({InterstitialAdEvent.showed: null});
        break;
      case 'onAdFailedToShowFullScreenContent':
        onEventController.add({
          InterstitialAdEvent.failedToShow: AdError.fromJson(call.arguments as Map<String, dynamic>),
        });
        break;
      case 'onAdDismissedFullScreenContent':
        onEventController.add({InterstitialAdEvent.closed: null});
        break;
      default:
        break;
    }
  }

  Future<bool> _callLoadAd() => channel.invokeMethod<bool>('loadAd', {
        'unitId': unitId ?? MobileAds.interstitialAdUnitId ?? MobileAds.interstitialAdTestUnitId,
      });

  @override
  Future<bool> load() async {
    assert(MobileAds.isInitialized);
    assert(!disposed);
    return (_loaded ??= Memoizer<bool>(future: _callLoadAd)).future;
  }

  @override
  Future<bool> show() async {
    assert(!disposed);
    if (await load()) return channel.invokeMethod<bool>('show');
    return false;
  }
}
