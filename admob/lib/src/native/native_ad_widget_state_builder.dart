import 'package:admob/src/native/controller/controller.dart';
import 'package:admob/src/native/controller/options.dart';
import 'package:admob/src/native/native_ad_widget_state.dart';
import 'package:flutter/material.dart';

import 'native_ad_builder.dart';

/// This widget is a wrapper around [NativeAdBuilder] & [NativeAdWidgetState].
///
/// [errorBuilder] & [loadingBuilder] can be left undefined to build an [SizedBox.shrink] instead.
class NativeAdWidgetStateBuilder extends StatefulWidget implements NativeAdWidget {
  const NativeAdWidgetStateBuilder({
    Key key,
    @required this.identifier,
    @required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
    this.options = NativeAdOptions.defaultKey,
    this.layoutBuilder,
    this.preloadCount = 1,
    this.controller,
  }) : super(key: key);

  @override
  final String identifier;
  @override
  final String options;
  @override
  final NativeAdController controller;

  final int preloadCount;
  final Widget Function(BuildContext, NativeAdController, NativeAdData) builder;
  final Widget Function(BuildContext, NativeAdController, NativeAdErrorData) errorBuilder;
  final Widget Function(BuildContext, NativeAdController, NativeAdLoadingData) loadingBuilder;
  final Widget Function(BuildContext, Widget) layoutBuilder;

  @override
  _NativeAdWidgetStateBuilderState createState() => _NativeAdWidgetStateBuilderState();
}

class _NativeAdWidgetStateBuilderState extends NativeAdWidgetState<NativeAdWidgetStateBuilder> {
  Widget _buildBody(BuildContext context, NativeAd nativeAd) {
    final child = nativeAd.map(
      (data) => KeyedSubtree(
        key: ValueKey(data.headline), // FIXME: Find a more viable variable to assert equality with.
        child: widget.builder(context, controller, data),
      ),
      loading: (data) => widget.loadingBuilder != null
          ? KeyedSubtree(
              key: const ValueKey('loading'),
              child: widget.loadingBuilder(context, controller, data),
            )
          : const SizedBox.shrink(key: ValueKey('loading')),
      error: (data) => widget.errorBuilder != null
          ? KeyedSubtree(
              key: const ValueKey('error'),
              child: widget.errorBuilder(context, controller, data),
            )
          : const SizedBox.shrink(key: ValueKey('error')),
    );

    return widget.layoutBuilder?.call(context, child) ?? child;
  }

  @override
  Widget build(BuildContext context) => NativeAdBuilder(
        controller: controller,
        builder: _buildBody,
        preloadCount: widget.preloadCount,
      );
}
