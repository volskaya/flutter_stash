class InvalidSeedException implements Exception {
  const InvalidSeedException(this.id);

  final String? id;

  @override
  String toString() => "Invalid ID - $id";
}

class InvalidEdgesCountException implements Exception {
  @override
  String toString() => "EdgesCount should be more than 2 and less than 300";
}
