import 'package:blobs/src/models.dart';

class InvalidSeedException implements Exception {
  const InvalidSeedException(this.seed);

  final BlobSeed seed;

  @override
  String toString() => "Invalid ID - $seed";
}

class InvalidEdgesCountException implements Exception {
  @override
  String toString() => "EdgesCount should be more than 2 and less than 300";
}
