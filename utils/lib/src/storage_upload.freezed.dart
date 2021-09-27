// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'storage_upload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$StorageUploadObjectTearOff {
  const _$StorageUploadObjectTearOff();

  _StorageUploadObject call(
      {required File file, required String path, SettableMetadata? metadata}) {
    return _StorageUploadObject(
      file: file,
      path: path,
      metadata: metadata,
    );
  }
}

/// @nodoc
const $StorageUploadObject = _$StorageUploadObjectTearOff();

/// @nodoc
mixin _$StorageUploadObject {
  File get file => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  SettableMetadata? get metadata => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StorageUploadObjectCopyWith<StorageUploadObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageUploadObjectCopyWith<$Res> {
  factory $StorageUploadObjectCopyWith(
          StorageUploadObject value, $Res Function(StorageUploadObject) then) =
      _$StorageUploadObjectCopyWithImpl<$Res>;
  $Res call({File file, String path, SettableMetadata? metadata});
}

/// @nodoc
class _$StorageUploadObjectCopyWithImpl<$Res>
    implements $StorageUploadObjectCopyWith<$Res> {
  _$StorageUploadObjectCopyWithImpl(this._value, this._then);

  final StorageUploadObject _value;
  // ignore: unused_field
  final $Res Function(StorageUploadObject) _then;

  @override
  $Res call({
    Object? file = freezed,
    Object? path = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as SettableMetadata?,
    ));
  }
}

/// @nodoc
abstract class _$StorageUploadObjectCopyWith<$Res>
    implements $StorageUploadObjectCopyWith<$Res> {
  factory _$StorageUploadObjectCopyWith(_StorageUploadObject value,
          $Res Function(_StorageUploadObject) then) =
      __$StorageUploadObjectCopyWithImpl<$Res>;
  @override
  $Res call({File file, String path, SettableMetadata? metadata});
}

/// @nodoc
class __$StorageUploadObjectCopyWithImpl<$Res>
    extends _$StorageUploadObjectCopyWithImpl<$Res>
    implements _$StorageUploadObjectCopyWith<$Res> {
  __$StorageUploadObjectCopyWithImpl(
      _StorageUploadObject _value, $Res Function(_StorageUploadObject) _then)
      : super(_value, (v) => _then(v as _StorageUploadObject));

  @override
  _StorageUploadObject get _value => super._value as _StorageUploadObject;

  @override
  $Res call({
    Object? file = freezed,
    Object? path = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_StorageUploadObject(
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as SettableMetadata?,
    ));
  }
}

/// @nodoc

class _$_StorageUploadObject implements _StorageUploadObject {
  const _$_StorageUploadObject(
      {required this.file, required this.path, this.metadata});

  @override
  final File file;
  @override
  final String path;
  @override
  final SettableMetadata? metadata;

  @override
  String toString() {
    return 'StorageUploadObject(file: $file, path: $path, metadata: $metadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StorageUploadObject &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.metadata, metadata) ||
                const DeepCollectionEquality()
                    .equals(other.metadata, metadata)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(file) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(metadata);

  @JsonKey(ignore: true)
  @override
  _$StorageUploadObjectCopyWith<_StorageUploadObject> get copyWith =>
      __$StorageUploadObjectCopyWithImpl<_StorageUploadObject>(
          this, _$identity);
}

abstract class _StorageUploadObject implements StorageUploadObject {
  const factory _StorageUploadObject(
      {required File file,
      required String path,
      SettableMetadata? metadata}) = _$_StorageUploadObject;

  @override
  File get file => throw _privateConstructorUsedError;
  @override
  String get path => throw _privateConstructorUsedError;
  @override
  SettableMetadata? get metadata => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StorageUploadObjectCopyWith<_StorageUploadObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$StorageUploadEventTearOff {
  const _$StorageUploadEventTearOff();

  _StorageUploadEvent call(
      {required StorageUploadObject object,
      required int number,
      required int totalBytes,
      required int bytesTransferred}) {
    return _StorageUploadEvent(
      object: object,
      number: number,
      totalBytes: totalBytes,
      bytesTransferred: bytesTransferred,
    );
  }
}

/// @nodoc
const $StorageUploadEvent = _$StorageUploadEventTearOff();

/// @nodoc
mixin _$StorageUploadEvent {
  StorageUploadObject get object => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  int get totalBytes => throw _privateConstructorUsedError;
  int get bytesTransferred => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StorageUploadEventCopyWith<StorageUploadEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageUploadEventCopyWith<$Res> {
  factory $StorageUploadEventCopyWith(
          StorageUploadEvent value, $Res Function(StorageUploadEvent) then) =
      _$StorageUploadEventCopyWithImpl<$Res>;
  $Res call(
      {StorageUploadObject object,
      int number,
      int totalBytes,
      int bytesTransferred});

  $StorageUploadObjectCopyWith<$Res> get object;
}

/// @nodoc
class _$StorageUploadEventCopyWithImpl<$Res>
    implements $StorageUploadEventCopyWith<$Res> {
  _$StorageUploadEventCopyWithImpl(this._value, this._then);

  final StorageUploadEvent _value;
  // ignore: unused_field
  final $Res Function(StorageUploadEvent) _then;

  @override
  $Res call({
    Object? object = freezed,
    Object? number = freezed,
    Object? totalBytes = freezed,
    Object? bytesTransferred = freezed,
  }) {
    return _then(_value.copyWith(
      object: object == freezed
          ? _value.object
          : object // ignore: cast_nullable_to_non_nullable
              as StorageUploadObject,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      totalBytes: totalBytes == freezed
          ? _value.totalBytes
          : totalBytes // ignore: cast_nullable_to_non_nullable
              as int,
      bytesTransferred: bytesTransferred == freezed
          ? _value.bytesTransferred
          : bytesTransferred // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $StorageUploadObjectCopyWith<$Res> get object {
    return $StorageUploadObjectCopyWith<$Res>(_value.object, (value) {
      return _then(_value.copyWith(object: value));
    });
  }
}

/// @nodoc
abstract class _$StorageUploadEventCopyWith<$Res>
    implements $StorageUploadEventCopyWith<$Res> {
  factory _$StorageUploadEventCopyWith(
          _StorageUploadEvent value, $Res Function(_StorageUploadEvent) then) =
      __$StorageUploadEventCopyWithImpl<$Res>;
  @override
  $Res call(
      {StorageUploadObject object,
      int number,
      int totalBytes,
      int bytesTransferred});

  @override
  $StorageUploadObjectCopyWith<$Res> get object;
}

/// @nodoc
class __$StorageUploadEventCopyWithImpl<$Res>
    extends _$StorageUploadEventCopyWithImpl<$Res>
    implements _$StorageUploadEventCopyWith<$Res> {
  __$StorageUploadEventCopyWithImpl(
      _StorageUploadEvent _value, $Res Function(_StorageUploadEvent) _then)
      : super(_value, (v) => _then(v as _StorageUploadEvent));

  @override
  _StorageUploadEvent get _value => super._value as _StorageUploadEvent;

  @override
  $Res call({
    Object? object = freezed,
    Object? number = freezed,
    Object? totalBytes = freezed,
    Object? bytesTransferred = freezed,
  }) {
    return _then(_StorageUploadEvent(
      object: object == freezed
          ? _value.object
          : object // ignore: cast_nullable_to_non_nullable
              as StorageUploadObject,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      totalBytes: totalBytes == freezed
          ? _value.totalBytes
          : totalBytes // ignore: cast_nullable_to_non_nullable
              as int,
      bytesTransferred: bytesTransferred == freezed
          ? _value.bytesTransferred
          : bytesTransferred // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_StorageUploadEvent extends _StorageUploadEvent {
  _$_StorageUploadEvent(
      {required this.object,
      required this.number,
      required this.totalBytes,
      required this.bytesTransferred})
      : super._();

  @override
  final StorageUploadObject object;
  @override
  final int number;
  @override
  final int totalBytes;
  @override
  final int bytesTransferred;

  @override
  String toString() {
    return 'StorageUploadEvent(object: $object, number: $number, totalBytes: $totalBytes, bytesTransferred: $bytesTransferred)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StorageUploadEvent &&
            (identical(other.object, object) ||
                const DeepCollectionEquality().equals(other.object, object)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)) &&
            (identical(other.totalBytes, totalBytes) ||
                const DeepCollectionEquality()
                    .equals(other.totalBytes, totalBytes)) &&
            (identical(other.bytesTransferred, bytesTransferred) ||
                const DeepCollectionEquality()
                    .equals(other.bytesTransferred, bytesTransferred)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(object) ^
      const DeepCollectionEquality().hash(number) ^
      const DeepCollectionEquality().hash(totalBytes) ^
      const DeepCollectionEquality().hash(bytesTransferred);

  @JsonKey(ignore: true)
  @override
  _$StorageUploadEventCopyWith<_StorageUploadEvent> get copyWith =>
      __$StorageUploadEventCopyWithImpl<_StorageUploadEvent>(this, _$identity);
}

abstract class _StorageUploadEvent extends StorageUploadEvent {
  factory _StorageUploadEvent(
      {required StorageUploadObject object,
      required int number,
      required int totalBytes,
      required int bytesTransferred}) = _$_StorageUploadEvent;
  _StorageUploadEvent._() : super._();

  @override
  StorageUploadObject get object => throw _privateConstructorUsedError;
  @override
  int get number => throw _privateConstructorUsedError;
  @override
  int get totalBytes => throw _privateConstructorUsedError;
  @override
  int get bytesTransferred => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StorageUploadEventCopyWith<_StorageUploadEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
