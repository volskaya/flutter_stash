import 'package:blobs/src/models.dart';
import 'package:blobs/src/painter/tools.dart';
import 'package:flutter/material.dart';

class BlobPainter extends CustomPainter {
  BlobPainter({
    required this.blobData,
    this.styles,
    this.debug = false,
  });

  final BlobData blobData;
  final bool debug;
  final BlobStyle? styles;

  @override
  void paint(Canvas canvas, Size size) {
    drawBlob(canvas, blobData.path, styles);

    if (debug) {
      circle(canvas, size, (size.width / 2.0)); // outer circle
      circle(canvas, size, blobData.points.innerRad); // inner circle
      point(canvas, Offset(size.width / 2.0, size.height / 2.0)); // center point

      final originPoints = blobData.points.originPoints;
      final destPoints = blobData.points.destPoints;

      for (int i = 0; i < originPoints.length; i += 1) {
        drawLines(canvas, originPoints[i], destPoints[i]);
      }
    }
  }

  void drawLines(Canvas canvas, Offset p0, Offset p1) {
    point(canvas, p0);
    point(canvas, p1);
    line(canvas, p0, p1);
  }

  @override
  bool shouldRepaint(BlobPainter oldDelegate) =>
      oldDelegate.blobData != blobData || oldDelegate.styles != styles || oldDelegate.debug != debug;
}
