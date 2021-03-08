import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SizeExpandTransition extends SingleChildRenderObjectWidget {
  const SizeExpandTransition({
    @required Widget child,
    @required this.animation,
    this.alignment = Alignment.center,
    this.axis = Axis.vertical,
    this.clip = true,
  }) : super(child: child);

  final Animation<double> animation;
  final Alignment alignment;
  final Axis axis;
  final bool clip;

  @override
  RenderObject createRenderObject(BuildContext context) => RenderSizeTransition(
        animation: animation,
        textDirection: Directionality.of(context),
        alignment: alignment,
        axis: axis,
        clip: clip,
      );

  @override
  void updateRenderObject(BuildContext context, covariant RenderSizeTransition renderObject) {
    renderObject
      ..animation = animation
      ..alignment = alignment
      ..axis = axis
      ..textDirection = Directionality.of(context)
      ..clip = clip;
  }
}

class RenderSizeTransition extends RenderAligningShiftedBox {
  RenderSizeTransition({
    @required this.axis,
    @required Animation<double> animation,
    RenderBox child,
    AlignmentGeometry alignment = Alignment.center,
    TextDirection textDirection,
    this.clip = true,
  }) : super(child: child, alignment: alignment, textDirection: textDirection) {
    this.animation = animation;
  }

  Axis axis;
  bool clip;
  final SizeTween _sizeTween = SizeTween();
  Animation<double> _animation;
  bool _hasVisualOverflow = false;
  Size get _animatedSize => _sizeTween.evaluate(_animation);
  double _lastValue;

  set animation(Animation<double> animation) {
    _animation?.removeListener(_handleAnimation);
    _animation = animation..addListener(_handleAnimation);
  }

  void _handleAnimation() {
    if (_lastValue != _animation.value) markNeedsLayout();
  }

  @override
  void detach() {
    _animation?.removeListener(_handleAnimation);
    _animation = null;
    super.detach();
  }

  @override
  void performLayout() {
    _hasVisualOverflow = false;
    _lastValue = _animation.value;
    final BoxConstraints constraints = this.constraints;
    if (child == null || constraints.isTight) {
      size = _sizeTween.begin = _sizeTween.end = constraints.smallest;
      child?.layout(constraints);
      return;
    }

    child.layout(constraints, parentUsesSize: true);

    _sizeTween.end = debugAdoptSize(child.size);
    switch (axis) {
      case Axis.horizontal:
        _sizeTween.begin = Size(0, _sizeTween.end.height);
        break;
      case Axis.vertical:
        _sizeTween.begin = Size(_sizeTween.end.width, 0);
        break;
    }

    size = constraints.constrain(_animatedSize);
    alignChild();

    if (size.width < _sizeTween.end.width || size.height < _sizeTween.end.height) {
      _hasVisualOverflow = true;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (clip && child != null && _hasVisualOverflow) {
      final Rect rect = Offset.zero & size;
      context.pushClipRect(needsCompositing, offset, rect, super.paint);
    } else {
      super.paint(context, offset);
    }
  }
}
