import 'package:blobs/src/models.dart';
import 'package:blobs/src/painter/tools.dart';
import 'package:blobs/src/services/blob_generator.dart';
import 'package:flutter/material.dart';

class BlobClipper extends CustomClipper<Path> {
  const BlobClipper(this.seed);

  final BlobSeed seed;

  @override
  Path getClip(Size size) => connectPoints(BlobGenerator.generate(seed, size).curves);

  @override
  bool shouldReclip(BlobClipper oldClipper) => oldClipper.seed != seed;
}
