import 'package:animations/src/inherited_animation/inherited_animation_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:sliver_transform/sliver_tranform.dart';

class Animations {
  static Widget fade({
    Key? key,
    required Animation<double> opacity,
    required Widget child,
    bool sliver = false,
    bool inherit = false,
  }) =>
      inherit
          ? InheritedAnimationCoordinator(opacity: opacity, child: child)
          : sliver
              ? SliverFadeTransition(key: key, opacity: opacity, sliver: child)
              : FadeTransition(key: key, opacity: opacity, child: child);

  static Widget translate({
    Key? key,
    required Animation<Offset> offset,
    required Widget child,
    bool sliver = false,
    bool inherit = false,
  }) =>
      inherit
          ? InheritedAnimationCoordinator(translation: offset, child: child)
          : sliver
              ? _SliverTranslateTransition(key: key, offset: offset, sliver: child)
              : _TranslateTransition(key: key, offset: offset, child: child);

  static Widget scale({
    Key? key,
    required Animation<double> scale,
    required Widget child,
    bool sliver = false,
    bool inherit = false,
  }) =>
      inherit
          ? InheritedAnimationCoordinator(scale: scale, child: child)
          : sliver
              ? _SliverScaleTransition(key: key, scale: scale, sliver: child)
              : ScaleTransition(
                  key: key,
                  scale: scale,
                  child: child,
                  filterQuality: FilterQuality.none,
                );
}

class _SliverScaleTransition extends AnimatedWidget {
  const _SliverScaleTransition({
    Key? key,
    required this.scale,
    this.alignment = Alignment.center,
    this.sliver,
  }) : super(key: key, listenable: scale);

  final Animation<double> scale;
  final Alignment alignment;
  final Widget? sliver;

  @override
  Widget build(BuildContext context) {
    final double scaleValue = scale.value;
    final Matrix4 transform = Matrix4.identity()..scale(scaleValue, scaleValue, 1.0);

    return SliverTransform(
      transform: transform,
      alignment: alignment,
      sliver: sliver,
      toggled: scaleValue != 1.0,
    );
  }
}

class _TranslateTransition extends AnimatedWidget {
  const _TranslateTransition({
    Key? key,
    required this.offset,
    this.child,
    this.transformHitTests = false, // I don't indend these to get transformed in material animations.
  }) : super(key: key, listenable: offset);

  final Widget? child;
  final Animation<Offset> offset;
  final bool transformHitTests;

  @override
  Widget build(BuildContext context) => Transform.translate(
        offset: offset.value,
        child: child,
        transformHitTests: transformHitTests,
      );
}

class _SliverTranslateTransition extends AnimatedWidget {
  const _SliverTranslateTransition({
    Key? key,
    required this.offset,
    this.sliver,
  }) : super(key: key, listenable: offset);

  final Widget? sliver;
  final Animation<Offset> offset;

  @override
  Widget build(BuildContext context) => SliverTransform.translate(
        offset: offset.value,
        sliver: sliver,
      );
}
