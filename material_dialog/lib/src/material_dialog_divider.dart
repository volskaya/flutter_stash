import 'dart:math' as math;

import 'package:flutter/material.dart';

class MaterialDialogDivider extends StatelessWidget {
  const MaterialDialogDivider({
    Key key,
    this.width = 2.0,
    this.color,
    this.padding = const EdgeInsets.all(16),
    this.capStart,
    this.capEnd,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  final double width;
  final Color color;
  final EdgeInsets padding;
  final bool capStart;
  final bool capEnd;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    Size size;
    switch (axis) {
      case Axis.horizontal:
        size = Size.fromHeight(width);
        break;
      case Axis.vertical:
        size = Size.fromWidth(width);
        break;
    }

    return Padding(
      padding: padding,
      child: CustomPaint(
        size: size,
        painter: _Painter(width, padding, color ?? Theme.of(context).dividerColor, capStart, capEnd),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  _Painter(
    this.width,
    this.padding,
    Color color,
    this.capStart,
    this.capEnd,
  )   : _paint = Paint()..color = color,
        _radius = Radius.circular(width);

  final double width;
  final EdgeInsets padding;
  final Paint _paint;
  final Radius _radius;
  final bool capStart;
  final bool capEnd;

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height >= width);

    final capStart = this.capStart ?? padding.left != 0;
    final capEnd = this.capEnd ?? padding.right != 0;
    final axis = size.aspectRatio >= 1 ? Axis.horizontal : Axis.vertical;

    Rect rect;
    switch (axis) {
      case Axis.horizontal:
        final top = size.height / 2 - width / 2;
        rect = Rect.fromLTRB(0.0, top, size.width, top + width);
        break;
      case Axis.vertical:
        final left = size.width / 2 - width / 2;
        rect = Rect.fromLTRB(left, 0.0, left + width, size.height);
        break;
    }

    if (capStart || capEnd) {
      final rrect = RRect.fromRectAndCorners(
        rect,
        topLeft: capStart ? _radius : Radius.zero,
        bottomLeft: capStart ? _radius : Radius.zero,
        topRight: capEnd ? _radius : Radius.zero,
        bottomRight: capEnd ? _radius : Radius.zero,
      );

      canvas.drawRRect(rrect, _paint);
    } else {
      canvas.drawRect(rect, _paint);
    }
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) =>
      oldDelegate.width != width ||
      oldDelegate.padding != padding ||
      oldDelegate.capStart != capStart ||
      oldDelegate.capEnd != capEnd;
}
