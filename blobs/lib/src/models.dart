import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

enum BlobFillType { fill, stroke }

@freezed
class BlobData with _$BlobData {
  @Assert('edges >= 2 && edges <= 300') @Assert('growth >= 2 && growth <= 9')
  const factory BlobData({
    @Default(7) int edges,
    @Default(4) int growth,
    double? size,
    BlobPoints? points,
    String? seed,
    Path? path,
    String? svgPath,
    BlobCurves? curves,
  }) = _BlobData;
}

@freezed
class BlobSeed with _$BlobSeed {
  @Assert('edges >= 2 && edges <= 300') @Assert('growth >= 2 && growth <= 9')
  const factory BlobSeed({
    @Default(7) int edges,
    @Default(4) int growth,
    required int seed,
  }) = _BlobSeed;
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
class BlobStyles with _$BlobStyles {
  const factory BlobStyles({
    Color? color,
    Shader? gradient,
    int? strokeWidth,
    BlobFillType? fillType,
  }) = _BlobStyles;
}

@freezed
class BlobPoints with _$BlobPoints {
  const factory BlobPoints({
    required List<Offset> originPoints,
    required List<Offset> destPoints,
    required Offset center,
    required double innerRad,
    String? id,
  }) = _BlobPoints;
}
