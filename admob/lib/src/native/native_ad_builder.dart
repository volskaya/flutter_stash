import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refresh_storage/refresh_storage.dart';

import 'controller/controller.dart';
import 'controller/native_ad.dart';
import 'native_ad_widget_state.dart';

/// Child widget builder of [NativeAd].
typedef NativeAdChildBuilder = Widget Function(BuildContext context, NativeAd nativeAd);

class _ChanceStorage extends RefreshStorageItem {
  _ChanceStorage(this.truthy);
  final bool truthy;
}

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
    this.preloadCount = 0,
  }) : super(key: key);

  /// Convenience [math.Random] to use for chance ads.
  static final random = math.Random();

  /// The "crit" rate for [checkChance] to use, when deciding whether to show an ad based on chance.
  static double defaultRate = 0.4;

  /// Reactive builder of the ad. The `platformView` will be null, when the ad is not loaded.
  final NativeAdChildBuilder builder;

  /// [NativeAdController] of [NativeAdBuilder]. If not specified, constructs its own controller.
  final NativeAdController controller;

  /// The amount of [NativeAdController] to keep preloaded, after this controller is used.
  final int preloadCount;

  /// Get the lists child count factoring in ads.
  static int childCount(int length, [int n = 20]) => length + (length / n).floor();

  /// Get the index of an original list item factoring in ads.
  static int childIndex(int length, [int n = 20]) => length - (length / n).floor();

  /// Checks whether to show an ad based on chance.
  static bool checkChance([double rate]) => random.nextDouble() < (rate ?? defaultRate);

  /// Checks whether the [NativeAdController] for this identifier is already in the page storage.
  static bool hasController(BuildContext context, String identifier, {RefreshStorageState storage}) =>
      RefreshStorage.contains(context, identifier, storage: storage);

  /// Checks whether the [NativeAdController] for this identifier is already in
  /// the page storage or the [checkChance] returns true for this call.
  static bool checkChanceFor(BuildContext context, String identifier, [double rate]) =>
      hasController(context, identifier) || checkChance(rate);

  static bool checkChanceForPage(BuildContext context, String identifier, {double rate, RefreshStorageState storage}) {
    // Check if this ad has already been made.
    if (hasController(context, identifier, storage: storage)) return true;

    final key = '${identifier}_native_ad_chance_check';
    final entry = RefreshStorage.write<_ChanceStorage>(
      context: context,
      identifier: key,
      builder: () => _ChanceStorage(checkChance(rate)),
      storage: storage,
    );

    final truthy = entry.value.truthy;
    entry.dispose();
    return truthy;
  }

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

  /// Create and load [NativeAdController]s for the given identifiers.
  ///
  /// [NativeAdBuilder] can call this with scroll awareness, if you pass the IDs to the widget.
  static Future preloadControllers(
    int count, [
    NativeAdOptions options = const NativeAdOptions(),
  ]) async {
    final currentCount = NativeAdController.getFoldedCount(options: options);
    final necessaryCount = count - currentCount;
    if (necessaryCount <= 0) return;

    final futures = List<NativeAdController>.generate(
      necessaryCount,
      (_) => NativeAdController(options: options),
      growable: false,
    ).map((controller) {
      final future = controller.load();
      controller.dispose(); // Disposing early will move the controller to the fold cache.
      return future;
    });

    await Future.wait(futures);
  }

  @override
  _NativeAdBuilderState createState() => _NativeAdBuilderState();
}

class _NativeAdBuilderState extends State<NativeAdBuilder> {
  NativeAdController _controller;
  bool _hadAttachedToTheController = false;

  Future _preloadControllers() => NativeAdBuilder.preloadControllers(
        widget.preloadCount,
        widget.controller.options,
      );

  /// Skip fetching the ad, if the user is scrolling too quick.
  Future _deferredLoad([Duration _]) async {
    if (!mounted) {
      return;
    } else {
      final isReady = _controller.nativeAd?.maybeMap((_) => true, orElse: () => false);
      if (!isReady && Scrollable.recommendDeferredLoadingForContext(context)) {
        WidgetsBinding.instance.addPostFrameCallback(_deferredLoad);
      } else {
        _controller.attach(this);
        _hadAttachedToTheController = true;
        await Future.wait([
          _controller.load(),
          _preloadControllers(),
        ]);
      }
    }
  }

  @override
  void initState() {
    _controller = widget.controller ?? NativeAdController.firstReusable() ?? NativeAdController();
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
    if (_hadAttachedToTheController) _controller?.detach(this);
    if (widget.controller == null) _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _controller.nativeAd);
}
