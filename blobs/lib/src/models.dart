import 'dart:math' as math;

import 'package:blobs/src/config.dart';
import 'package:blobs/src/services/blob_generator.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

enum BlobFillType { fill, stroke }

@freezed
class BlobData with _$BlobData {
  const factory BlobData({
    required Size size,
    required BlobPoints points,
    required Path path,
    required BlobCurves curves,
    required BlobSeed seed,
  }) = _BlobData;
}

@freezed
class BlobSeed with _$BlobSeed {
  @Assert('edges >= 2 && edges <= 300') @Assert('growth >= 2 && growth <= 9')
  const factory BlobSeed(
    int rand, [
    @Default(BlobConfig.edgesCount) int edges,
    @Default(BlobConfig.minGrowth) int growth,
  ]) = _BlobSeed;

  static final random = math.Random();

  static BlobSeed getRandomSeed() => BlobSeed(random.nextInt(5000));
}

@freezed
class BlobCurves with _$BlobCurves {
  const factory BlobCurves({
    required Offset start,
    required List<List<double>> curves,
    required List<Offset> breakpoints,
  }) = _BlobCurves;
}

@freezed
class BlobStyle with _$BlobStyle {
  factory BlobStyle({
    @Default(BlobConfig.color) Color color,
    @Default(BlobConfig.strokeWidth) double strokeWidth,
    @Default(BlobConfig.fillType) PaintingStyle fillType,
    Shader? gradient,
  }) = _BlobStyle;

  BlobStyle._();

  late final Paint paint = BlobStyle.createPaint(this);

  static Paint createPaint(BlobStyle blobStyle) => Paint()
    ..color = blobStyle.color
    ..shader = blobStyle.gradient
    ..strokeWidth = blobStyle.strokeWidth
    ..style = blobStyle.fillType;
}

@freezed
class BlobPoints with _$BlobPoints {
  const factory BlobPoints({
    required List<Offset> originPoints,
    required List<Offset> destPoints,
    required Offset center,
    required double innerRad,
    BlobSeed? seed,
  }) = _BlobPoints;
}

@freezed @Deprecated('Use BlobPaintCoordinator')
class BlobPaintData with _$BlobPaintData {
  factory BlobPaintData({
    required Size size,
    required BlobSeed seed,
    @Default(Alignment.center) Alignment alignment, // Alignment of the painted blob rect on the canvas.
    @Default(Offset.zero) Offset translation, // Shift of the path after the blob is aligned on the canvas.
    BlobStyle? style,
  }) = _BlobPaintData;

  BlobPaintData._();

  late final Paint paint = (style ?? BlobStyle()).paint;
  late final BlobData data = BlobGenerator.generate(seed, size);

  void paintCanvas(Canvas canvas, Rect canvasRect) {
    final path = data.path;
    final bounds = path.getBounds();
    final centeredRect = alignment.inscribe(bounds.size, canvasRect);
    final shift = Offset(centeredRect.left - bounds.left, centeredRect.top - bounds.top);
    final anotherShift = Offset(bounds.width * translation.dx, bounds.height * translation.dy);
    final shiftedPath = path.shift(shift).shift(anotherShift);

    canvas.drawPath(shiftedPath, paint);
  }
}

/// Constructing this coordinator will also generate the blob path data.
/// This is an expensive operation and should be done once.
///
/// Use [apply] to animate properties of this coordinator.
class BlobPaintCoordinator {
  BlobPaintCoordinator({
    required this.size,
    required this.seed,
    this.alignment = Alignment.center,
    this.translation = Offset.zero,
    BlobStyle? style,
  })  : data = BlobGenerator.generate(seed, size),
        style = style ?? BlobStyle() {
    paint = this.style.paint;
  }

  final Size size;
  final BlobSeed seed;
  final BlobData data;

  late Paint paint;

  Offset translation;
  Alignment alignment;
  BlobStyle style;

  void apply({
    BlobStyle? style,
    Offset? translation,
    Alignment? alignment,
  }) {
    if (translation != null) this.translation = translation;
    if (alignment != null) this.alignment = alignment;
    if (style != null && style != this.style) {
      this.style = style;
      paint = this.style.paint;
    }
  }

  static Offset _getShift(Rect bounds, Offset translation) =>
      Offset(bounds.width * translation.dx, bounds.height * translation.dy);

  void paintCanvas(Canvas canvas, Rect canvasRect, [double t = 1.0]) {
    final path = data.path;
    final bounds = path.getBounds();
    final centeredRect = alignment.inscribe(bounds.size, canvasRect);
    final shift = Offset(centeredRect.left - bounds.left, centeredRect.top - bounds.top);
    final anotherShift = _getShift(bounds, translation);
    final shiftedPath = path.shift(shift).shift(anotherShift);

    canvas.drawPath(shiftedPath, paint);
  }
}
