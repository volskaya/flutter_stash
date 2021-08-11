import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_indicator.freezed.dart';

enum PageIndicatorLayout { warm, scale }

@freezed
class PageIndicatorProps with _$PageIndicatorProps {
  const factory PageIndicatorProps.warm({
    required Color color,
    required Color activeColor,
  }) = _WarmAnimationProps;

  const factory PageIndicatorProps.scale({
    required Color color,
    required Color activeColor,
    required double scale,
  }) = _ScaleAnimationProps;

  const factory PageIndicatorProps.wide({
    required Color color,
    required Color activeColor,
    BorderRadius? borderRadius,
  }) = _WideAnimationProps;
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    required this.count,
    required this.animation,
    required this.props,
    this.size = 4.0,
    this.space = 4.0,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  final ValueListenable<double> animation;
  final Axis axis;
  final double size;
  final double space;
  final int count;
  final PageIndicatorProps props;

  int get _count => count < 1 ? 1 : count;

  @override
  Widget build(BuildContext context) {
    final mainAxisSize = props.maybeMap(
      wide: (_) => double.infinity,
      orElse: () => _count * size + (_count - 1) * space,
    );

    final painterSize = Size(
      axis == Axis.horizontal ? mainAxisSize : size,
      axis == Axis.vertical ? mainAxisSize : size,
    );

    final child = RepaintBoundary(
      child: CustomPaint(
        size: painterSize,
        painter: _BasePainter(
          animation: animation,
          props: props,
          axis: axis,
          count: _count,
          space: space,
          diameter: size,
        ),
      ),
    );

    return IgnorePointer(
      child: props.map(
        warm: (_) => child,
        scale: (_) => ClipRect(child: child),
        wide: (_) => child,
      ),
    );
  }
}

class _BasePainter extends CustomPainter {
  _BasePainter({
    required this.animation,
    required this.props,
    required this.count,
    required this.axis,
    required this.diameter,
    required this.space,
  })  : _paint = Paint()
          ..color = props.map(
            scale: (props) => props.color,
            warm: (props) => props.color,
            wide: (props) => props.color,
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
  int get index => value.toInt();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = diameter / 2.0;

    // Draws the inactive circles.
    props.when(
      wide: (_, __, borderRadius) {
        final space = this.space / 2;
        final spacingWidth = space / (count - 1);
        final rectWidth = size.width / count - space;

        for (int i = 0; i < count; i += 1) {
          final leftInset = (space + (i > 0 ? spacingWidth : 0.0)) * i;
          final left = (rectWidth * i) + leftInset;
          final rect = Offset(left, 0.0) & Size(rectWidth, diameter);

          if (borderRadius != null) {
            final rrect = RRect.fromRectAndCorners(
              rect,
              topLeft: borderRadius.topLeft,
              topRight: borderRadius.topRight,
              bottomLeft: borderRadius.bottomLeft,
              bottomRight: borderRadius.bottomRight,
            );
            canvas.drawRRect(rrect, _paint);
          } else {
            canvas.drawRect(rect, _paint);
          }
        }
      },
      warm: (_, __) {
        for (int i = 0; i < count; i += 1) {
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
      scale: (_, __, scale) {
        for (int i = 0; i < count; i += 1) {
          if (index == count - 1 ? i == 0 || i == index : i == index || i == index + 1) continue;
          canvas.drawCircle(
            Offset(
              axis == Axis.horizontal ? i * (diameter + space) + radius : radius,
              axis == Axis.vertical ? i * (diameter + space) + radius : radius,
            ),
            radius * scale,
            _paint,
          );
        }
      },
    );

    // Draws the active circles.
    props.when(
      wide: (_, activeColor, borderRadius) {
        final activePaint = Paint()..color = activeColor;
        final space = this.space / 2;
        final spacingWidth = space / (count - 1);
        final rectWidth = size.width / count - space;

        final progress = value - index;
        final distance = rectWidth + spacingWidth + space;
        final offset = (space + (index > 0 ? spacingWidth : 0.0)) * index;
        final start = rectWidth * index + offset;

        Rect rect;
        double right, left;

        if (progress > 0.5) {
          if (index != count - 1) {
            left = distance * index + distance * (progress - 0.5) * 2.0;
            right = start + rectWidth + distance;
          } else {
            // Wraps around from first to last circles.
            left = 0.0;
            right = ui.lerpDouble(start + rectWidth, rectWidth, progress * 2.0 - 1.0)!;
          }
        } else {
          if (index != count - 1) {
            left = start;
            right = start + rectWidth + distance * progress * 2.0;
          } else {
            // Wraps around from first to last circles.
            left = ui.lerpDouble(start, 0.0, progress * 2.0)!;
            right = start + rectWidth;
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

        if (borderRadius != null) {
          final rrect = RRect.fromRectAndCorners(
            rect,
            topLeft: borderRadius.topLeft,
            topRight: borderRadius.topRight,
            bottomLeft: borderRadius.bottomLeft,
            bottomRight: borderRadius.bottomRight,
          );
          canvas.drawRRect(rrect, activePaint);
        } else {
          canvas.drawRect(rect, activePaint);
        }
      },
      warm: (_, activeColor) {
        final progress = value - index;
        final distance = diameter + space;
        final start = index * (diameter + space);
        final activePaint = Paint()..color = activeColor;

        Rect rect;
        double right, left;

        if (progress > 0.5) {
          if (index != count - 1) {
            left = index * distance + distance * (progress - 0.5) * 2.0;
            right = start + diameter + distance;
          } else {
            // Wraps around from first to last circles.
            left = 0.0;
            right = ui.lerpDouble(start + diameter, diameter, progress * 2.0 - 1.0)!;
          }
        } else {
          if (index != count - 1) {
            left = start;
            right = start + diameter + distance * progress * 2.0;
          } else {
            // Wraps around from first to last circles.
            left = ui.lerpDouble(start, 0.0, progress * 2.0)!;
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
        final activePaint = Paint()..color = Color.lerp(color, activeColor, progress)!;

        // Last circle.
        canvas.drawCircle(
          Offset(
            axis == Axis.horizontal ? radius + (index * (diameter + space)) : radius,
            axis == Axis.vertical ? radius + (index * (diameter + space)) : radius,
          ),
          ui.lerpDouble(radius, radius * scale, progress)!,
          activePaint,
        );

        // First circle.
        canvas.drawCircle(
          Offset(
            axis == Axis.horizontal ? secondOffset : radius,
            axis == Axis.vertical ? secondOffset : radius,
          ),
          ui.lerpDouble(radius * scale, radius, progress)!,
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
