import 'package:animations/src/inherited_animation/inherited_animation.dart';
import 'package:animations/src/inherited_animation/inherited_animation_widget.dart';
import 'package:flutter/widgets.dart';

class InheritedAnimationBuilder extends InheritedAnimationWidget {
  const InheritedAnimationBuilder({
    Key? key,
    required this.builder,
    this.child,
    this.wrapScale = true,
    this.wrapTranslation = true,
    this.shouldRebuild = InheritedAnimationWidget.defaultShouldRebuildCallback,
  }) : super(key: key);

  final Widget? child;
  final bool wrapScale;
  final bool wrapTranslation;
  final InheritedAnimationWidgetShouldRebuildCallback shouldRebuild;
  final Widget Function(BuildContext context, InheritedAnimationValue value, Widget? child) builder;

  @override
  bool shouldRebuildState(InheritedAnimationValue? oldValue, InheritedAnimationValue? value) =>
      shouldRebuild(oldValue, value);

  @override
  Widget build(BuildContext context, InheritedAnimationValue value) {
    Widget child = builder(context, value, this.child);

    if (wrapTranslation) child = Transform.translate(offset: value.translation, child: child);
    if (wrapScale) child = Transform.scale(scale: value.scale, child: child);

    return child;
  }
}
