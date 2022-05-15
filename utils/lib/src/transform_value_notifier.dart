import 'package:flutter/foundation.dart';

class TransformValueNotifier<T extends ChangeNotifier, D> implements ValueListenable<D> {
  TransformValueNotifier(
    this.notifier, {
    required this.transform,
  });

  final T notifier;
  final D Function(T value) transform;

  @override
  D get value => transform(notifier);

  @override
  void addListener(VoidCallback listener) => notifier.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => notifier.removeListener(listener);
}
