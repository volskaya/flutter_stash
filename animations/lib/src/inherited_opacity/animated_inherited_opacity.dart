import 'package:animations/src/inherited_opacity/inherited_opacity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnimatedInheritedOpacity extends ImplicitlyAnimatedWidget {
  const AnimatedInheritedOpacity({
    Key? key,
    this.child,
    required this.opacity,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) : assert(opacity >= 0.0 && opacity <= 1.0),
       super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final Widget? child;
  final double opacity;

  @override
  ImplicitlyAnimatedWidgetState<AnimatedInheritedOpacity> createState() => _AnimatedInheritedOpacityState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('opacity', opacity));
  }
}

class _AnimatedInheritedOpacityState extends ImplicitlyAnimatedWidgetState<AnimatedInheritedOpacity> {
  Tween<double>? _opacity;
  late Animation<double> _opacityAnimation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _opacity = visitor(_opacity, widget.opacity, (dynamic value) => Tween<double>(begin: value as double)) as Tween<double>?;
  }

  @override
  void didUpdateTweens() {
    _opacityAnimation = animation.drive(_opacity!);
  }

  @override
  Widget build(BuildContext context) {
    return InheritedOpacity(
      opacity: _opacityAnimation,
      child: widget.child,
    );
  }
}