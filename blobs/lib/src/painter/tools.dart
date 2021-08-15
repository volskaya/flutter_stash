import 'package:blobs/src/config.dart';
import 'package:blobs/src/models.dart';
import 'package:flutter/material.dart';

void circle(Canvas canvas, Size size, double radius) {
  final paint = Paint()
    ..color = const Color(0xffef5777)
    ..strokeWidth = 3.0
    ..style = PaintingStyle.stroke;

  final path = Path();
  final rect = Rect.fromCircle(
    center: Offset(size.width / 2.0, size.height / 2.0),
    radius: radius,
  );

  path.addOval(rect);
  canvas.drawPath(path, paint);
}

void label(Canvas canvas, String text, Offset offset) {
  final textStyle = TextStyle(color: Colors.black, fontSize: 16.0);
  final textSpan = TextSpan(text: text, style: textStyle);
  final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);

  textPainter.layout(minWidth: 0.0, maxWidth: 100.0);
  textPainter.paint(canvas, offset + Offset(0.0, -20.0));
}

void line(Canvas canvas, Offset start, Offset end) {
  final paint = Paint()
    ..color = const Color(0xff596275).withOpacity(0.5)
    ..strokeWidth = 3
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  canvas.drawLine(start, end, paint);
}

void point(Canvas canvas, Offset center) {
  var paint = Paint()
    ..color = const Color(0xff1e272e)
    ..strokeWidth = 1
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round;

  final path = Path();
  final rect = Rect.fromCircle(center: center, radius: 3);

  path.addOval(rect);
  canvas.drawPath(path, paint);
}

Paint createPaint(BlobStyles? styles) {
  Map<BlobFillType, PaintingStyle> fillType = {
    BlobFillType.fill: PaintingStyle.fill,
    BlobFillType.stroke: PaintingStyle.stroke
  };

  styles ??= const BlobStyles();

  var paint = Paint();
  paint.color = styles.color ?? BlobConfig.color;
  paint.shader = styles.gradient;
  paint.strokeWidth = (styles.strokeWidth ?? BlobConfig.strokeWidth).toDouble();
  paint.style = fillType[styles.fillType ?? BlobConfig.fillType]!;

  return paint;
}

Path connectPoints(BlobCurves curves) {
  final path = Path()..moveTo(curves.start.dx, curves.start.dy);
  for (final curve in curves.curves) {
    path.quadraticBezierTo(curve[0], curve[1], curve[2], curve[3]);
  }

  return path..close();
}

void drawBlob(Canvas canvas, Path path, BlobStyles? styles) => canvas.drawPath(path, createPaint(styles));
