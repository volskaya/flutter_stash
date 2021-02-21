import 'dart:async';

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
    this.preloadIdentifiers = const <String>[],
  }) : super(key: key);

  /// Reactive builder of the ad. The `platformView` will be null, when the ad is not loaded.
  final NativeAdChildBuilder builder;

  /// [NativeAdController] of [NativeAdBuilder]. If not specified, constructs its own controller.
  final NativeAdController controller;

  /// [NativeAdController] IDs to preload, when this widget's deferred load has kicked in.
  final List<String> preloadIdentifiers;

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

  /// Create and load [NativeAdController]s for the given identifiers.
  ///
  /// [NativeAdBuilder] can call this with scroll awareness, if you pass the IDs to the widget.
  static Future preloadControllers(
    BuildContext context,
    List<String> preloadIdentifiers, [
    NativeAdOptions options = const NativeAdOptions(),
  ]) async {
    if (preloadIdentifiers.isEmpty) return;

    final createStorage = (String identifier) => RefreshStorage.write<NativeAdWidgetStateStorage>(
          context: context,
          identifier: identifier,
          builder: () => NativeAdWidgetStateStorage(options: options),
        );

    final futures = preloadIdentifiers.map(
      (identifier) => (() async {
        print('Preloading $identifier');
        RefreshStorageEntry<NativeAdWidgetStateStorage> storage = createStorage(identifier);

        try {
          // Refresh the storage, if the controller is too old.
          if (storage.value?.controller?.considerThisOld() == true) {
            storage.dispose();
            RefreshStorage.destroy(context: context, identifier: identifier);
            storage = createStorage(identifier);
          }

          assert(storage?.value?.controller?.considerThisOld() != true);
          await storage.value?.controller?.load();
        } finally {
          storage.dispose(); // Living in the [RefreshStorage] - not needed here anymore.
        }
      })(),
    );

    await Future.wait(futures);
  }

  @override
  _NativeAdBuilderState createState() => _NativeAdBuilderState();
}

class _NativeAdBuilderState extends State<NativeAdBuilder> {
  NativeAdController _controller;
  bool _hadAttachedToTheController = false;

  Future _preloadControllers() =>
      NativeAdBuilder.preloadControllers(context, widget.preloadIdentifiers, widget.controller.options);

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
