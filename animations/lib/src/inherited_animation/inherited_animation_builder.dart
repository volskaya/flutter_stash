import 'package:animations/src/inherited_animation/inherited_animation.dart';
import 'package:animations/src/inherited_animation/inherited_animation_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:nil/nil.dart';

class InheritedAnimationBuilder extends InheritedAnimationWidget {
  const InheritedAnimationBuilder({
    Key? key,
    this.builder,
    this.child,
    this.wrapScale = false,
    this.wrapTranslation = false,
    this.shouldRebuild = InheritedAnimationWidget.defaultShouldRebuildCallback,
  })  : assert(builder != null || child != null, 'Define a builder or a child'),
        assert(builder != null || (child != null && (wrapScale || wrapTranslation))),
        super(key: key);

  final Widget? child;
  final bool wrapScale;
  final bool wrapTranslation;
  final InheritedAnimationWidgetShouldRebuildCallback shouldRebuild;
  final Widget Function(BuildContext context, InheritedAnimationValue value, Widget? child)? builder;

  @override
  bool shouldRebuildState(InheritedAnimationValue? oldValue, InheritedAnimationValue? value) =>
      shouldRebuild(oldValue, value);

  @override
  Widget build(BuildContext context, InheritedAnimationValue value) {
    Widget child = builder?.call(context, value, this.child) ?? this.child ?? nil;

    // If the widget was used properly, the child shouldn't be null here.
    assert(child != nil);

    if (wrapTranslation) child = Transform.translate(offset: value.translation, child: child);
    if (wrapScale) child = Transform.scale(scale: value.scale, child: child);

    return child;
  }
}
