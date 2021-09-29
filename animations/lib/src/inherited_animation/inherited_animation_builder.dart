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
    bool willChangeOpacity = true,
    bool willChangeScale = false,
    bool willChangeTranslation = false,
  })  : assert(builder != null || child != null, 'Define a builder or a child'),
        assert(builder != null || (child != null && (wrapScale || wrapTranslation))),
        super(
          key: key,
          opacity: willChangeOpacity,
          scale: wrapScale || willChangeScale,
          translation: wrapTranslation || willChangeTranslation,
        );

  final Widget? child;
  final bool wrapScale;
  final bool wrapTranslation;
  final Widget Function(BuildContext context, InheritedAnimation a, Widget? child)? builder;

  @override
  Widget build(BuildContext context, InheritedAnimation a) {
    Widget child = builder?.call(context, a, this.child) ?? this.child ?? nil;

    // If the widget was used properly, the child shouldn't be null here.
    assert(child != nil);

    if (wrapTranslation) child = Transform.translate(offset: a.translation, child: child);
    if (wrapScale) child = Transform.scale(scale: a.scale, child: child);

    return child;
  }
}
