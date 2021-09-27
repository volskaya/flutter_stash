// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'draggable_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DraggableKeyTearOff {
  const _$DraggableKeyTearOff();

  _DraggableKey<T> call<T>({required String family, required T id}) {
    return _DraggableKey<T>(
      family: family,
      id: id,
    );
  }
}

/// @nodoc
const $DraggableKey = _$DraggableKeyTearOff();

/// @nodoc
mixin _$DraggableKey<T> {
  String get family => throw _privateConstructorUsedError;
  T get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DraggableKeyCopyWith<T, DraggableKey<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DraggableKeyCopyWith<T, $Res> {
  factory $DraggableKeyCopyWith(
          DraggableKey<T> value, $Res Function(DraggableKey<T>) then) =
      _$DraggableKeyCopyWithImpl<T, $Res>;
  $Res call({String family, T id});
}

/// @nodoc
class _$DraggableKeyCopyWithImpl<T, $Res>
    implements $DraggableKeyCopyWith<T, $Res> {
  _$DraggableKeyCopyWithImpl(this._value, this._then);

  final DraggableKey<T> _value;
  // ignore: unused_field
  final $Res Function(DraggableKey<T>) _then;

  @override
  $Res call({
    Object? family = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      family: family == freezed
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
abstract class _$DraggableKeyCopyWith<T, $Res>
    implements $DraggableKeyCopyWith<T, $Res> {
  factory _$DraggableKeyCopyWith(
          _DraggableKey<T> value, $Res Function(_DraggableKey<T>) then) =
      __$DraggableKeyCopyWithImpl<T, $Res>;
  @override
  $Res call({String family, T id});
}

/// @nodoc
class __$DraggableKeyCopyWithImpl<T, $Res>
    extends _$DraggableKeyCopyWithImpl<T, $Res>
    implements _$DraggableKeyCopyWith<T, $Res> {
  __$DraggableKeyCopyWithImpl(
      _DraggableKey<T> _value, $Res Function(_DraggableKey<T>) _then)
      : super(_value, (v) => _then(v as _DraggableKey<T>));

  @override
  _DraggableKey<T> get _value => super._value as _DraggableKey<T>;

  @override
  $Res call({
    Object? family = freezed,
    Object? id = freezed,
  }) {
    return _then(_DraggableKey<T>(
      family: family == freezed
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_DraggableKey<T> implements _DraggableKey<T> {
  const _$_DraggableKey({required this.family, required this.id});

  @override
  final String family;
  @override
  final T id;

  @override
  String toString() {
    return 'DraggableKey<$T>(family: $family, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DraggableKey<T> &&
            (identical(other.family, family) ||
                const DeepCollectionEquality().equals(other.family, family)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(family) ^
      const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  _$DraggableKeyCopyWith<T, _DraggableKey<T>> get copyWith =>
      __$DraggableKeyCopyWithImpl<T, _DraggableKey<T>>(this, _$identity);
}

abstract class _DraggableKey<T> implements DraggableKey<T> {
  const factory _DraggableKey({required String family, required T id}) =
      _$_DraggableKey<T>;

  @override
  String get family => throw _privateConstructorUsedError;
  @override
  T get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DraggableKeyCopyWith<T, _DraggableKey<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
