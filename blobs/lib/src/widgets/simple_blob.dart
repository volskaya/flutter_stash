import 'package:blobs/blobs.dart';
import 'package:blobs/src/models.dart';
import 'package:blobs/src/painter/painter.dart';
import 'package:flutter/material.dart';

class SimpleBlob extends StatelessWidget {
  const SimpleBlob({
    Key? key,
    required this.blobData,
    this.size,
    this.debug = false,
    this.styles,
    this.child,
  }) : super(key: key);

  final Size? size;
  final BlobData blobData;
  final bool debug;
  final Widget? child;
  final BlobStyle? styles;

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: CustomPaint(
          child: child,
          size: size ?? Size.zero,
          painter: BlobPainter(
            blobData: blobData,
            debug: debug,
            styles: styles,
          ),
        ),
      );
}
