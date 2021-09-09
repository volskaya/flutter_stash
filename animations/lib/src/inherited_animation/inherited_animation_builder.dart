import 'package:animations/src/inherited_animation/inherited_animation_listenable.dart';
import 'package:animations/src/inherited_animation/inherited_animation_widget.dart';
import 'package:flutter/widgets.dart';

class InheritedAnimationBuilder extends InheritedAnimationWidget {
  const InheritedAnimationBuilder({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final Widget? child;
  final Widget Function(
    BuildContext context,
    InheritedAnimationValue value,
    Widget? child,
  ) builder;

  @override
  Widget build(BuildContext context, InheritedAnimationValue value) => builder(context, value, child);
}
