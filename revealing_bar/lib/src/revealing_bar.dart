import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revealing_bar/src/revealing_bar_pod.dart';

/// Optional conditional of [RevealingBar] to further finetune visible condition.
///
/// Return `true` to indicate the bar should be hidden.
typedef RevealingBarConditional = bool Function(bool shouldHide);

/// [RevealingBar] child's custom builder.
typedef RevealingBarBuilder = Widget Function(BuildContext context, Widget? child, bool hide);

/// Abstracts transform animation for revealing bars.
class RevealingBar extends ConsumerWidget {
  /// Creates [RevealingBar]
  const RevealingBar({
    Key? key,
    this.child,
    this.conditional,
    this.alignment = Alignment.topCenter,
    this.builder,
    this.ignoring,
    this.bounceOut = false,
    this.optimizeOutChild = false,
    this.bounceOutDuration = const Duration(milliseconds: 600),
    this.duration = const Duration(milliseconds: 250),
  })  : assert(child != null || builder != null),
        super(key: key);

  /// Optional child  If this is null, [build] must be defined.
  final Widget? child;

  /// Return `true` to indicate the bar should be hidden.
  final RevealingBarConditional? conditional;

  /// Alignment of the slide animation.
  final Alignment alignment;

  /// Optional custom builder, makes [child] ineffective.
  final RevealingBarBuilder? builder;

  /// Whether the pointer should be ignored.
  final bool? ignoring;

  /// Whether to use a bounce out curve, for the reveal animation.
  final bool bounceOut;

  /// Whether to build the [child], when the bar is hidden.
  final bool optimizeOutChild;

  /// Bounce out's animation duration. Bounce out is toggled with [bounceOut].
  final Duration bounceOutDuration;

  /// Toggle animation duration;
  final Duration duration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showBars = ref.watch(RevealingBarPod.provider).value;
    final optimizeOutOffset = optimizeOutChild ? Offset(alignment.x, alignment.y) : null;
    final shouldHide = conditional?.call(!showBars) ?? !showBars;

    return IgnorePointer(
      ignoring: ignoring ?? shouldHide,
      child: builder?.call(context, child, shouldHide) ??
          TweenAnimationBuilder<Offset>(
            duration: !shouldHide && bounceOut ? bounceOutDuration : duration,
            curve: !shouldHide && bounceOut ? Curves.elasticOut : standardEasing,
            tween: Tween<Offset>(end: shouldHide ? optimizeOutOffset ?? Offset(alignment.x, alignment.y) : Offset.zero),
            builder: (_, offset, ___) => FractionalTranslation(
              translation: offset,
              child: offset == optimizeOutOffset ? null : child,
            ),
          ),
    );
  }
}
