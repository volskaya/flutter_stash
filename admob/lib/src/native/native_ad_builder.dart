import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils.dart';
import 'controller/controller.dart';
import 'controller/native_ad.dart';

/// Child widget builder of [NativeAd].
typedef NativeAdChildBuilder = Widget Function(BuildContext context, NativeAd nativeAd);

/// Uses `NativeAdView` on android and `GADNativeAd` on iOS
///
/// Useful links:
///   - https://developers.google.com/admob/ios/native/start
///   - https://developers.google.com/admob/android/native/start
class NativeAdBuilder extends StatefulObserverWidget {
  /// Creates [NativeAdBuilder].
  const NativeAdBuilder({
    Key key,
    @required this.builder,
    this.controller,
  }) : super(key: key);

  /// Reactive builder of the ad. The `platformView` will be null, when the ad is not loaded.
  final NativeAdChildBuilder builder;

  /// [NativeAdController] of [NativeAdBuilder]. If not specified, constructs its own controller.
  final NativeAdController controller;

  /// Get the lists child count factoring in ads.
  static int childCount(int length, [int n = 20]) => length + (length / n).floor();

  /// Get the index of an original list item factoring in ads.
  static int childIndex(int length, [int n = 20]) => length - (length / n).floor();

  /// Child builder that shows ads every `n` items.
  static Widget childBuilder(
    int i,
    int n, {
    @required Widget Function(int index) adBuilder,
    @required Widget Function(int index) childBuilder,
  }) {
    final length = i + 1;
    final adIndex = (length / (n + 1)).floor();
    return length >= n && (length % (n + 1)) == 0 ? adBuilder(adIndex) : childBuilder(i - adIndex);
  }

  @override
  _NativeAdBuilderState createState() => _NativeAdBuilderState();
}

class _NativeAdBuilderState extends State<NativeAdBuilder> {
  NativeAdController _controller;

  /// Skip fetching the ad, if the user is scrolling too quick.
  Future _deferredLoad([Duration _]) async {
    if (!mounted) {
      return;
    } else {
      final isReady = _controller.nativeAd?.maybeMap((_) => true, orElse: () => false);
      if (!isReady && Scrollable.recommendDeferredLoadingForContext(context)) {
        WidgetsBinding.instance.addPostFrameCallback(_deferredLoad);
      } else {
        await _controller.load();
      }
    }
  }

  @override
  void initState() {
    _controller = widget.controller ?? NativeAdController();
    _deferredLoad();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NativeAdBuilder oldWidget) {
    assert(oldWidget.controller == widget.controller);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assertPlatformIsSupported();
    assertVersionIsSupported();

    return widget.builder(context, _controller.nativeAd);
  }
}
