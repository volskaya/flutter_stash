import 'package:animations/src/inherited_animation/inherited_animation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class InheritedAnimationCoordinator extends StatefulWidget {
  const InheritedAnimationCoordinator({
    Key? key,
    required this.child,
    this.opacity,
    this.scale,
    this.translation,
    this.inheritParent = true,
  }) : super(key: key);

  final Animation<double>? opacity;
  final Animation<double>? scale;
  final Animation<Offset>? translation;
  final Widget child;
  final bool inheritParent;

  static InheritedAnimation? of(BuildContext context, {bool listen = true}) =>
      InheritedAnimation.of(context, listen: listen);

  static bool _handleUpdateShouldNotify(InheritedAnimation? a, InheritedAnimation? b) => false;
  static Widget boundary({Key? key, required Widget child}) => provider(key: key, child: child, value: null);
  static Widget provider({Key? key, required Widget child, required InheritedAnimation? value}) =>
      Provider<InheritedAnimation?>.value(
        value: value,
        updateShouldNotify: _handleUpdateShouldNotify,
        child: child,
      );

  @override
  _InheritedAnimationCoordinatorState createState() => _InheritedAnimationCoordinatorState();
}

class _InheritedAnimationCoordinatorState extends State<InheritedAnimationCoordinator> {
  InheritedAnimation? _parent;
  InheritedAnimation? _effectiveAnimation;

  void _handleAnimationChange() {
    _effectiveAnimation = InheritedAnimation(
      parent: _parent,
      opacityAnimation: widget.opacity,
      scaleAnimation: widget.scale,
      translationAnimation: widget.translation,
    );

    markNeedsBuild();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _parent = widget.inheritParent ? InheritedAnimation.of(context) : null;
    if (_effectiveAnimation == null || _parent != _effectiveAnimation!.parent) {
      _handleAnimationChange();
    }
  }

  @override
  void didUpdateWidget(InheritedAnimationCoordinator oldWidget) {
    final hasChanged = oldWidget.opacity != widget.opacity ||
        oldWidget.scale != widget.scale ||
        oldWidget.translation != widget.translation;

    if (hasChanged) _handleAnimationChange();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => InheritedAnimationCoordinator.provider(
        value: _effectiveAnimation!,
        child: widget.child,
      );
}
