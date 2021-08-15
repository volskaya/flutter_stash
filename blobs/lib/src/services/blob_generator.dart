import 'dart:math';

import 'package:blobs/src/models.dart';
import 'package:blobs/src/painter/tools.dart';
import 'package:flutter/material.dart';

class BlobGenerator {
  static BlobData generate(BlobSeed seed, Size size) {
    final points = _createPoints(seed, size);
    final curves = _createCurves(points.destPoints);
    final path = connectPoints(curves);

    return BlobData(
      seed: seed,
      path: path,
      points: points,
      size: size,
      curves: curves,
    );
  }

  static BlobData generateFromPoints(List<Offset> destPoints, Size size, int edgesCount, int minGrowth) {
    final curves = _createCurves(destPoints);
    final path = connectPoints(curves);
    final points = _createPointsFromDest(destPoints, size, edgesCount, minGrowth);

    return BlobData(
      seed: BlobSeed(0, edgesCount, minGrowth),
      path: path,
      points: points,
      size: Size.zero,
      curves: curves,
    );
  }

  static double _toRad(double deg) => deg * (pi / 180.0);

  static List<double> _divide(int count) {
    final deg = 360.0 / count;
    return List<double>.generate(count, (i) => i * deg);
  }

  // https://stackoverflow.com/a/29450606/3096740
  static double Function() _randomDoubleGenerator(int seedValue) {
    const mask = 0xffffffff;

    int mw = (123456789 + seedValue) & mask;
    int mz = (987654321 - seedValue) & mask;

    return () {
      mz = (36969 * (mz & 65535) + ((mz & mask) >> 16)) & mask;
      mw = (18000 * (mw & 65535) + ((mw & mask) >> 16)) & mask;

      final result = ((((mz << 16) + (mw & 65535)) & mask) >> 0) / 4294967296;
      return result;
    };
  }

  static double _magicPoint(double value, double min, double max) {
    double radius = min + (value * (max - min));
    if (radius > max) {
      radius = radius - min;
    } else if (radius < min) {
      radius = radius + min;
    }
    return radius;
  }

  static Offset _point(Offset origin, double radius, double degree) {
    final x = origin.dx + (radius * cos(_toRad(degree)));
    final y = origin.dy + (radius * sin(_toRad(degree)));
    return Offset(x.round().toDouble(), y.round().toDouble());
  }

  static BlobPoints _createPoints(BlobSeed seed, Size size) {
    final outerRad = size.width / 2.0;
    final innerRad = seed.growth * (outerRad / 10.0);
    final center = Offset(size.width / 2.0, size.height / 2.0);
    final slices = _divide(seed.edges);
    final randVal = _randomDoubleGenerator(seed.rand);
    final originPoints = List<Offset>.filled(slices.length, Offset.zero);
    final destPoints = List<Offset>.filled(slices.length, Offset.zero);

    for (int i = 0; i < slices.length; i += 1) {
      final degree = slices[i];
      final o = _magicPoint(randVal(), innerRad, outerRad);
      final start = _point(center, innerRad, degree);
      final end = _point(center, o, degree);

      originPoints[i] = start;
      destPoints[i] = end;
    }

    return BlobPoints(
      originPoints: originPoints,
      destPoints: destPoints,
      center: center,
      seed: seed,
      innerRad: innerRad.toDouble(),
    );
  }

  static BlobPoints _createPointsFromDest(List<Offset> destPoints, Size size, int minGrowth, int edgesCount) {
    final outerRad = size.width / 2.0;
    final innerRad = minGrowth * (outerRad / 10.0);
    final center = Offset(size.width / 2.0, size.height / 2.0);
    final slices = _divide(edgesCount);
    final originPoints = List.generate(slices.length, (i) => _point(center, innerRad, slices[i]));

    return BlobPoints(
      originPoints: originPoints,
      destPoints: destPoints,
      center: center,
      seed: null,
      innerRad: innerRad.toDouble(),
    );
  }

  static BlobCurves _createCurves(List<Offset> points) {
    assert(points.length >= 2);

    final curves = List<List<double>>.filled(points.length, const <double>[]);
    final breakpoints = List<Offset>.filled(points.length + 1, Offset.zero);

    Offset mid = (points[0] + points[1]) / 2.0;
    breakpoints[0] = mid;

    for (var i = 0; i < points.length; i++) {
      final p1 = points[(i + 1) % points.length];
      final p2 = points[(i + 2) % points.length];

      mid = (p1 + p2) / 2;
      breakpoints[i + 1] = mid;
      curves[i] = [p1.dx, p1.dy, mid.dx, mid.dy];
    }

    return BlobCurves(
      start: mid,
      curves: curves,
      breakpoints: breakpoints,
    );
  }
}
