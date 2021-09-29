import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:fading_tile/src/fading_tile_controller.dart';
import 'package:fading_tile/src/fading_tile_mixin.dart';
import 'package:fading_tile/src/size_expand_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum FadingTileType {
  fade,
  slideLeft,
  slideRight,
  slideBottom,
  slideTop,
  scaleUp,
}

/// Fades in and staggers list tiles.
///
/// Must be a descendant of [FadingTileController].
class FadingTile extends StatefulWidget with FadingTileWidget {
  /// Creates [FadingTile] without size animation.
  FadingTile({
    Key? key,
    FadingTileType? type,
    required this.child,
    required this.index,
    this.paginatorIndex,
    this.fade = true,
    this.paginator,
  })  : alignment = null,
        axis = null,
        clipBehavior = Clip.antiAlias,
        optimizeOutChild = false,
        type = type ?? defaultType,
        sizeDuration = defaultSizeDuration,
        _size = false,
        super(key: key);

  /// Creates [FadingTile] with size animation.
  FadingTile.size({
    Key? key,
    FadingTileType? type,
    Duration? sizeDuration,
    required this.child,
    required this.index,
    this.paginatorIndex,
    this.alignment = Alignment.topCenter,
    this.axis = Axis.vertical,
    this.clipBehavior = Clip.antiAlias,
    this.optimizeOutChild = false,
    this.fade = true,
    this.paginator,
  })  : type = type ?? defaultType,
        sizeDuration = sizeDuration ?? defaultSizeDuration,
        _size = true,
        super(key: key);

  static FadingTileType defaultType = FadingTileType.scaleUp;
  static Duration defaultDuration = const Duration(milliseconds: 500);
  static Duration defaultSizeDuration = const Duration(milliseconds: 250);
  static Duration defaultStaggerDuration = const Duration(milliseconds: 20);

  final bool _size;

  /// Child widget to fade in.
  final Widget child;

  /// Index of the child in the list.
  @override final int index;

  /// Index of the child in the list.
  final int? paginatorIndex;

  /// Fade in animation type.
  final FadingTileType type;

  /// Alignment of the child in the size animation.
  final Alignment? alignment;

  /// Scroll axis of the list, where this [FadingTile] is built.
  final Axis? axis;

  /// The [Clip] to pass to the nested size animation.
  final Clip clipBehavior;

  /// While the animation is dismissed and [optimizeOutChild] is true, the
  /// child widget won't be built.
  final bool optimizeOutChild;

  /// Whether to use the fade animation.
  final bool fade;

  /// Intended duration of the size animation. If this is lower than the fade animation,
  /// size will be animated with an [Interval].
  final Duration sizeDuration;

  /// Callback to call when the element for this widget is mounted.
  final VoidCallback? Function(int index)? paginator;

  @override
  VoidCallback? getPaginator(int index) => paginator?.call(index);

  @override
  State<FadingTile> createState() => _FadingTileState();
}

class _FadingTileState extends State<FadingTile> with FadingTileStateMixin<FadingTile> {
  static final _curve = CurveTween(curve: Curves.easeOutExpo);
  static final _slideFromLeftTween = Tween<double>(begin: -1.0, end: 0.0).chain(_curve);
  static final _slideFromRightTween = Tween<double>(begin: 1.0, end: 0.0).chain(_curve);
  static final _slideFromBottomTween = Tween<double>(begin: 1.0, end: 0.0).chain(_curve);
  static final _scaleInTween = Tween<double>(begin: 0.0, end: 1.0).chain(_curve);

  @override
  Widget build(BuildContext context) {
    // Controller is usually not returned anymore, when the tile has faded out and it has disposed.
    // To ease off GC, don't wrap the child in animations.
    if (fadeAnimationController == null || !widget.fade) return widget.child;

    Widget tile;

    switch (widget.type) {
      case FadingTileType.fade:
        tile = _FadeTroughTransitionZoomedFadeIn(
          animation: fadeAnimationController!,
          child: widget.child,
        );
        break;
      case FadingTileType.slideLeft:
        final animation = _slideFromLeftTween.animate(fadeAnimationController!);
        tile = AnimatedBuilder(
          animation: animation,
          builder: (_, __) => FractionalTranslation(
            translation: Offset(animation.value, 0.0),
            child: widget.child,
          ),
        );
        break;
      case FadingTileType.slideRight:
        final animation = _slideFromRightTween.animate(fadeAnimationController!);
        tile = AnimatedBuilder(
          animation: animation,
          builder: (_, __) => FractionalTranslation(
            translation: Offset(animation.value, 0.0),
            child: widget.child,
          ),
        );
        break;
      case FadingTileType.slideBottom:
        final mediaQuery = MediaQuery.of(context);
        final animation = _slideFromBottomTween.animate(fadeAnimationController!);
        tile = AnimatedBuilder(
          animation: animation,
          builder: (_, __) => Transform.translate(
            offset: Offset(0.0, mediaQuery.size.height * animation.value),
            child: widget.child,
          ),
        );
        break;
      case FadingTileType.slideTop:
        final mediaQuery = MediaQuery.of(context);
        final animation = _slideFromBottomTween.animate(fadeAnimationController!);
        tile = AnimatedBuilder(
          animation: animation,
          builder: (_, __) => Transform.translate(
            offset: Offset(0.0, -(mediaQuery.size.height * animation.value)),
            child: widget.child,
          ),
        );
        break;
      case FadingTileType.scaleUp:
        final animation = _scaleInTween.animate(fadeAnimationController!);
        tile = AnimatedBuilder(
          animation: animation,
          builder: (_, __) => Transform.scale(
            scale: animation.value,
            child: widget.child,
            filterQuality: FilterQuality.none,
          ),
        );
        break;
    }

    if (widget._size) {
      final CurveTween tween;

      // Clamp the size animation's interval if its duration is smaller than the fade animation's duration.
      if (fadeAnimationController!.duration != null && widget.sizeDuration < fadeAnimationController!.duration!) {
        final end = widget.sizeDuration.inMicroseconds / fadeAnimationController!.duration!.inMicroseconds;
        final interval = Interval(0.0, end, curve: decelerateEasing);

        tween = CurveTween(curve: interval);
      } else {
        tween = CurveTween(curve: decelerateEasing);
      }

      tile = _SizeInTransition(
        animation: fadeAnimationController!.drive(tween),
        child: tile,
        alignment: widget.alignment!,
        axis: widget.axis!,
        clip: widget.clipBehavior != Clip.none,
        optimizeOutChild: widget.optimizeOutChild,
        fade: widget.fade,
      );
    }

    return tile;
  }
}

class _FadeTroughTransitionZoomedFadeIn extends StatelessWidget {
  const _FadeTroughTransitionZoomedFadeIn({
    required this.child,
    required this.animation,
  });

  final Widget child;
  final Animation<double> animation;

  static final CurveTween _inCurve = CurveTween(curve: const Cubic(0.0, 0.0, 0.2, 1.0));
  static final TweenSequence<double> _scaleIn = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: ConstantTween<double>(0.92), weight: 6 / 20),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0.92, end: 1.0).chain(_inCurve), weight: 14 / 20),
    ],
  );
  static final TweenSequence<double> _fadeInOpacity = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: ConstantTween<double>(0.0), weight: 6 / 20),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0, end: 1.0).chain(_inCurve), weight: 14 / 20),
    ],
  );

  @override
  Widget build(BuildContext context) => Animations.fade(
        opacity: _fadeInOpacity.animate(animation),
        child: Animations.scale(
          scale: _scaleIn.animate(animation),
          child: child,
        ),
      );
}

class _SizeInTransition extends StatelessWidget {
  const _SizeInTransition({
    required this.child,
    required this.animation,
    this.alignment = Alignment.topCenter,
    this.axis = Axis.vertical,
    this.clip = true,
    this.optimizeOutChild = false,
    this.fade = true,
  });

  final Widget child;
  final Animation<double> animation;
  final Alignment alignment;
  final Axis axis;
  final bool clip;
  final bool optimizeOutChild;
  final bool fade;

  @override
  Widget build(BuildContext context) => SizeExpandTransition(
        animation: animation,
        alignment: alignment,
        axis: axis,
        clip: clip,
        child: !optimizeOutChild
            ? child
            : AnimatedBuilder(
                animation: animation,
                builder: (_, __) => animation.isDismissed ? const SizedBox() : child,
              ),
      );
}
