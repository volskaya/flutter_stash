import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:admob/src/helpers/memoizer.dart';

import '../mobile_ads.dart';
import '../utils.dart';

enum BannerAdEvent { impression, loadFailed, loaded, loading }

/// The size of a [BannerAd]. It's highly recommended to use
/// [BannerSize.adaptive] when creating your [BannerAd]s.
abstract class BannerSize {
  /// Smart Banners are ad units that render screen-width banner
  /// ads on any screen size across different devices in either
  /// orientation. Smart Banners detect the width of the device
  /// in its current orientation and create the ad view that size.
  @Deprecated('Smart banner is deprecated in favor of adaptive banner')
  static const Size smartBanner = Size(-1, -2);

  /// Adaptive banners are the next generation of responsive ads,
  /// maximizing performance by optimizing ad size for each device.
  /// Improving on smart banners, which only supported fixed heights,
  /// adaptive banners let developers specify the ad-width and use
  /// this to determine the optimal ad size.
  ///
  /// To pick the best ad size, adaptive banners use fixed aspect ratios
  /// instead of fixed heights. This results in banner ads that occupy a
  /// more consistent portion of the screen across devices and provide
  /// opportunities for improved performance.
  static const Size adaptive = Size(-1, -1);

  /// Standart banner of 320x50.
  static const Size banner = Size(320, 50);

  /// Large banner of 320x100.
  static const Size largeBanner = Size(320, 100);

  /// Medium rectangle banner of 320x250. Avaiable only on Tablets.
  static const Size mediumRectangle = Size(320, 250);

  /// Full banner of 468x60. Avaiable only on Tablets
  static const Size fullBanner = Size(468, 60);

  /// leaderboard banner of 728x90.
  static const Size leaderboard = Size(728, 90);
}

/// An Banner Ad Controller model to communicate with the model on the platform side.
/// It gives you methods to help in the implementation and event tracking.
/// It's supposed to work alongside `BannerAd`, the class used to show the ad in
/// the UI and add it to the widget tree.
///
/// For more info, see:
///   - https://developers.google.com/admob/android/banner
///   - https://developers.google.com/admob/ios/banner
class BannerAdController extends AdMethodChannel<BannerAdEvent> with AttachableMixin {
  static String get testUnitId => MobileAds.bannerAdTestUnitId;

  @override
  Stream<Map<BannerAdEvent, dynamic>> get onEvent => super.onEvent as Stream<Map<BannerAdEvent, dynamic>>;
  Memoizer<bool> _loaded;
  bool get isLoaded => _loaded?.value == true;

  @override
  void init() {
    channel.setMethodCallHandler(_handleMessages);
    MobileAds.pluginChannel.invokeMethod('initBannerAdController', {'id': id});
  }

  @override
  void dispose() {
    assert(!isAttached, 'Controller disposed before its client was detached');
    super.dispose();
    MobileAds.pluginChannel.invokeMethod('disposeBannerAdController', {'id': id});
  }

  Future _handleMessages(MethodCall call) async {
    if (disposed) return;
    switch (call.method) {
      case 'loading':
        onEventController.add({BannerAdEvent.loading: null});
        break;
      case 'onAdFailedToLoad':
        onEventController.add({
          BannerAdEvent.loadFailed: AdError.fromJson(call.arguments as Map<String, dynamic>),
        });
        break;
      case 'onAdLoaded':
        onEventController.add({BannerAdEvent.loaded: call.arguments});
        break;
      case 'onAdImpression':
        onEventController.add({BannerAdEvent.impression: null});
        break;
      default:
        break;
    }
  }

  Future<bool> _callLoadAd() => channel.invokeMethod<bool>('loadAd');

  @override
  Future<bool> load() async {
    assert(MobileAds.isInitialized);
    assert(!disposed);
    return (_loaded ??= Memoizer<bool>(future: _callLoadAd)).future;
  }
}
