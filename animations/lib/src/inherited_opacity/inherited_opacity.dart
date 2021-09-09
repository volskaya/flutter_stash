import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InheritedOpacity extends StatefulWidget {
  const InheritedOpacity({
    Key? key,
    required this.opacity,
    this.child,
  }) : super(key: key);

  final Animation<double> opacity;
  final Widget? child;

  static InheritedOpacityAnimation? of(BuildContext context, {bool listen = true}) =>
      InheritedOpacityAnimation.of(context, listen: listen);

  @override
  State<InheritedOpacity> createState() => _InheritedOpacityState();
}

class _InheritedOpacityState extends State<InheritedOpacity> {
  InheritedOpacityAnimation? _parent;
  InheritedOpacityAnimation? _effectiveAnimation;

  @override
  void initState() {
    super.initState();
    print('New state in ${_debugTree()}');
  }

  void _handleAnimationChange() {
    _effectiveAnimation = InheritedOpacityAnimation(animation: widget.opacity, parent: _parent);
    markNeedsBuild();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _parent = InheritedOpacityAnimation.of(context);
    if (_effectiveAnimation == null || _parent != _effectiveAnimation!.parent) {
      if (_effectiveAnimation != null) print('Parent changed, ${_getChildUntilNotNull(widget.child)}');
      _handleAnimationChange();
    }
  }

  @override
  void didUpdateWidget(covariant InheritedOpacity oldWidget) {
    if (oldWidget.opacity != widget.opacity) _handleAnimationChange();
    super.didUpdateWidget(oldWidget);
  }

  bool _handleUpdateShouldNotify(InheritedOpacityAnimation a, InheritedOpacityAnimation b) {
    // print('${a.hashCode} != ${b.hashCode} == ${a != b} - ${_debugTree()}');
    // return a.value != b.value;
    return false;
  }

  @override
  Widget build(BuildContext context) => Provider<InheritedOpacityAnimation>.value(
        value: _effectiveAnimation!,
        updateShouldNotify: _handleUpdateShouldNotify,
        child: widget.child,
      );

  String _debugTree() => _getChildUntilNotNull(widget.child);

  String _getChildUntilNotNull(dynamic object, {int skip = 0}) {
    final buffer = StringBuffer();

    int i = 0;
    dynamic child;

    try {
      child = object.child;
      if (i >= skip) buffer.write(child.toString());
      i += 1;
    } catch (_) {}

    while (child != null) {
      try {
        if (child?.child != null) {
          child = child.child;
          if (i >= skip) buffer.write(' -> $child');
          i += 1;
        } else {
          break;
        }
      } catch (_) {
        break;
      }
    }

    return buffer.toString();
  }
}

class InheritedOpacityAnimation implements ValueListenable<double> {
  const InheritedOpacityAnimation({
    required this.parent,
    required this.animation,
  });

  static InheritedOpacityAnimation? of(BuildContext context, {bool listen = true}) {
    try {
      return Provider.of<InheritedOpacityAnimation>(context, listen: listen);
    } catch (_) {}
  }

  final InheritedOpacityAnimation? parent;
  final Animation<double> animation;

  String _printValue() {
    final buffer = StringBuffer();
    InheritedOpacityAnimation? parent = this.parent;

    while (parent != null) {
      buffer.write(' <- ${parent.value.toStringAsFixed(2)}');
      parent = parent.parent;
    }

    return buffer.toString();
  }

  @override
  String toString() {
    final effectiveValue =
        (parent != null ? math.min(parent!.value, animation.value) : animation.value).toStringAsFixed(2);
    final value = animation.value.toStringAsFixed(4);
    return '$runtimeType:$hashCode : $value ($effectiveValue)${_printValue()}';
  }

  @override
  double get value => parent != null ? math.min(parent!.value, animation.value) : animation.value;

  /// Calls the listener every time the value of the animation changes.
  ///
  /// Listeners can be removed with [removeListener].
  void addListener(VoidCallback listener) {
    parent?.addListener(listener);
    animation.addListener(listener);
  }

  /// Stop calling the listener every time the value of the animation changes.
  ///
  /// Listeners can be added with [addListener].
  void removeListener(VoidCallback listener) {
    parent?.removeListener(listener);
    animation.removeListener(listener);
  }
}

extension InheritedOpacityExtension on Color {
  Color withRelativeOpacity(double opacity) {
    final a = alpha != 255 ? lerpDouble(0.0, alpha, opacity)!.round() : (255.0 * opacity).round();
    return withAlpha(a);
  }
}
