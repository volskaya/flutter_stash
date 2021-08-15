import 'dart:math';

import 'package:blobs/src/models.dart';
import 'package:blobs/src/painter/tools.dart';
import 'package:blobs/src/services/blob_error_handler.dart';
import 'package:flutter/material.dart';

class BlobGenerator {
  BlobGenerator({
    required this.size,
    this.edgesCount = 7,
    this.minGrowth = 4,
    this.seed,
  })  : assert(edgesCount >= 2 && edgesCount <= 300),
        assert(minGrowth >= 2 && minGrowth <= 9);

  final Size size;

  int edgesCount;
  int minGrowth;
  String svgPath = '';
  String? seed;
  List<List<Offset>> dots = [];

  BlobData generate() {
    if (seed != null) {
      var datum = seed!.split('-');
      if (datum.length != 3) throw InvalidSeedException(seed);
      edgesCount = int.parse(datum[0]);
      minGrowth = int.parse(datum[1]);
      seed = datum[2];
    }

    if (edgesCount <= 2) throw InvalidEdgesCountException();

    var points = _createPoints(seed != null ? int.parse(seed!) : null);
    final curves = _createCurves(points.destPoints);
    final path = connectPoints(curves);

    return BlobData(
      edges: edgesCount,
      growth: minGrowth,
      seed: points.id,
      path: path,
      points: points,
      size: size.width,
      svgPath: svgPath,
      curves: curves,
    );
  }

  BlobData generateFromPoints(List<Offset> destPoints) {
    BlobCurves curves = _createCurves(destPoints);
    Path path = connectPoints(curves);
    BlobPoints points = _createPointsFromDest(destPoints);

    return BlobData(
      seed: '',
      path: path,
      points: points,
      size: 0,
      svgPath: null,
      curves: curves,
    );
  }

  double _toRad(double deg) => deg * (pi / 180.0);

  List<double> _divide(int count) {
    final deg = 360.0 / count;
    return List<double>.generate(count, (i) => i * deg);
  }

  // https://stackoverflow.com/a/29450606/3096740
  double Function() _randomDoubleGenerator(int seedValue) {
    var mask = 0xffffffff;
    int mw = (123456789 + seedValue) & mask;
    int mz = (987654321 - seedValue) & mask;

    return () {
      mz = (36969 * (mz & 65535) + ((mz & mask) >> 16)) & mask;
      mw = (18000 * (mw & 65535) + ((mw & mask) >> 16)) & mask;

      final result = ((((mz << 16) + (mw & 65535)) & mask) >> 0) / 4294967296;
      return result;
    };
  }

  double _magicPoint(double value, double min, double max) {
    double radius = min + (value * (max - min));
    if (radius > max) {
      radius = radius - min;
    } else if (radius < min) {
      radius = radius + min;
    }
    return radius;
  }

  Offset _point(Offset origin, double radius, double degree) {
    final x = origin.dx + (radius * cos(_toRad(degree)));
    final y = origin.dy + (radius * sin(_toRad(degree)));
    return Offset(x.round().toDouble(), y.round().toDouble());
  }

  BlobPoints _createPoints(int? seedValue) {
    final outerRad = size.width / 2.0;
    final innerRad = minGrowth * (outerRad / 10.0);
    final center = Offset(size.width / 2.0, size.height / 2.0);
    final slices = _divide(edgesCount);

    int? randomInt;
    if (seed != null) {
      seedValue = int.parse(seed!);
    } else {
      final maxRandomValue = ([99, 999, 9999, 99999, 999999]..shuffle()).first;
      randomInt = Random().nextInt(maxRandomValue);
      seedValue = randomInt;
    }

    var randVal = _randomDoubleGenerator(seedValue);
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
      id: randomInt == null ? null : '$edgesCount-$minGrowth-$seed',
      innerRad: innerRad.toDouble(),
    );
  }

  BlobPoints _createPointsFromDest(List<Offset> destPoints) {
    final outerRad = size.width / 2.0;
    final innerRad = minGrowth * (outerRad / 10.0);
    final center = Offset(size.width / 2.0, size.height / 2.0);
    final slices = _divide(edgesCount);
    final originPoints = List.generate(slices.length, (i) => _point(center, innerRad, slices[i]));

    return BlobPoints(
      originPoints: originPoints,
      destPoints: destPoints,
      center: center,
      id: null,
      innerRad: innerRad.toDouble(),
    );
  }

  BlobCurves _createCurves(List<Offset> points) {
    assert(points.length >= 2);

    final curves = List<List<double>>.filled(points.length, const <double>[]);
    final breakpoints = List<Offset>.filled(points.length + 1, Offset.zero);

    Offset mid = (points[0] + points[1]) / 2.0;

    breakpoints[0] = mid;
    svgPath += 'M${mid.dx},${mid.dy}';

    for (var i = 0; i < points.length; i++) {
      var p1 = points[(i + 1) % points.length];
      var p2 = points[(i + 2) % points.length];
      mid = (p1 + p2) / 2;
      svgPath += 'Q${p1.dx},${p1.dy},${mid.dx},${mid.dy}';

      breakpoints[i + 1] = mid;
      curves[i] = [p1.dx, p1.dy, mid.dx, mid.dy];
    }

    svgPath += 'Z';

    return BlobCurves(
      start: mid,
      curves: curves,
      breakpoints: breakpoints,
    );
  }
}
