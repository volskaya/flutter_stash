import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:utils/utils.dart';

import '../mobile_ads.dart';
import '../utils.dart';

/// Portrait orientation.
const int APP_OPEN_AD_ORIENTATION_PORTRAIT = 1;

/// Landscape orientation.
const int APP_OPEN_AD_ORIENTATION_LANDSCAPE = 2;

enum AppOpenEvent { loading, loaded, loadFailed, dismissed, showFailed, showed }

/// An AppOpenAd model to communicate with the model in the platform side.
/// It gives you methods to help in the implementation and event tracking.
///
/// For more info, see:
///   - https://developers.google.com/admob/android/app-open-ads
///   - https://developers.google.com/admob/ios/app-open-ads
@Deprecated('This has not been refactored and contains buggy code')
class AppOpenAd extends AdMethodChannel<AppOpenEvent> {
  AppOpenAd({
    this.timeout = const Duration(hours: 1),
    this.unitId,
    this.orientation,
  });

  @override
  final String channelName = 'appOpenAd';
  final Duration timeout; // The duration this ad can be kept loaded. Default to 1 hour.
  final String unitId;
  final Orientation orientation;

  static String get testUnitId => MobileAds.appOpenAdTestUnitId;

  bool _isAvaiable = false;
  bool isShowing = false;
  DateTime _lastLoadedTime;
  Memoizer<bool> _loaded;

  /// Check if the ad is avaiable. Default to `false`. This turns `true` when the ad is loaded.
  ///
  /// If the timeout time is over since the last time it was loaded thne it'll return `false`.
  bool get isAvaiable {
    if (_lastLoadedTime != null && timeout != null) {
      final difference = _lastLoadedTime.difference(DateTime.now());
      if (difference > timeout) return false;
    }
    return _isAvaiable;
  }

  @override
  void handleMethodCall(MethodCall call) {
    switch (call.method) {
      case 'loading':
        // onEventController.add({AppOpenEvent.loading: null});
        break;
      case 'onAppOpenAdFailedToLoad':
        // onEventController.add({
        //   AppOpenEvent.loadFailed: AdError.fromJson(call.arguments as Map<String, dynamic>),
        // });
        break;
      case 'onAppOpenAdLoaded':
        _isAvaiable = true;
        // onEventController.add({AppOpenEvent.loaded: null});
        break;
      case 'onAdDismissedFullScreenContent':
        _isAvaiable = false;
        isShowing = false;
        // onEventController.add({AppOpenEvent.dismissed: null});
        break;
      case 'onAdFailedToShowFullScreenContent':
        // onEventController.add({
        //   AppOpenEvent.showFailed: AdError.fromJson(call.arguments as Map<String, dynamic>),
        // });
        break;
      case 'onAdShowedFullScreenContent':
        isShowing = true;
        // onEventController.add({AppOpenEvent.showed: null});
        break;
    }
  }

  static Orientation _getDeviceOrientation() {
    final window = WidgetsBinding.instance.window;
    final size = window.physicalSize / window.devicePixelRatio;
    return size.width > size.height ? Orientation.landscape : Orientation.portrait;
  }

  Future<bool> _callLoadAd() {
    int orientationInt;
    switch (orientation ?? _getDeviceOrientation()) {
      case Orientation.landscape:
        orientationInt = APP_OPEN_AD_ORIENTATION_LANDSCAPE;
        break;
      case Orientation.portrait:
        orientationInt = APP_OPEN_AD_ORIENTATION_PORTRAIT;
        break;
      default:
    }

    return channel.invokeMethod<bool>('loadAd', {
      'unitId': unitId ?? MobileAds.instance.appOpenAdUnitId ?? MobileAds.appOpenAdTestUnitId,
      'orientation': orientationInt,
    });
  }

  Future<bool> load() {
    assert(MobileAds.instance.isInitialized);
    assert(!disposed);
    return (_loaded ??= Memoizer<bool>(_callLoadAd)).future;
  }

  Future<bool> show() async {
    assert(MobileAds.instance.isInitialized);
    assert(!disposed);
    if (await load()) return channel.invokeMethod<bool>('showAd');
    return false;
  }
}
