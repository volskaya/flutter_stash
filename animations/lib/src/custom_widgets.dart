import 'package:flutter/material.dart';
import 'package:sliver_transform/sliver_tranform.dart';

class CustomWidgets {
  static Widget fade({
    Key? key,
    required Animation<double> opacity,
    required Widget child,
    bool sliver = false,
  }) =>
      sliver
          ? SliverFadeTransition(
              key: key,
              opacity: opacity,
              sliver: child,
            )
          : FadeTransition(
              key: key,
              opacity: opacity,
              child: child,
            );

  static Widget translate({
    Key? key,
    required Offset offset,
    required Widget child,
    bool sliver = false,
  }) =>
      sliver
          ? SliverTransform.translate(
              key: key,
              offset: offset,
              sliver: child,
            )
          : Transform.translate(
              key: key,
              offset: offset,
              child: child,
              transformHitTests: false,
            );

  static Widget scale({
    Key? key,
    required Animation<double> scale,
    required Widget child,
    bool sliver = false,
  }) =>
      sliver
          ? _SliverScaleTransition(
              key: key,
              scale: scale,
              sliver: child,
            )
          : ScaleTransition(
              key: key,
              scale: scale,
              child: child,
            );
}

class _SliverScaleTransition extends AnimatedWidget {
  const _SliverScaleTransition({
    Key? key,
    required Animation<double> scale,
    this.alignment = Alignment.center,
    this.sliver,
  }) : super(key: key, listenable: scale);

  final Alignment alignment;
  final Widget? sliver;

  Animation<double> get scale => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final double scaleValue = scale.value;
    final Matrix4 transform = Matrix4.identity()..scale(scaleValue, scaleValue, 1.0);
    return SliverTransform(
      transform: transform,
      alignment: alignment,
      sliver: sliver,
    );
  }
}
