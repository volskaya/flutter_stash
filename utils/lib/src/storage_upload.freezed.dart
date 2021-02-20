// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'storage_upload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$StorageUploadObjectTearOff {
  const _$StorageUploadObjectTearOff();

// ignore: unused_element
  _StorageUploadObject call(
      {@required File file, @required String path, StorageMetadata metadata}) {
    return _StorageUploadObject(
      file: file,
      path: path,
      metadata: metadata,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $StorageUploadObject = _$StorageUploadObjectTearOff();

/// @nodoc
mixin _$StorageUploadObject {
  File get file;
  String get path;
  StorageMetadata get metadata;

  $StorageUploadObjectCopyWith<StorageUploadObject> get copyWith;
}

/// @nodoc
abstract class $StorageUploadObjectCopyWith<$Res> {
  factory $StorageUploadObjectCopyWith(
          StorageUploadObject value, $Res Function(StorageUploadObject) then) =
      _$StorageUploadObjectCopyWithImpl<$Res>;
  $Res call({File file, String path, StorageMetadata metadata});
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
    Object file = freezed,
    Object path = freezed,
    Object metadata = freezed,
  }) {
    return _then(_value.copyWith(
      file: file == freezed ? _value.file : file as File,
      path: path == freezed ? _value.path : path as String,
      metadata:
          metadata == freezed ? _value.metadata : metadata as StorageMetadata,
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
  $Res call({File file, String path, StorageMetadata metadata});
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
    Object file = freezed,
    Object path = freezed,
    Object metadata = freezed,
  }) {
    return _then(_StorageUploadObject(
      file: file == freezed ? _value.file : file as File,
      path: path == freezed ? _value.path : path as String,
      metadata:
          metadata == freezed ? _value.metadata : metadata as StorageMetadata,
    ));
  }
}

/// @nodoc
class _$_StorageUploadObject implements _StorageUploadObject {
  const _$_StorageUploadObject(
      {@required this.file, @required this.path, this.metadata})
      : assert(file != null),
        assert(path != null);

  @override
  final File file;
  @override
  final String path;
  @override
  final StorageMetadata metadata;

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

  @override
  _$StorageUploadObjectCopyWith<_StorageUploadObject> get copyWith =>
      __$StorageUploadObjectCopyWithImpl<_StorageUploadObject>(
          this, _$identity);
}

abstract class _StorageUploadObject implements StorageUploadObject {
  const factory _StorageUploadObject(
      {@required File file,
      @required String path,
      StorageMetadata metadata}) = _$_StorageUploadObject;

  @override
  File get file;
  @override
  String get path;
  @override
  StorageMetadata get metadata;
  @override
  _$StorageUploadObjectCopyWith<_StorageUploadObject> get copyWith;
}

/// @nodoc
class _$StorageUploadEventTearOff {
  const _$StorageUploadEventTearOff();

// ignore: unused_element
  _StorageUploadEvent call(
      {@required StorageUploadObject object,
      @required int number,
      @required int totalBytes,
      @required int bytesTransferred}) {
    return _StorageUploadEvent(
      object: object,
      number: number,
      totalBytes: totalBytes,
      bytesTransferred: bytesTransferred,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $StorageUploadEvent = _$StorageUploadEventTearOff();

/// @nodoc
mixin _$StorageUploadEvent {
  StorageUploadObject get object;
  int get number;
  int get totalBytes;
  int get bytesTransferred;

  $StorageUploadEventCopyWith<StorageUploadEvent> get copyWith;
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
    Object object = freezed,
    Object number = freezed,
    Object totalBytes = freezed,
    Object bytesTransferred = freezed,
  }) {
    return _then(_value.copyWith(
      object: object == freezed ? _value.object : object as StorageUploadObject,
      number: number == freezed ? _value.number : number as int,
      totalBytes: totalBytes == freezed ? _value.totalBytes : totalBytes as int,
      bytesTransferred: bytesTransferred == freezed
          ? _value.bytesTransferred
          : bytesTransferred as int,
    ));
  }

  @override
  $StorageUploadObjectCopyWith<$Res> get object {
    if (_value.object == null) {
      return null;
    }
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
    Object object = freezed,
    Object number = freezed,
    Object totalBytes = freezed,
    Object bytesTransferred = freezed,
  }) {
    return _then(_StorageUploadEvent(
      object: object == freezed ? _value.object : object as StorageUploadObject,
      number: number == freezed ? _value.number : number as int,
      totalBytes: totalBytes == freezed ? _value.totalBytes : totalBytes as int,
      bytesTransferred: bytesTransferred == freezed
          ? _value.bytesTransferred
          : bytesTransferred as int,
    ));
  }
}

/// @nodoc
class _$_StorageUploadEvent implements _StorageUploadEvent {
  _$_StorageUploadEvent(
      {@required this.object,
      @required this.number,
      @required this.totalBytes,
      @required this.bytesTransferred})
      : assert(object != null),
        assert(number != null),
        assert(totalBytes != null),
        assert(bytesTransferred != null);

  @override
  final StorageUploadObject object;
  @override
  final int number;
  @override
  final int totalBytes;
  @override
  final int bytesTransferred;

  bool _didprogress = false;
  double _progress;

  @override
  double get progress {
    if (_didprogress == false) {
      _didprogress = true;
      _progress = bytesTransferred / totalBytes;
    }
    return _progress;
  }

  bool _didmegabytesTotal = false;
  double _megabytesTotal;

  @override
  double get megabytesTotal {
    if (_didmegabytesTotal == false) {
      _didmegabytesTotal = true;
      _megabytesTotal = totalBytes / math.pow(10, 6);
    }
    return _megabytesTotal;
  }

  bool _didmegabytesTransferred = false;
  double _megabytesTransferred;

  @override
  double get megabytesTransferred {
    if (_didmegabytesTransferred == false) {
      _didmegabytesTransferred = true;
      _megabytesTransferred = bytesTransferred / math.pow(10, 6);
    }
    return _megabytesTransferred;
  }

  @override
  String toString() {
    return 'StorageUploadEvent(object: $object, number: $number, totalBytes: $totalBytes, bytesTransferred: $bytesTransferred, progress: $progress, megabytesTotal: $megabytesTotal, megabytesTransferred: $megabytesTransferred)';
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

  @override
  _$StorageUploadEventCopyWith<_StorageUploadEvent> get copyWith =>
      __$StorageUploadEventCopyWithImpl<_StorageUploadEvent>(this, _$identity);
}

abstract class _StorageUploadEvent implements StorageUploadEvent {
  factory _StorageUploadEvent(
      {@required StorageUploadObject object,
      @required int number,
      @required int totalBytes,
      @required int bytesTransferred}) = _$_StorageUploadEvent;

  @override
  StorageUploadObject get object;
  @override
  int get number;
  @override
  int get totalBytes;
  @override
  int get bytesTransferred;
  @override
  _$StorageUploadEventCopyWith<_StorageUploadEvent> get copyWith;
}
