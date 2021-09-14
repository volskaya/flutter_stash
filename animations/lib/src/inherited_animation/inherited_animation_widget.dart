import 'package:animations/animations.dart';
import 'package:animations/src/inherited_animation/inherited_animation_mixin.dart';
import 'package:flutter/widgets.dart';

typedef InheritedAnimationWidgetShouldRebuildCallback = bool
    Function(InheritedAnimationValue? oldValue, InheritedAnimationValue? value);

abstract class InheritedAnimationWidget extends StatefulWidget {
  const InheritedAnimationWidget({
    Key? key,
    this.enableRebuilds = true,
  }) : super(key: key);

  final bool enableRebuilds;
  Widget build(BuildContext context, InheritedAnimationValue value);
  bool shouldRebuildState(
    InheritedAnimationValue? oldValue,
    InheritedAnimationValue? value,
  ) =>
      InheritedAnimationWidget.defaultShouldRebuildCallback(oldValue, value);

  static bool defaultShouldRebuildCallback(
    InheritedAnimationValue? oldValue,
    InheritedAnimationValue? value,
  ) =>
      oldValue != value;

  @override
  _InheritedAnimationWidgetState createState() => _InheritedAnimationWidgetState();
}

class _InheritedAnimationWidgetState extends State<InheritedAnimationWidget>
    with InheritedAnimationMixin<InheritedAnimationWidget> {
  InheritedAnimationValue? _value;
  bool _firstChange = true;

  void _maybeMarkNeedsBuild() {
    final value = inheritedAnimation?.freeze();
    if (widget.shouldRebuildState(_value, value)) {
      _value = value;
      markNeedsBuild();
    }
  }

  @override
  void didChangeInheritedAnimation(InheritedAnimation? oldAnimation, InheritedAnimation? animation) {
    super.didChangeInheritedAnimation(oldAnimation, animation);
    assert(mounted);

    if (widget.enableRebuilds) {
      oldAnimation?.removeListener(_maybeMarkNeedsBuild);
      animation?.addListener(_maybeMarkNeedsBuild);
    }

    if (_firstChange) {
      _firstChange = false;
      _maybeMarkNeedsBuild();
    }
  }

  @override
  void didUpdateWidget(covariant InheritedAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enableRebuilds != widget.enableRebuilds) {
      if (widget.enableRebuilds) {
        inheritedAnimation?.addListener(_maybeMarkNeedsBuild);
      } else {
        inheritedAnimation?.removeListener(_maybeMarkNeedsBuild);
      }
    }
  }

  @override
  void dispose() {
    if (widget.enableRebuilds) inheritedAnimation?.removeListener(_maybeMarkNeedsBuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, _value ?? const InheritedAnimationValue());
}
