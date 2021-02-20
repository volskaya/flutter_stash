import 'package:admob/src/native/controller/controller.dart';
import 'package:flutter/material.dart';

/// Creates a native ghost view, under the `FlutterView`, which is gonna
/// track impressions. All flutter widget ads must have a ghost view, while
/// their built, unless the ad has video media content.
class NativeAdGhostView extends ProxyWidget {
  const NativeAdGhostView({
    Key key,
    @required this.controller,
    @required this.nativeAd,
    @required Widget child,
    this.showingVideoContent = true,
  }) : super(key: key, child: child);

  final NativeAdController controller;
  final NativeAdData nativeAd;
  final bool showingVideoContent;

  @override
  Element createElement() => _Element(this);
}

class _Element extends ProxyElement {
  _Element(NativeAdGhostView widget) : super(widget);

  @override
  NativeAdGhostView get widget => super.widget as NativeAdGhostView;

  @override
  void notifyClients(covariant ProxyWidget oldWidget) {}

  bool _nativeViewMounted = false;
  bool _mounted = false;

  /// Video ads build a native ad inside a platform view, so don't
  /// mount any background views. This is safe to call though, the
  /// platform will check for video as well.
  Future _mountView() async {
    if (!widget.controller.showVideoContent || widget.nativeAd.mediaContent?.hasVideoContent != true) {
      await widget.controller.mountView();
      if (_mounted) {
        _nativeViewMounted = true;
      } else {
        widget.controller.unmountView();
      }
    }
  }

  @override
  void mount(Element parent, dynamic newSlot) {
    _mounted = true;
    _mountView();
    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    _mounted = false;
    if (_nativeViewMounted) widget.controller.unmountView();
    super.unmount();
  }
}
