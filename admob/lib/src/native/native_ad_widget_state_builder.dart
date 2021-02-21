import 'package:admob/src/native/controller/controller.dart';
import 'package:admob/src/native/controller/options.dart';
import 'package:admob/src/native/native_ad_widget_state.dart';
import 'package:flutter/material.dart';

import 'native_ad_builder.dart';

/// This widget is a wrapper around [NativeAdBuilder] & [NativeAdWidgetState].
class NativeAdWidgetStateBuilder extends StatefulWidget {
  const NativeAdWidgetStateBuilder({
    Key key,
    @required this.identifier,
    @required this.builder,
    @required this.errorBuilder,
    @required this.loadingBuilder,
    this.options = const NativeAdOptions(),
    this.layoutBuilder,
    this.preloadIdentifiers = const <String>[],
  }) : super(key: key);

  final String identifier;
  final List<String> preloadIdentifiers;
  final NativeAdOptions options;
  final Widget Function(BuildContext, NativeAdController, NativeAdData) builder;
  final Widget Function(BuildContext, NativeAdController, NativeAdErrorData) errorBuilder;
  final Widget Function(BuildContext, NativeAdController, NativeAdLoadingData) loadingBuilder;
  final Widget Function(BuildContext, Widget) layoutBuilder;

  @override
  _NativeAdWidgetStateBuilderState createState() => _NativeAdWidgetStateBuilderState();
}

class _NativeAdWidgetStateBuilderState extends NativeAdWidgetState<NativeAdWidgetStateBuilder> {
  @override
  String get identifier => widget.identifier;

  @override
  NativeAdOptions get options => widget.options;

  Widget _buildBody(BuildContext context, NativeAd nativeAd) {
    final child = nativeAd.map(
      (data) => KeyedSubtree(
        key: ValueKey(data),
        child: widget.builder(context, controller, data),
      ),
      loading: (data) => KeyedSubtree(
        key: const ValueKey('loading'),
        child: widget.loadingBuilder(context, controller, data),
      ),
      error: (data) => KeyedSubtree(
        key: const ValueKey('error'),
        child: widget.errorBuilder(context, controller, data),
      ),
    );

    return widget.layoutBuilder?.call(context, child) ?? child;
  }

  @override
  Widget build(BuildContext context) => NativeAdBuilder(
        controller: controller,
        builder: _buildBody,
        preloadIdentifiers: widget.preloadIdentifiers,
      );
}
