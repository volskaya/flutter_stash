import 'package:animations/animations.dart';
import 'package:animations/src/inherited_animation/inherited_animation_listenable.dart';
import 'package:animations/src/inherited_animation/inherited_animation_mixin.dart';
import 'package:flutter/widgets.dart';

abstract class InheritedAnimationWidget extends StatefulWidget {
  const InheritedAnimationWidget({Key? key}) : super(key: key);

  Widget build(BuildContext context, InheritedAnimationValue value);

  @override
  _InheritedAnimationWidgetState createState() => _InheritedAnimationWidgetState();
}

class _InheritedAnimationWidgetState extends State<InheritedAnimationWidget>
    with InheritedAnimationMixin<InheritedAnimationWidget> {
  @override
  Widget build(BuildContext context) => widget.build(context, inheritedAnimation!.freeze());
}
