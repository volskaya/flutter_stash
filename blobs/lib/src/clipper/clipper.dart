import 'package:blobs/src/config.dart';
import 'package:blobs/src/painter/tools.dart';
import 'package:blobs/src/services/blob_generator.dart';
import 'package:flutter/material.dart';

class BlobClipper extends CustomClipper<Path> {
  const BlobClipper({
    this.seed,
    this.edgesCount = BlobConfig.edgesCount,
    this.minGrowth = BlobConfig.minGrowth,
  });

  final String? seed;
  final int edgesCount;
  final int minGrowth;

  @override
  Path getClip(Size size) {
    final blobData = BlobGenerator(
      seed: seed,
      edgesCount: edgesCount,
      minGrowth: minGrowth,
      size: size,
    ).generate();

    return connectPoints(blobData.curves!);
  }

  @override
  bool shouldReclip(BlobClipper oldClipper) =>
      oldClipper.seed != seed || oldClipper.edgesCount != edgesCount || oldClipper.minGrowth != minGrowth;
}
