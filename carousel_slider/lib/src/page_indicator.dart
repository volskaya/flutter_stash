import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_indicator.freezed.dart';

enum PageIndicatorLayout { warm, scale }

@freezed
abstract class PageIndicatorProps with _$PageIndicatorProps {
  const factory PageIndicatorProps.warm({
    @required Color color,
    @required Color activeColor,
  }) = _WarmAnimationProps;

  const factory PageIndicatorProps.scale({
    @required Color color,
    @required Color activeColor,
    @required double scale,
  }) = _ScaleAnimationProps;
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key key,
    @required this.count,
    @required this.animation,
    @required this.props,
    this.size = 4.0,
    this.space = 4.0,
    this.axis = Axis.horizontal,
  })  : assert(count != null),
        assert(animation != null),
        super(key: key);

  final ValueListenable<double> animation;
  final Axis axis;
  final double size;
  final double space;
  final int count;
  final PageIndicatorProps props;

  int get _count => count < 1 ? 1 : count;

  @override
  Widget build(BuildContext context) {
    final mainAxisSize = _count * size + (_count - 1) * space;
    final child = SizedBox(
      width: axis == Axis.horizontal ? mainAxisSize : size,
      height: axis == Axis.vertical ? mainAxisSize : size,
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _BasePainter(
            animation: animation,
            props: props,
            axis: axis,
            count: _count,
            space: space,
            diameter: size,
          ),
        ),
      ),
    );

    return IgnorePointer(
      child: props.map(
        warm: (_) => child,
        scale: (_) => ClipRect(child: child),
      ),
    );
  }
}

class _BasePainter extends CustomPainter {
  _BasePainter({
    @required this.animation,
    @required this.props,
    @required this.count,
    @required this.axis,
    @required this.diameter,
    @required this.space,
  })  : _paint = Paint()
          ..color = props.map(
            scale: (props) => props.color,
            warm: (props) => props.color,
          ),
        super(repaint: animation);

  final ValueListenable<double> animation;
  final Axis axis;
  final PageIndicatorProps props;
  final double diameter;
  final double space;
  final int count;

  final Paint _paint;

  double get value => animation.value % count;
  int get index => value.floor();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = diameter / 2;

    // Draws the inactive circles.
    props.map(
      warm: (props) {
        for (var i = 0; i < count; ++i) {
          canvas.drawCircle(
            Offset(
              axis == Axis.horizontal ? i * (diameter + space) + radius : radius,
              axis == Axis.vertical ? i * (diameter + space) + radius : radius,
            ),
            radius,
            _paint,
          );
        }
      },
      scale: (props) {
        for (var i = 0; i < count; ++i) {
          if (index == count - 1 ? i == 0 || i == index : i == index || i == index + 1) continue;
          canvas.drawCircle(
            Offset(
              axis == Axis.horizontal ? i * (diameter + space) + radius : radius,
              axis == Axis.vertical ? i * (diameter + space) + radius : radius,
            ),
            radius * props.scale,
            _paint,
          );
        }
      },
    );

    // Draws the active circles.
    props.when<void>(
      warm: (_, activeColor) {
        final progress = value - index;
        final distance = diameter + space;
        final start = index * (diameter + space);
        final activePaint = Paint()..color = activeColor;

        Rect rect;
        double right, left;

        if (progress > 0.5) {
          if (index != count - 1) {
            left = index * distance + distance * (progress - 0.5) * 2;
            right = start + diameter + distance;
          } else {
            // Wraps around from first to last circles.
            left = 0;
            right = ui.lerpDouble(start + diameter, diameter, progress * 2 - 1);
          }
        } else {
          if (index != count - 1) {
            left = start;
            right = start + diameter + distance * progress * 2;
          } else {
            // Wraps around from first to last circles.
            left = ui.lerpDouble(start, 0, progress * 2);
            right = start + diameter;
          }
        }

        switch (axis) {
          case Axis.horizontal:
            rect = Rect.fromLTRB(left, 0.0, right, diameter);
            break;
          case Axis.vertical:
            rect = Rect.fromLTRB(0, left, diameter, right);
            break;
        }

        canvas.drawPath(const StadiumBorder().getInnerPath(rect), activePaint);
      },
      scale: (color, activeColor, scale) {
        final secondOffset = index == count - 1 ? radius : radius + ((index + 1) * (diameter + space));
        final progress = value - index;
        final activePaint = Paint()..color = Color.lerp(color, activeColor, progress);

        // Last circle.
        canvas.drawCircle(
          Offset(
            axis == Axis.horizontal ? radius + (index * (diameter + space)) : radius,
            axis == Axis.vertical ? radius + (index * (diameter + space)) : radius,
          ),
          ui.lerpDouble(radius, radius * scale, progress),
          activePaint,
        );

        // First circle.
        canvas.drawCircle(
          Offset(
            axis == Axis.horizontal ? secondOffset : radius,
            axis == Axis.vertical ? secondOffset : radius,
          ),
          ui.lerpDouble(radius * scale, radius, progress),
          _paint,
        );
      },
    );
  }

  @override
  bool shouldRepaint(_BasePainter oldDelegate) =>
      oldDelegate.props != props ||
      oldDelegate.count != count ||
      oldDelegate.axis != axis ||
      oldDelegate.diameter != diameter ||
      oldDelegate.space != space ||
      oldDelegate.count != count;
}
