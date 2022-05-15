import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

abstract class InheritedAnimationWidget extends StatefulWidget {
  const InheritedAnimationWidget({
    Key? key,
    bool opacity = false,
    bool translation = false,
    bool scale = false,
  })  : _willChangeOpacity = opacity,
        _willChangeScale = scale,
        _willChangeTranslation = translation,
        _enableRebuilds = opacity || translation || scale,
        super(key: key);

  final bool _willChangeOpacity;
  final bool _willChangeTranslation;
  final bool _willChangeScale;
  final bool _enableRebuilds;

  @override
  _InheritedAnimationWidgetState createState() => _InheritedAnimationWidgetState();

  Widget build(BuildContext context, InheritedAnimation a);
}

class _InheritedAnimationWidgetState extends State<InheritedAnimationWidget>
    with InheritedAnimationMixin<InheritedAnimationWidget> {
  double? _oldOpacity;
  double? _oldScale;
  Offset? _oldTranslation;

  bool _firstChange = true;

  void _maybeMarkNeedsBuild() {
    bool shouldRebuild = false;

    if (widget._willChangeOpacity) {
      final opacity = inheritedAnimation!.opacity;
      if (_oldOpacity != opacity) {
        shouldRebuild = true;
        _oldOpacity = opacity;
      }
    }
    if (widget._willChangeTranslation) {
      final translation = inheritedAnimation!.translation;
      if (_oldTranslation != translation) {
        shouldRebuild = true;
        _oldTranslation = translation;
      }
    }
    if (widget._willChangeScale) {
      final scale = inheritedAnimation!.scale;
      if (_oldScale != scale) {
        shouldRebuild = true;
        _oldScale = scale;
      }
    }

    if (shouldRebuild) markNeedsBuild();
  }

  @override
  void didChangeInheritedAnimation(InheritedAnimation? oldAnimation, InheritedAnimation? animation) {
    super.didChangeInheritedAnimation(oldAnimation, animation);
    assert(mounted);

    if (widget._enableRebuilds) {
      oldAnimation?.removeListener(_maybeMarkNeedsBuild);
      animation?.addListener(_maybeMarkNeedsBuild);
    }

    // Always rebuild for first change, even if `widget.shouldRebuildState` would return false.
    if (_firstChange) {
      _firstChange = false;
      _maybeMarkNeedsBuild();
    }
  }

  @override
  void didUpdateWidget(covariant InheritedAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._enableRebuilds != widget._enableRebuilds) {
      if (widget._enableRebuilds) {
        inheritedAnimation?.addListener(_maybeMarkNeedsBuild);
      } else {
        inheritedAnimation?.removeListener(_maybeMarkNeedsBuild);
      }
    }
  }

  @override
  void dispose() {
    if (widget._enableRebuilds) inheritedAnimation?.removeListener(_maybeMarkNeedsBuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, inheritedAnimation!);
}
