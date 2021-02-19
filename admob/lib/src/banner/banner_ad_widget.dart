import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../admob.dart';
import '../utils.dart';
import 'controller.dart';

const _viewType = 'banner_admob';

/// Creates a BannerAd and add it to the widget tree. Uses
/// a [PlatformView] to connect to the AdView in the platform
/// side. Uses:
///   - https://developers.google.com/admob/android/banner on Android
///   - https://developers.google.com/admob/ios/banner on iOS
class BannerAd extends StatefulWidget {
  /// Creates a new Banner Ad.
  /// `size` can NOT be null. If so, an `AssertionError` is thrown
  const BannerAd({
    Key key,
    this.builder,
    this.controller,
    this.size = BannerSize.adaptive,
    this.error,
    this.loading,
    this.unitId,
    this.options = const BannerAdOptions(),
  })  : assert(size != null, 'A size must be set'),
        assert(options != null),
        super(key: key);

  /// The builder of the ad. The ad won't be reloaded if this changes
  ///
  /// DO:
  /// ```dart
  /// BannerAd(
  ///   builder: (context, child) {
  ///     return Container(
  ///       // Applies a blue color to the background.
  ///       // You can use anything here to build the ad.
  ///       // The ad won't be reloaded
  ///       color: Colors.blue,
  ///       child: child,
  ///     );
  ///   }
  /// )
  /// ```
  ///
  /// DON'T:
  /// ```dart
  /// Container(
  ///   color: Colors.blue,
  ///   child: BannerAd(),
  /// )
  /// ```
  final AdBuilder builder;

  /// The error placeholder. If an error happens, this widget will be shown.
  final Widget error;

  /// The loading placeholder. This widget will be shown while the ad is loading.
  final Widget loading;

  /// The controller of the ad.
  /// This controller must be unique and can be used on only one `BannerAd`.
  ///
  /// The ad is loaded automatically when attached and it's not necessary to load it
  /// manually.
  /// You can use the controller to reload the ad:
  /// ```dart
  /// controller.load();
  /// ```
  ///
  /// You can use the controller to listen to events:
  /// ```dart
  /// controller.onEvent.listen((e) {
  ///    final event = e.keys.first;
  ///    final info = e.values.first;
  ///    switch (event) {
  ///     case BannerAdEvent.loading:
  ///       break;
  ///     case BannerAdEvent.loadFailed:
  ///       break;
  ///     case BannerAdEvent.loaded:
  ///       break;
  ///     case BannerAdEvent.undefined:
  ///       break;
  ///     default:
  ///       break;
  ///   }
  /// });
  /// ```
  final BannerAdController controller;

  /// The size of the Ad. `BannerSize.adaptive` is the default.
  /// This can NOT be null. If so, throws an `AssertionError`.
  ///
  /// ## Sizes
  ///
  /// | Name              | `Width`x`Height`   | Availability       |
  /// | ----------------- | ------------------ | ------------------ |
  /// | banner            | 320x50             | Phones and Tablets |
  /// | largeBanner       | 320x100            | Phones and Tablets |
  /// | mediumRectangle   | 320x250            | Phones and Tablets |
  /// | fullBanner        | 468x60             | Tablets            |
  /// | leaderboard       | 728x90             | Tablets            |
  /// | smartBanner       | `?`x(32, 50, 90)   | Phones and Tablets |
  /// | *adaptiveBanner*  | `Screen width`x`?` | Phones and Tablets |
  final Size size;

  /// The unitId used by this `BannerAd`.
  /// If changed after loaded it'll be reloaded with the new ad unit id.\
  /// If null, defaults to `MobileAds.instance.bannerAdUnitId`.
  final String unitId;

  final BannerAdOptions options;

  @override
  _BannerAdState createState() => _BannerAdState();
}

class _BannerAdState extends State<BannerAd> with AutomaticKeepAliveClientMixin<BannerAd> {
  BannerAdController controller;
  BannerAdEvent state = BannerAdEvent.loading;

  double height;

  BannerAdOptions get options => widget.options;

  @override
  void initState() {
    super.initState();
    attachNewController();
    controller.load();
  }

  @override
  void didUpdateWidget(BannerAd oldWidget) {
    assert((oldWidget.controller != null) == (widget.controller != null));
    super.didUpdateWidget(oldWidget);
    // if ((oldWidget.unitId == null && widget.unitId != null) ||
    //     (oldWidget.unitId != widget.unitId)) {
    //   controller.load();
    // }
    // if (oldWidget.controller == null && widget.controller != null) {
    //   attachNewController();
    //   controller.changeController(controller.id);
    //   controller.load();
    // }
  }

  void attachNewController() {
    controller = widget.controller ?? BannerAdController();
    controller.attach(this);
    // controller.onEvent.listen((e) {
    //   final event = e.keys.first;
    //   final info = e.values.first;
    //   switch (event) {
    //     case BannerAdEvent.loading:
    //     case BannerAdEvent.loadFailed:
    //     case BannerAdEvent.loaded:
    //       height = (info as int)?.toDouble();
    //       setState(() => state = event);
    //       break;
    //     default:
    //       break;
    //   }
    // });
  }

  @override
  void dispose() {
    controller?.attach(true);
    if (widget.controller == null) controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    assertPlatformIsSupported();
    assertVersionIsSupported();
    assert(options != null, 'You must set the ad options');

    return LayoutBuilder(
      builder: (context, consts) {
        final height = widget.size.height;
        double width = widget.size.width;

        if (height == -1 && width == -1) {
          width = consts.biggest.width;
        }

        final params = <String, dynamic>{
          'controllerId': controller.id,
          'unitId': widget.unitId ?? MobileAds.instance.bannerAdUnitId,
          'size_height': height ?? -1,
          'size_width': width,
        };

        Widget w;
        if (Platform.isAndroid) {
          w = buildAndroidPlatformView(
            params,
            _viewType,
            MobileAds.instance.useHybridComposition,
          );
        } else if (Platform.isIOS) {
          w = UiKitView(
            viewType: _viewType,
            creationParamsCodec: const StandardMessageCodec(),
            creationParams: params,
          );
        } else {
          return const SizedBox();
        }

        double finalHeight;
        if (this.height != null && !this.height.isNegative) {
          finalHeight = this.height;
        } else if (!height.isNegative)
          finalHeight = height;
        else /* if (height == -1 && width == -2) */ {
          final screenHeight = MediaQuery.of(context).size.height;
          double height;
          if (screenHeight <= 400)
            height = 32;
          else if (screenHeight > 400 || screenHeight <= 720)
            height = 50;
          else
            height = 90;
          finalHeight = height;
        }

        w = SizedBox(height: finalHeight, child: w);
        if (state == BannerAdEvent.loaded) w = widget.builder?.call(context, w) ?? w;

        w = Stack(
          clipBehavior: Clip.none,
          children: [
            w,
            if (state == BannerAdEvent.loading) widget.loading ?? const SizedBox(),
            if (state == BannerAdEvent.loadFailed) widget.error ?? const SizedBox(),
          ],
        );

        return w;
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
