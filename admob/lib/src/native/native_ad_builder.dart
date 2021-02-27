import 'dart:async';
import 'dart:math' as math;

import 'package:await_route/await_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refresh_storage/refresh_storage.dart';
import 'package:utils/utils.dart';

import 'controller/controller.dart';
import 'controller/native_ad.dart';

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

  /// Get the lists child count factoring in ads.
  static int childCount(int length, int n, {int offset = 0, bool enabled = true}) {
    assert(offset >= 0 && offset <= n);
    if (!enabled) return length;
    final wrappedOffset = -offset % (n + 1);
    final offsetLength = wrappedOffset == n || (offset < length && length < n && wrappedOffset > length) ? 1 : 0;
    return length + (length / n).floor() + offsetLength;
  }

  /// Get the index of an original list item factoring in ads.
  static int childIndex(int i, int n) => i - ((i + 1) / n).floor();

  /// Return true, if this `i` should belong to an ad item. Mimics the calculation
  /// in [NativeAdBuilder.childBuilder].
  static bool isAdPosition(int i, int n, [int offset = 0]) {
    assert(offset >= 0 && offset <= n);
    final pageLength = n + 1;
    final wrappedOffset = -offset % pageLength;
    final position = i + 1 + wrappedOffset;
    return (position % pageLength) == 0;
  }

  /// Child builder that shows ads every `n` items.
  static Widget childBuilder(
    int i,
    int n, {
    @required Widget Function(int index) adBuilder,
    @required Widget Function(int index) childBuilder,
    int offset = 0,
    bool enabled = true,
  }) {
    assert(offset >= 0 && offset <= n);
    if (!enabled) return childBuilder(i);

    final pageLength = n + 1;
    final wrappedOffset = -offset % pageLength;
    final position = i + 1 + wrappedOffset;
    final adIndex = (position / pageLength).floor();
    return (position % pageLength) == 0 ? adBuilder(adIndex - 1) : childBuilder(i - adIndex);
  }

  static bool _isPreloadingControllers = false;

  /// Create and load [NativeAdController]s for the given identifiers.
  ///
  /// [NativeAdBuilder] can call this with scroll awareness, if you pass the IDs to the widget.
  static Future preloadControllers(int count, [String options = NativeAdOptions.defaultKey]) async {
    if (_isPreloadingControllers) return;

    final currentCount = NativeAdController.getFoldedCount(options: options);
    final necessaryCount = count - currentCount;
    if (necessaryCount <= 0) return;

    _isPreloadingControllers = true;
    try {
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
    } finally {
      _isPreloadingControllers = false;
    }
  }

  @override
  _NativeAdBuilderState createState() => _NativeAdBuilderState();
}

class _NativeAdBuilderState extends State<NativeAdBuilder> with InitialDependencies<NativeAdBuilder> {
  NativeAdController _controller;
  bool _hadAttachedToTheController = false;

  Future _preloadControllers() => NativeAdBuilder.preloadControllers(widget.preloadCount, widget.controller.optionsKey);
  bool _isControllerReady() => _controller.nativeAd?.maybeMap((_) => true, orElse: () => false);

  /// Skip fetching the ad, if the user is scrolling too quick.
  Future _deferredLoad([Duration _]) async {
    if (!mounted) {
      return;
    } else {
      if (!_isControllerReady()) await AwaitRoute.of(context);

      final isReady = _isControllerReady(); // Check again.
      if (!isReady && Scrollable.recommendDeferredLoadingForContext(context)) {
        WidgetsBinding.instance.addPostFrameCallback(_deferredLoad);
      } else {
        _controller.attach(this);
        _hadAttachedToTheController = true;
        if (!isReady) await _controller.load();
      }
    }
  }

  Future _deferredIdleLoad([Duration _]) async {
    if (!mounted) {
      return;
    } else {
      await AwaitRoute.of(context);
      if (Scrollable.recommendIdleLoadingForContext(context)) {
        WidgetsBinding.instance.addPostFrameCallback(_deferredIdleLoad);
      } else {
        await _preloadControllers();
      }
    }
  }

  @override
  void initDependencies() {
    _controller = widget.controller ?? NativeAdController.firstReusable() ?? NativeAdController();
    _deferredLoad();
    if (widget.preloadCount > 0) _deferredIdleLoad();
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
