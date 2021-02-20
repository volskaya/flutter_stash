import 'dart:async';

import 'package:flutter/services.dart';
import 'package:utils/utils.dart';

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
@Deprecated('This has not been refactored and contains buggy code')
class InterstitialAd extends AdMethodChannel<InterstitialAdEvent> {
  InterstitialAd({this.unitId});

  static String get testUnitId => MobileAds.interstitialAdTestUnitId;
  static String get videoTestUnitId => MobileAds.interstitialAdVideoTestUnitId;

  @override
  final String channelName = 'intertistialAd';
  final String unitId;

  Memoizer<bool> _loaded;
  bool get isLoaded => _loaded?.value == true;

  @override
  void handleMethodCall(MethodCall call) {
    switch (call.method) {
      case 'loading':
        // onEventController.add({InterstitialAdEvent.loading: null});
        break;
      case 'onAdFailedToLoad':
        // onEventController.add({
        //   InterstitialAdEvent.loadFailed: AdError.fromJson(Map<String, dynamic>.from(call.arguments as Map)),
        // });
        break;
      case 'onAdLoaded':
        // onEventController.add({InterstitialAdEvent.loaded: null});
        break;
      case 'onAdShowedFullScreenContent':
        // onEventController.add({InterstitialAdEvent.showed: null});
        break;
      case 'onAdFailedToShowFullScreenContent':
        // onEventController.add({
        //   InterstitialAdEvent.failedToShow: AdError.fromJson(Map<String, dynamic>.from(call.arguments as Map)),
        // });
        break;
      case 'onAdDismissedFullScreenContent':
        // onEventController.add({InterstitialAdEvent.closed: null});
        break;
      default:
        break;
    }
  }

  Future<bool> _callLoadAd() => channel.invokeMethod<bool>('loadAd', {
        'unitId': unitId ?? MobileAds.instance.interstitialAdUnitId ?? MobileAds.interstitialAdTestUnitId,
      });

  Future<bool> load() async {
    assert(MobileAds.instance.isInitialized);
    assert(!disposed);
    return (_loaded ??= Memoizer<bool>(_callLoadAd)).future;
  }

  Future<bool> show() async {
    assert(!disposed);
    if (await load()) return channel.invokeMethod<bool>('show');
    return false;
  }
}
