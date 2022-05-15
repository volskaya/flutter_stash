// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'storage_upload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_StorageUploadObjectCopyWith<$Res>
    implements $StorageUploadObjectCopyWith<$Res> {
  factory _$$_StorageUploadObjectCopyWith(_$_StorageUploadObject value,
          $Res Function(_$_StorageUploadObject) then) =
      __$$_StorageUploadObjectCopyWithImpl<$Res>;
  @override
  $Res call({File file, String path, SettableMetadata? metadata});
}

/// @nodoc
class __$$_StorageUploadObjectCopyWithImpl<$Res>
    extends _$StorageUploadObjectCopyWithImpl<$Res>
    implements _$$_StorageUploadObjectCopyWith<$Res> {
  __$$_StorageUploadObjectCopyWithImpl(_$_StorageUploadObject _value,
      $Res Function(_$_StorageUploadObject) _then)
      : super(_value, (v) => _then(v as _$_StorageUploadObject));

  @override
  _$_StorageUploadObject get _value => super._value as _$_StorageUploadObject;

  @override
  $Res call({
    Object? file = freezed,
    Object? path = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$_StorageUploadObject(
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
        (other.runtimeType == runtimeType &&
            other is _$_StorageUploadObject &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(metadata));

  @JsonKey(ignore: true)
  @override
  _$$_StorageUploadObjectCopyWith<_$_StorageUploadObject> get copyWith =>
      __$$_StorageUploadObjectCopyWithImpl<_$_StorageUploadObject>(
          this, _$identity);
}

abstract class _StorageUploadObject implements StorageUploadObject {
  const factory _StorageUploadObject(
      {required final File file,
      required final String path,
      final SettableMetadata? metadata}) = _$_StorageUploadObject;

  @override
  File get file => throw _privateConstructorUsedError;
  @override
  String get path => throw _privateConstructorUsedError;
  @override
  SettableMetadata? get metadata => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_StorageUploadObjectCopyWith<_$_StorageUploadObject> get copyWith =>
      throw _privateConstructorUsedError;
}

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
abstract class _$$_StorageUploadEventCopyWith<$Res>
    implements $StorageUploadEventCopyWith<$Res> {
  factory _$$_StorageUploadEventCopyWith(_$_StorageUploadEvent value,
          $Res Function(_$_StorageUploadEvent) then) =
      __$$_StorageUploadEventCopyWithImpl<$Res>;
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
class __$$_StorageUploadEventCopyWithImpl<$Res>
    extends _$StorageUploadEventCopyWithImpl<$Res>
    implements _$$_StorageUploadEventCopyWith<$Res> {
  __$$_StorageUploadEventCopyWithImpl(
      _$_StorageUploadEvent _value, $Res Function(_$_StorageUploadEvent) _then)
      : super(_value, (v) => _then(v as _$_StorageUploadEvent));

  @override
  _$_StorageUploadEvent get _value => super._value as _$_StorageUploadEvent;

  @override
  $Res call({
    Object? object = freezed,
    Object? number = freezed,
    Object? totalBytes = freezed,
    Object? bytesTransferred = freezed,
  }) {
    return _then(_$_StorageUploadEvent(
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
        (other.runtimeType == runtimeType &&
            other is _$_StorageUploadEvent &&
            const DeepCollectionEquality().equals(other.object, object) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality()
                .equals(other.totalBytes, totalBytes) &&
            const DeepCollectionEquality()
                .equals(other.bytesTransferred, bytesTransferred));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(object),
      const DeepCollectionEquality().hash(number),
      const DeepCollectionEquality().hash(totalBytes),
      const DeepCollectionEquality().hash(bytesTransferred));

  @JsonKey(ignore: true)
  @override
  _$$_StorageUploadEventCopyWith<_$_StorageUploadEvent> get copyWith =>
      __$$_StorageUploadEventCopyWithImpl<_$_StorageUploadEvent>(
          this, _$identity);
}

abstract class _StorageUploadEvent extends StorageUploadEvent {
  factory _StorageUploadEvent(
      {required final StorageUploadObject object,
      required final int number,
      required final int totalBytes,
      required final int bytesTransferred}) = _$_StorageUploadEvent;
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
  _$$_StorageUploadEventCopyWith<_$_StorageUploadEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
