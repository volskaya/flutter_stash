import 'dart:ui' as ui;

import 'package:animations/src/inherited_animation/inherited_animation.dart';
import 'package:animations/src/inherited_animation/inherited_animation_coordinator.dart';
import 'package:animations/src/inherited_animation/inherited_animation_mixin.dart';
import 'package:animations/src/inherited_animation/inherited_animation_variants.dart';
import 'package:flutter/material.dart';

class InheritedAnimationWrap extends StatefulWidget {
  const InheritedAnimationWrap({
    Key? key,
    required this.child,
    this.fillColor = Colors.transparent,
    this.opacity = false,
    this.scale = false,
    this.translation = false,
    this.debug = false,
    this.addRepaintBoundaries = true,
    this.consume = true,
  }) : super(key: key);

  final Widget child;
  final bool opacity;
  final bool scale;
  final bool translation;
  final Color fillColor;
  final bool debug;
  final bool addRepaintBoundaries;

  /// Will prevent the used animations from being passed down the widget tree.
  final bool consume;

  @override
  State<InheritedAnimationWrap> createState() => _InheritedAnimationWrapState();
}

class _InheritedAnimationWrapState extends State<InheritedAnimationWrap> with InheritedAnimationMixin {
  InheritedOpacityAnimation? _opacityAnimation;
  InheritedScaleAnimation? _scaleAnimation;
  InheritedTranslationAnimation? _translationAnimation;

  @override
  void didChangeInheritedAnimation(InheritedAnimation? oldAnimation, InheritedAnimation? animation) {
    super.didChangeInheritedAnimation(oldAnimation, animation);
    if (widget.opacity) _opacityAnimation = inheritedAnimation?.selectOpacityVariant();
    if (widget.scale) _scaleAnimation = inheritedAnimation?.selectScaleVariant();
    if (widget.translation) _translationAnimation = inheritedAnimation?.selectTranslationVariant();
  }

  @override
  void didUpdateWidget(covariant InheritedAnimationWrap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.opacity != widget.opacity) {
      _opacityAnimation = widget.opacity ? inheritedAnimation?.selectOpacityVariant() : null;
    }
    if (oldWidget.scale != widget.scale) {
      _scaleAnimation = widget.scale ? inheritedAnimation?.selectScaleVariant() : null;
    }
    if (oldWidget.translation != widget.translation) {
      _translationAnimation = widget.translation ? inheritedAnimation?.selectTranslationVariant() : null;
    }
  }

  @override
  void markNeedsBuild() {
    super.markNeedsBuild();
    if (widget.debug) {
      print(inheritedAnimation!.freeze()); // ignore: avoid_print
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    if (widget.consume) {
      child = InheritedAnimationCoordinator.provider(
        child: child,
        value: inheritedAnimation!.copyWith(
          opacity: !widget.opacity,
          scale: !widget.scale,
          translation: !widget.translation,
        ),
      );
    }

    if (widget.fillColor != Colors.transparent) {
      child = ColoredBox(child: child, color: widget.fillColor);
    }

    if (widget.addRepaintBoundaries) {
      child = RepaintBoundary(child: child);
    }

    if (widget.opacity) {
      assert(_opacityAnimation != null);
      child = FadeTransition(
        opacity: _opacityAnimation!,
        child: child,
      );
    }

    if (widget.translation) {
      assert(_translationAnimation != null);
      child = AnimatedBuilder(
        animation: _translationAnimation!,
        child: child,
        builder: (_, child) => Transform.translate(
          offset: _translationAnimation!.value,
          child: child,
        ),
      );
    }

    if (widget.scale) {
      assert(_scaleAnimation != null);
      child = AnimatedBuilder(
        animation: _scaleAnimation!,
        child: child,
        builder: (_, child) => Transform.scale(
          scale: _scaleAnimation!.value,
          child: child,
        ),
      );
    }

    return child;
  }
}

extension InheritedOpacityExtension on Color {
  Color withRelativeOpacity(double opacity) {
    if (opacity >= 1.0) return this;
    final a = alpha != 255 ? ui.lerpDouble(0.0, alpha, opacity)!.round() : (255.0 * opacity).round();
    return withAlpha(a);
  }
}
