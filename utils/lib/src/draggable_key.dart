import 'package:freezed_annotation/freezed_annotation.dart';

part 'draggable_key.freezed.dart';

@freezed
class DraggableKey<T> with _$DraggableKey<T> {
  const factory DraggableKey({
    required String family,
    required T id,
  }) = _DraggableKey<T>;
}
