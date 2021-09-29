import 'package:animations/src/compound_transition_animation/dual_transition_animation.dart';
import 'package:flutter/material.dart';

typedef DualTransitionAnimationBuilderCallback = List<DualTransitionAnimation>
    Function(Animation<double> animation, Animation<double>? secondaryAnimation);
typedef DualTransitionAnimationWidgetBuilder = Widget
    Function(BuildContext context, List<DualTransitionAnimation> animations, Widget child);

/// The state of [DualTransitionAnimationBuilder] makes sure animations are
/// not rebuilt, unless the [animation] or [secondaryAnimation] does.
///
/// The [animation] and [secondaryAnimation] is intended to be created once
/// for every transitioning child to avoid observers from redoing their subscriptions.
///
/// The [secondaryAnimation] is wrapped in [ReverseAnimation], as expected for
/// the material transitions that will use this widget.
class DualTransitionAnimationBuilder extends StatefulWidget {
  const DualTransitionAnimationBuilder({
    Key? key,
    required this.getAnimations,
    required this.builder,
    required this.child,
    required this.animation,
    this.secondaryAnimation,
    this.onStatusChanged,
    this.onEnd,
  }) : super(key: key);

  final DualTransitionAnimationBuilderCallback getAnimations;
  final DualTransitionAnimationWidgetBuilder builder;
  final Widget child;
  final Animation<double> animation;
  final Animation<double>? secondaryAnimation;
  final ValueChanged<AnimationStatus>? onStatusChanged;
  final VoidCallback? onEnd;

  @override
  DualTransitionAnimationBuilderState createState() => DualTransitionAnimationBuilderState();
}

class DualTransitionAnimationBuilderState extends State<DualTransitionAnimationBuilder> {
  List<DualTransitionAnimation>? _animations;

  /// Uses the first animation as the focus animation for status change listener.
  DualTransitionAnimation? _getFocusAnimation() => _animations?.isNotEmpty == true ? _animations!.first : null;

  void _handleStatusListener(AnimationStatus status) {
    try {
      widget.onStatusChanged?.call(status);
    } finally {
      switch (status) {
        case AnimationStatus.dismissed:
        case AnimationStatus.completed:
          widget.onEnd?.call();
          break;
        case AnimationStatus.forward:
        case AnimationStatus.reverse:
          break;
      }
    }
  }

  void _rebuildAnimations() {
    _getFocusAnimation()?.removeStatusListener(_handleStatusListener);
    _animations = widget.getAnimations(
      widget.animation,
      widget.secondaryAnimation != null ? ReverseAnimation(widget.secondaryAnimation!) : null,
    );

    // Add back the status listener.
    _getFocusAnimation()?.addStatusListener(_handleStatusListener);
  }

  @override
  void initState() {
    super.initState();
    _rebuildAnimations();
  }

  @override
  void dispose() {
    _getFocusAnimation()?.removeStatusListener(_handleStatusListener);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DualTransitionAnimationBuilder oldWidget) {
    final didAnimationsChange =
        oldWidget.animation != widget.animation || oldWidget.secondaryAnimation != widget.secondaryAnimation;

    if (didAnimationsChange) {
      _rebuildAnimations();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _animations!, widget.child);
}
