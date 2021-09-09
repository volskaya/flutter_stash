import 'package:animations/src/inherited_animation/inherited_animation_listenable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class InheritedAnimationCoordinator extends StatefulWidget {
  const InheritedAnimationCoordinator({
    Key? key,
    this.child,
    this.opacity,
    this.scale,
    this.rotation,
    this.translation,
    this.inheritParent = true,
  }) : super(key: key);

  final Animation<double>? opacity;
  final Animation<double>? scale;
  final Animation<double>? rotation;
  final Animation<Offset>? translation;
  final Widget? child;
  final bool inheritParent;

  static InheritedAnimationListenable? of(BuildContext context, {bool listen = true}) =>
      InheritedAnimationListenable.of(context, listen: listen);

  static bool handleUpdateShouldNotify(
    InheritedAnimationListenable? a,
    InheritedAnimationListenable? b,
  ) =>
      false;

  static Widget boundary({Key? key, required Widget child}) => Provider<InheritedAnimationListenable?>.value(
        value: null,
        updateShouldNotify: (_, __) => false,
        child: child,
      );

  @override
  _InheritedAnimationCoordinatorState createState() => _InheritedAnimationCoordinatorState();
}

class _InheritedAnimationCoordinatorState extends State<InheritedAnimationCoordinator> {
  InheritedAnimationListenable? _parent;
  InheritedAnimationListenable? _effectiveAnimation;

  void _handleAnimationChange() {
    _effectiveAnimation = InheritedAnimationListenable(
      parent: _parent,
      opacityAnimation: widget.opacity,
      scaleAnimation: widget.scale,
      rotationAnimation: widget.rotation,
      translationAnimation: widget.translation,
    );

    markNeedsBuild();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _parent = widget.inheritParent ? InheritedAnimationListenable.of(context) : null;
    if (_effectiveAnimation == null || _parent != _effectiveAnimation!.parent) {
      _handleAnimationChange();
    }
  }

  @override
  void didUpdateWidget(InheritedAnimationCoordinator oldWidget) {
    final hasChanged = oldWidget.opacity != widget.opacity ||
        oldWidget.scale != widget.scale ||
        oldWidget.rotation != widget.rotation ||
        oldWidget.translation != widget.translation;

    if (hasChanged) _handleAnimationChange();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => Provider<InheritedAnimationListenable?>.value(
        value: _effectiveAnimation!,
        updateShouldNotify: InheritedAnimationCoordinator.handleUpdateShouldNotify,
        child: widget.child,
      );
}
