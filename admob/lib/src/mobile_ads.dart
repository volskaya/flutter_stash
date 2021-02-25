import 'dart:io';

import 'package:admob/src/consent/consent_coordinator.dart';
import 'package:admob/src/platform_props.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'utils.dart';

const int RATING_G = 0;
const int RATING_PG = 1;
const int RATING_T = 2;
const int RATING_MA = 3;

/// The basic class to use Ads. It's responsible to initialize
/// the SDK and make sure you are:
///   - using the right system version;
///   - using test devices and test ids;
///   - targeting the right groups of people.
class MobileAds {
  MobileAds._();

  static final instance = MobileAds._();
  final pluginChannel = const MethodChannel('admob');
  final consent = ConsentCoordinator.instance;

  static String get nativeAdTestUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/2247696110' : 'ca-app-pub-3940256099942544/3986624511';
  static String get nativeAdVideoTestUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/1044960115' : 'ca-app-pub-3940256099942544/2521693316';
  static String get bannerAdTestUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716';
  static String get interstitialAdTestUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/4411468910';
  static String get interstitialAdVideoTestUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/8691691433' : 'ca-app-pub-3940256099942544/5135589807s';
  static String get rewardedAdTestUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-3940256099942544/1712485313';
  static String get appOpenAdTestUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/3419835294' : 'ca-app-pub-3940256099942544/5662855259';

  // Unit ids.
  String bannerAdUnitId;
  String interstitialAdUnitId;
  String rewardedAdUnitId;
  String appOpenAdUnitId;

  bool useHybridComposition = false;
  bool _initialized = false;
  bool get isInitialized => _initialized;
  int _version = 0;
  int get osVersion => _version;

  NativeAdPlatformProps nativeAd;

  /// Before creating any native ads, you must initalize the admob.
  /// This can be done only once, ideally at app launch. If you try to
  /// initialize it more than once, an AssertionError is thrown
  ///
  /// ```dart
  /// void main() async {
  ///   MobileAds.initialize();
  ///   runApp(MyApp());
  /// }
  /// ```
  Future<void> initialize({
    NativeAdPlatformProps nativeAd,
    List<String> debugDeviceIds,
    bool underAgeOfConsent = false,
  }) async {
    assertPlatformIsSupported();
    assert(!isInitialized);

    this.nativeAd = nativeAd;
    _debugCheckIsTestId(nativeAd.unitId, [nativeAdTestUnitId, nativeAdVideoTestUnitId]);

    // Setup old ad ids.
    bannerAdUnitId ??= bannerAdUnitId ?? bannerAdTestUnitId;
    _debugCheckIsTestId(bannerAdUnitId, [bannerAdTestUnitId]);
    interstitialAdUnitId ??= interstitialAdUnitId ?? interstitialAdTestUnitId;
    _debugCheckIsTestId(interstitialAdUnitId, [interstitialAdTestUnitId, interstitialAdVideoTestUnitId]);
    rewardedAdUnitId ??= rewardedAdUnitId ?? rewardedAdTestUnitId;
    _debugCheckIsTestId(rewardedAdUnitId, [rewardedAdTestUnitId]);
    appOpenAdUnitId ??= appOpenAdUnitId ?? appOpenAdTestUnitId;
    _debugCheckIsTestId(appOpenAdUnitId, [appOpenAdTestUnitId]);

    final platformProps = PlatformProps(
      nativeAd: nativeAd,
    );

    bool forceTesting = false;
    assert((() {
      forceTesting = true;
      return true;
    })());

    // Make sure the version is supported.
    _version = await pluginChannel.invokeMethod<int>('initialize', <String, dynamic>{
      'debugDeviceIds': debugDeviceIds,
      'props': platformProps.toJson(),
      'underAgeOfConsent': underAgeOfConsent,
      'forceTesting': forceTesting,
    });

    assertVersionIsSupported(false);
    _initialized = true;
  }

  /// Check if the test id that is being used is for testing or not.
  ///
  /// [kReleaseMode] and [kDebugMode] are considered as test mode.
  static void _debugCheckIsTestId(String id, List<String> testIds) {
    assert(id != null);
    assert(testIds != null);
    assert(kReleaseMode || testIds.isNotEmpty);
  }

  /// Returns `true` if this device will receive test ads.
  Future<bool> isTestDevice() => pluginChannel.invokeMethod<bool>('isTestDevice');

  /// For purposes of the Children's Online Privacy Protection Act (COPPA),
  /// there is a setting called "tag for child-directed treatment". By setting this tag,
  /// you certify that this notification is accurate and you are authorized to act on behalf
  /// of the owner of the app. You understand that abuse of this setting may result in
  /// termination of your Google account.
  ///
  /// As an app developer, you can indicate whether you want Google to treat your content as
  /// child-directed when you make an ad request. If you indicate that you want Google to treat
  /// your content as child-directed, we take steps to disable IBA and remarketing ads on that
  /// ad request.
  ///
  /// [Learn more](https://developers.google.com/admob/android/targeting#child-directed_setting)
  ///
  /// true = TAG_FOR_CHILD_DIRECTED_TREATMENT_TRUE\
  /// false = TAG_FOR_CHILD_DIRECTED_TREATMENT_FALSE\
  /// null = TAG_FOR_CHILD_DIRECTED_TREATMENT_UNSPECIFIED
  Future<void> setChildDirected(bool directed) =>
      pluginChannel.invokeMethod('setChildDirected', {'directed': directed});

  /// You can mark your ad requests to receive treatment for users in the
  /// European Economic Area (EEA) under the age of consent. This feature is
  /// designed to help facilitate compliance with the General Data Protection
  /// Regulation (GDPR). Note that you may have other legal obligations under GDPR.
  /// Please review the European Union’s guidance and consult with your own legal counsel.
  /// Please remember that Google's tools are designed to facilitate compliance and do not
  /// relieve any particular publisher of its obligations under the law. Learn more about
  /// how the GDPR affects publishers.
  ///
  /// When using this feature, a Tag For Users under the Age of Consent in Europe (TFUA)
  /// parameter will be included in the ad request. This parameter disables personalized
  /// advertising, including remarketing, for all ad requests. It also disables requests
  /// to third-party ad vendors, such as ad measurement pixels and third-party ad servers.
  ///
  /// [Learn more](https://developers.google.com/admob/android/targeting#users_under_the_age_of_consent)
  ///
  /// Both `setChildDirected` and `setTagForUnderAgeOfConsent` should not be `true`
  /// at the same time. If they are, the child-directed setting takes precedence.
  ///
  /// true = TAG_FOR_UNDER_AGE_OF_CONSENT_TRUE\
  /// false = TAG_FOR_UNDER_AGE_OF_CONSENT_FALSE\
  /// null = TAG_FOR_UNDER_AGE_OF_CONSENT_UNSPECIFIED
  Future<void> setTagForUnderAgeOfConsent(bool underAge) =>
      pluginChannel.invokeMethod('setTagForUnderAgeOfConsent', {'under': underAge});

  /// Apps can set a maximum ad content rating for their ad requests using the
  /// setMaxAdContentRating method. AdMob ads returned when this is configured
  /// have a content rating at or below that level. The possible values for this
  /// network extra are based on digital content label classifications, and must
  /// be one of the following values: 0, 1, 2, 3
  ///
  /// | Max Rating | Digital Content Label | Google Play (Android) | App Store (iOS) |
  /// | :--------: | :-------------------: | :-------------------: | :-------------: |
  /// | 0          | G                     | 3+                    | 4+              |
  /// | 1          | PG                    | 7+                    | 9+              |
  /// | 2          | T                     | 12+                   | 12+             |
  /// | 3          | MA                    | 16+, 18+              | 17+             |
  ///
  /// [Learn more](https://support.google.com/admob/answer/7562142)
  Future<void> setMaxAdContentRating(int maxRating) async {
    assert(maxRating != null, 'Max rating must not be null');
    assert(
      const [RATING_G, RATING_PG, RATING_T, RATING_MA].contains(maxRating),
      'The provided int is not avaiable. Avaiable values: $RATING_G, $RATING_PG, $RATING_T, $RATING_MA',
    );
    await pluginChannel.invokeMethod('setMaxAdContentRating', {'maxRating': maxRating ?? 0});
  }

  /// If your app has its own volume controls (such as custom music or sound effect volumes),
  /// disclosing app volume to the Google Mobile Ads SDK allows video ads to respect app volume
  /// settings. This ensures users receive video ads with the expected audio volume.
  ///
  /// The device volume, controlled through volume buttons or OS-level volume slider, determines
  /// the volume for device audio output. However, apps can independently adjust volume levels
  /// relative to the device volume to tailor the audio experience. You can report the relative
  /// app volume to the Mobile Ads SDK through the static `setAppVolume()` method. Valid ad volume
  /// values range from 0.0 (silent) to 1.0 (current device volume). Here's an example of how to
  /// report the relative app volume to the SDK:
  ///
  /// ```dart
  /// MobileAds.initialize();
  /// // Set app volume to be half of current device volume.
  /// MobileAds.setAppVolume(0.5);
  /// ```
  Future<void> setAppVolume(double volume) {
    assert(volume != null, 'The volume can NOT be null');
    assert(volume >= 0 && volume <= 1, 'The volume must be in bettwen of 0 and 1');
    return pluginChannel.invokeMethod('setAppVolume', {'volume': volume ?? 1});
  }

  /// To inform the SDK that the app volume has been muted, use the `setAppMuted()` method:
  ///
  /// Unmuting the app volume reverts it to the previously set level. By default, the app
  /// volume for the Google Mobile Ads SDK is set to 1 (the current device volume).
  Future<void> setAppMuted([bool muted = true]) {
    return pluginChannel.invokeMethod('setAppMuted', {'muted': muted ?? true});
  }
}
