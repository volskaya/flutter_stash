import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../mobile_ads.dart';
import '../utils.dart';
import 'controller/controller.dart';
import 'layout_builder.dart';

part 'native_ad_builder.freezed.dart';

const _kViewType = 'native_admob';

/// Layout builder of [NativeAd]. It must return [AdLinearLayout].
typedef NativeAdLayoutBuilder = AdLinearLayout Function(NativeAdViewHolder viewHolder);

/// Child widget builder of [NativeAd].
typedef NativeAdChildBuilder = Widget Function(BuildContext context, NativeAdEvent status, Widget platformView);

@freezed
abstract class NativeAdViewHolder with _$NativeAdViewHolder {
  const factory NativeAdViewHolder({
    AdTextView advertiser,
    AdTextView attribution,
    AdTextView body,
    AdTextView headline,
    AdButtonView button,
    AdImageView icon,
    AdMediaView media,
    AdTextView price,
    AdTextView store,
    AdRatingBarView ratingBar,
  }) = _NativeAdViewHolder;
}

/// Uses `NativeAdView` on android and `GADNativeAd` on iOS
///
/// Useful links:
///   - https://developers.google.com/admob/ios/native/start
///   - https://developers.google.com/admob/android/native/start
class NativeAdBuilder extends StatefulWidget {
  /// Creates [NativeAdBuilder].
  const NativeAdBuilder({
    Key key,
    @required this.buildLayout,
    @required this.builder,
    @required this.constraints,
    this.viewHolder,
    this.controller,
    this.height,
    this.width,
  }) : super(key: key);

  /// Constraints where the ad will be built in.
  final BoxConstraints constraints;

  /// Reactive builder of the ad. The `platformView` will be null, when the ad is not loaded.
  final NativeAdChildBuilder builder;

  /// Holder of the description for the inflated views, on the native side.
  final NativeAdViewHolder viewHolder;

  /// How the views should be presented to the user.
  final NativeAdLayoutBuilder buildLayout;

  /// [NativeAdController] of [NativeAdBuilder]. If not specified, constructs its own controller.
  final NativeAdController controller;

  /// The height of the ad. If this is null, the widget will expand
  ///
  /// NOTE: Ad views that have a width or height smaller than 32 will be
  /// demonetized in the future.
  /// Please make sure the ad view has sufficiently large area.
  ///
  /// Usage inside of a `Column` requires an `Expanded` or a defined height.
  /// Usage inside of a `ListView` requires a defined height.
  final double height;

  /// The width of the ad. If this is null, the widget will expand
  ///
  /// NOTE: Ad views that have a width or height smaller than 32 will be
  /// demonetized in the future.
  /// Please make sure the ad view has sufficiently large area.
  ///
  /// Usage inside of a Row requires an Expanded or a defined width.
  /// Usage inside of a ListView requires a defined width.
  final double width;

  static AdLinearLayout bannerLayoutBuilder(NativeAdViewHolder viewHolder) => AdLinearLayout(
        decoration: const AdDecoration(backgroundColor: Colors.white),
        width: MATCH_PARENT,
        height: MATCH_PARENT,
        orientation: LayoutOrientation.horizontal,
        gravity: LayoutGravity.centerVertical,
        children: [
          if (viewHolder.icon != null) viewHolder.icon,
          AdLinearLayout(
            flex: 2,
            width: WRAP_CONTENT,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            children: [
              if (viewHolder.headline != null) viewHolder.headline,
              if (viewHolder.attribution != null || viewHolder.advertiser != null)
                AdLinearLayout(
                  orientation: LayoutOrientation.horizontal,
                  children: [
                    if (viewHolder.attribution != null) viewHolder.attribution,
                    if (viewHolder.advertiser != null) viewHolder.advertiser,
                  ],
                ),
            ],
          ),
          if (viewHolder.button != null)
            AdLinearLayout(
              flex: 4,
              children: [viewHolder.button],
            ),
        ],
      );

  @override
  _NativeAdBuilderState createState() => _NativeAdBuilderState();
}

class _NativeAdBuilderState extends State<NativeAdBuilder> {
  NativeAdController _controller;
  StreamSubscription _controllerSubscription;
  NativeAdEvent state = NativeAdEvent.loading;
  Map<String, dynamic> _layout;
  bool _attached = false;

  Future _requestAdUIUpdate(Map<String, dynamic> layout) =>
      _controller.channel.invokeMethod('updateUI', {'layout': layout ?? {}});

  /// Prevent building platform views, while the scrollable is moving.
  Future _deferredLoad([Duration _]) async {
    if (!mounted) {
      return;
    } else if (Scrollable.recommendIdleLoadingForContext(context)) {
      SchedulerBinding.instance.scheduleFrameCallback(_deferredLoad);
    } else {
      _controller = widget.controller ?? NativeAdController();
      await _controller.load();

      // Check if the user hasn't started scrolling or the widget has disposed,
      // while the ad was loading.
      if (mounted && !Scrollable.recommendIdleLoadingForContext(context)) {
        _controller.attach(this);
        _attached = true;
        _controllerSubscription = _controller.onEvent.listen((e) {
          final event = e.keys.first;
          switch (event) {
            case NativeAdEvent.loading:
            case NativeAdEvent.loaded:
            case NativeAdEvent.loadFailed:
              if (mounted) setState(() => state = event);
              break;
            case NativeAdEvent.undefined:
              if (mounted) setState(() {});
              break;
            case NativeAdEvent.muted:
              break;
          }
        });

        if (_controller.isLoaded) {
          setState(() => state = NativeAdEvent.loaded);
        }
      } else if (mounted) {
        _deferredLoad();
      }
    }
  }

  @override
  void initState() {
    _layout = _constructLayout(widget);
    _deferredLoad();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NativeAdBuilder oldWidget) {
    assert((oldWidget.controller != null) == (widget.controller != null));

    if (oldWidget.viewHolder != widget.viewHolder) {
      _layout = _constructLayout(widget);
      _requestAdUIUpdate(_layout);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controllerSubscription?.cancel();
    if (_attached) _controller?.detach(this);
    if (widget.controller == null) _controller?.dispose();
    super.dispose();
  }

  static Map<String, dynamic> _constructLayout(NativeAdBuilder widget) {
    final viewHolder = NativeAdViewHolder(
      headline: widget.viewHolder?.headline ?? const AdTextView(id: NativeAdSlot.headline),
      advertiser: widget.viewHolder?.advertiser ?? const AdTextView(id: NativeAdSlot.advertiser),
      body: widget.viewHolder?.body ?? const AdTextView(id: NativeAdSlot.body),
      icon: widget.viewHolder?.icon ?? const AdImageView(id: NativeAdSlot.icon),
      media: widget.viewHolder?.media ?? const AdMediaView(id: NativeAdSlot.media),
      price: widget.viewHolder?.price ?? const AdTextView(id: NativeAdSlot.price),
      ratingBar: widget.viewHolder?.ratingBar ?? const AdRatingBarView(id: NativeAdSlot.rating),
      store: widget.viewHolder?.store ?? const AdTextView(id: NativeAdSlot.store),
      button: widget.viewHolder?.button ??
          const AdButtonView(
            id: NativeAdSlot.button,
            highlightColor: Colors.red,
            decoration: AdDecoration(backgroundColor: Colors.yellow),
            margin: EdgeInsets.only(top: 6),
          ),
      attribution: widget.viewHolder?.attribution ??
          const AdTextView(
            id: NativeAdSlot.attribution,
            width: WRAP_CONTENT,
            height: WRAP_CONTENT,
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
            style: NativeTextStyle(textColor: Colors.black, maxLines: 1),
            text: 'Ad',
            margin: EdgeInsets.only(right: 2),
            decoration: AdDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              backgroundColor: Colors.yellow,
            ),
          ),
    );

    final layout = (widget.buildLayout ?? NativeAdBuilder.bannerLayoutBuilder)(viewHolder)?.toJson();
    assert(layout != null, 'The layout must not return null');
    return layout;
  }

  @override
  Widget build(BuildContext context) {
    assertPlatformIsSupported();
    assertVersionIsSupported();

    Widget platformView;

    switch (state) {
      case NativeAdEvent.loadFailed:
      case NativeAdEvent.loading:
      case NativeAdEvent.undefined:
        break; // No platform view for these cases.
      case NativeAdEvent.loaded:
      case NativeAdEvent.muted:
        final params = {..._layout, 'controllerId': _controller.id};
        final height = widget.height ?? widget.constraints.biggest.height;
        final width = widget.width ?? widget.constraints.biggest.width;

        assert(height > 32 && width > 32, 'Please make sure the ad view has sufficiently large area');

        if (Platform.isAndroid) {
          platformView = buildAndroidPlatformView(
            params,
            _kViewType,
            MobileAds.useHybridComposition,
          );
        } else if (Platform.isIOS) {
          platformView = UiKitView(
            viewType: _kViewType,
            creationParamsCodec: const StandardMessageCodec(),
            creationParams: params,
          );
        }

        platformView = SizedBox(
          height: height,
          width: width,
          child: RepaintBoundary(child: platformView),
        );
    }

    return widget.builder(context, state, platformView);
  }
}
