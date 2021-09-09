import 'package:animations/src/inherited_animation/inherited_animation_coordinator.dart';
import 'package:animations/src/inherited_animation/inherited_animation_listenable.dart';
import 'package:animations/src/inherited_animation/inherited_animation_mixin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utils/utils.dart';

class InheritedAnimation extends StatefulWidget {
  const InheritedAnimation({
    Key? key,
    required this.child,
    this.fillColor = Colors.transparent,
    this.opacity = false,
    this.scale = false,
    this.rotation = false,
    this.translation = false,
    this.debug = false,
    this.addRepaintBoundaries = true,
    this.consume = true,
  })  : assert(rotation == false, 'Rotation is not implemented yet'),
        super(key: key);

  final Widget child;
  final bool opacity;
  final bool scale;
  final bool rotation;
  final bool translation;
  final Color fillColor;
  final bool debug;
  final bool addRepaintBoundaries;

  /// Will prevent the used animations from being passed down the widget tree.
  final bool consume;

  static InheritedAnimationListenable? of(BuildContext context, {bool listen = true}) =>
      InheritedAnimationListenable.of(context, listen: listen);

  @override
  State<InheritedAnimation> createState() => _InheritedAnimationState();
}

class _InheritedAnimationState extends State<InheritedAnimation> with InheritedAnimationMixin {
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
      child = Provider<InheritedAnimationListenable?>.value(
        updateShouldNotify: InheritedAnimationCoordinator.handleUpdateShouldNotify,
        child: child,
        value: inheritedAnimation!.copyWith(
          opacity: !widget.opacity,
          scale: !widget.scale,
          rotation: !widget.rotation,
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

    if (widget.translation || widget.scale || widget.rotation) {
      // FIXME: Avoid rebuilds if this animates the same values.
      child = AnimatedBuilder(
        animation: inheritedAnimation!,
        child: child,
        builder: (_, _child) {
          Widget child = _child!;

          if (widget.translation) {
            child = Transform.translate(
              offset: inheritedAnimation!.translation,
              child: child,
            );
          }

          if (widget.scale) {
            child = Transform.scale(
              scale: inheritedAnimation!.scale,
              child: child,
            );
          }

          return child;

          // FIXME: Use 1 [Transform] widget.

          // final toggled = inheritedAnimation!.scale != 1.0 ||
          //     inheritedAnimation!.translation != Offset.zero ||
          //     inheritedAnimation!.rotation != 0.0;

          // final matrix = Matrix4.identity()
          //   ..scale(inheritedAnimation!.scale)
          //   ..translate(inheritedAnimation!.translation.dx, inheritedAnimation!.translation.dy);

          // return Transform(
          //   toggled: toggled,
          //   transform: matrix,
          //   child: child,
          //   origin: Offset.zero,
          // );
        },
      );
    }

    if (widget.opacity) {
      child = _OpacityTransition(
        animation: inheritedAnimation!,
        child: child,
      );
    }

    return child;
  }
}

class _OpacityTransition extends AnimatedListenableWidget<InheritedAnimationListenable, double> {
  const _OpacityTransition({
    Key? key,
    required this.animation,
    required this.child,
  }) : super(key: key, listenable: animation);

  final InheritedAnimationListenable animation;
  final Widget child;

  @override
  double getValue(InheritedAnimationListenable listenable) => listenable.opacity;

  @override
  Widget build(BuildContext context, double opacity) => Opacity(
        opacity: animation.opacity,
        child: child,
      );
}
