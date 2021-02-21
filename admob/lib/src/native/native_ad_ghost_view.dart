import 'package:admob/src/native/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

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

  final lock = Mutex();
  bool _nativeViewMounted = false;
  bool _mounted = false;
  ModalRoute _modalRoute;

  /// Video ads build a native ad inside a platform view, so don't
  /// mount any background views. This is safe to call though, the
  /// platform will check for video as well.
  Future _mountView() => lock.protect(() async {
        if (_nativeViewMounted || widget.controller.disposed) return;
        await widget.controller.mountView();
        if (_mounted) {
          _nativeViewMounted = true;
        } else {
          widget.controller.unmountView();
        }
      });

  Future _unmountView() => lock.protect(() async {
        if (!_nativeViewMounted || widget.controller.disposed) return;
        await widget.controller.unmountView();
        _nativeViewMounted = false;
      });

  /// When the current route is not active, the view is not mounted.
  void _maybeMountView() => lock.protect(() {
        if (_modalRoute.isCurrent && _mounted && !_nativeViewMounted) {
          _mountView();
        } else if ((!_modalRoute.isCurrent || !_mounted) && _nativeViewMounted) {
          _unmountView();
        }
      });

  @override
  void mount(Element parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _modalRoute = ModalRoute.of(this);
    _mounted = true;
    _mountView();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _modalRoute = ModalRoute.of(this);
    _maybeMountView();
  }

  @override
  void unmount() {
    _mounted = false;
    _unmountView();
    super.unmount();
  }
}
