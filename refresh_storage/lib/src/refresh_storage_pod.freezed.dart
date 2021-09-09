// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'refresh_storage_pod.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RefreshStorageValueItemTearOff {
  const _$RefreshStorageValueItemTearOff();

  _RefreshStorageValueItem<T> call<T extends RefreshStorageItem>({required T item, int refresh = -1}) {
    return _RefreshStorageValueItem<T>(
      item: item,
      refresh: refresh,
    );
  }
}

/// @nodoc
const $RefreshStorageValueItem = _$RefreshStorageValueItemTearOff();

/// @nodoc
mixin _$RefreshStorageValueItem<T extends RefreshStorageItem> {
  T get item => throw _privateConstructorUsedError;
  int get refresh => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RefreshStorageValueItemCopyWith<T, RefreshStorageValueItem<T>> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshStorageValueItemCopyWith<T extends RefreshStorageItem, $Res> {
  factory $RefreshStorageValueItemCopyWith(RefreshStorageValueItem<T> value,
      $Res Function(RefreshStorageValueItem<T>) then) = _$RefreshStorageValueItemCopyWithImpl<T, $Res>;
  $Res call({T item, int refresh});
}

/// @nodoc
class _$RefreshStorageValueItemCopyWithImpl<T extends RefreshStorageItem, $Res>
    implements $RefreshStorageValueItemCopyWith<T, $Res> {
  _$RefreshStorageValueItemCopyWithImpl(this._value, this._then);

  final RefreshStorageValueItem<T> _value;
  // ignore: unused_field
  final $Res Function(RefreshStorageValueItem<T>) _then;

  @override
  $Res call({
    Object? item = freezed,
    Object? refresh = freezed,
  }) {
    return _then(_value.copyWith(
      item: item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as T,
      refresh: refresh == freezed
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$RefreshStorageValueItemCopyWith<T extends RefreshStorageItem, $Res>
    implements $RefreshStorageValueItemCopyWith<T, $Res> {
  factory _$RefreshStorageValueItemCopyWith(_RefreshStorageValueItem<T> value,
      $Res Function(_RefreshStorageValueItem<T>) then) = __$RefreshStorageValueItemCopyWithImpl<T, $Res>;
  @override
  $Res call({T item, int refresh});
}

/// @nodoc
class __$RefreshStorageValueItemCopyWithImpl<T extends RefreshStorageItem, $Res>
    extends _$RefreshStorageValueItemCopyWithImpl<T, $Res> implements _$RefreshStorageValueItemCopyWith<T, $Res> {
  __$RefreshStorageValueItemCopyWithImpl(_RefreshStorageValueItem<T> _value,
      $Res Function(_RefreshStorageValueItem<T>) _then)
      : super(_value, (v) => _then(v as _RefreshStorageValueItem<T>));

  @override
  _RefreshStorageValueItem<T> get _value => super._value as _RefreshStorageValueItem<T>;

  @override
  $Res call({
    Object? item = freezed,
    Object? refresh = freezed,
  }) {
    return _then(_RefreshStorageValueItem<T>(
      item: item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as T,
      refresh: refresh == freezed
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_RefreshStorageValueItem<T extends RefreshStorageItem> implements _RefreshStorageValueItem<T> {
  const _$_RefreshStorageValueItem({required this.item, this.refresh = -1});

  @override final T item;
  @JsonKey(defaultValue: -1) @override final int refresh;

  @override
  String toString() {
    return 'RefreshStorageValueItem<$T>(item: $item, refresh: $refresh)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RefreshStorageValueItem<T> &&
            (identical(other.item, item) || const DeepCollectionEquality().equals(other.item, item)) &&
            (identical(other.refresh, refresh) || const DeepCollectionEquality().equals(other.refresh, refresh)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(item) ^ const DeepCollectionEquality().hash(refresh);

  @JsonKey(ignore: true) @override
  _$RefreshStorageValueItemCopyWith<T, _RefreshStorageValueItem<T>> get copyWith =>
      __$RefreshStorageValueItemCopyWithImpl<T, _RefreshStorageValueItem<T>>(this, _$identity);
}

abstract class _RefreshStorageValueItem<T extends RefreshStorageItem> implements RefreshStorageValueItem<T> {
  const factory _RefreshStorageValueItem({required T item, int refresh}) = _$_RefreshStorageValueItem<T>;

  @override
  T get item => throw _privateConstructorUsedError;
  @override
  int get refresh => throw _privateConstructorUsedError;
  @override @JsonKey(ignore: true)
  _$RefreshStorageValueItemCopyWith<T, _RefreshStorageValueItem<T>> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$RefreshStorageValueTearOff {
  const _$RefreshStorageValueTearOff();

  _RefreshStorageValue call({required IMap<int, RefreshStorageValueItem<RefreshStorageItem>> items}) {
    return _RefreshStorageValue(
      items: items,
    );
  }
}

/// @nodoc
const $RefreshStorageValue = _$RefreshStorageValueTearOff();

/// @nodoc
mixin _$RefreshStorageValue {
  IMap<int, RefreshStorageValueItem<RefreshStorageItem>> get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RefreshStorageValueCopyWith<RefreshStorageValue> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefreshStorageValueCopyWith<$Res> {
  factory $RefreshStorageValueCopyWith(RefreshStorageValue value, $Res Function(RefreshStorageValue) then) =
      _$RefreshStorageValueCopyWithImpl<$Res>;
  $Res call({IMap<int, RefreshStorageValueItem<RefreshStorageItem>> items});
}

/// @nodoc
class _$RefreshStorageValueCopyWithImpl<$Res> implements $RefreshStorageValueCopyWith<$Res> {
  _$RefreshStorageValueCopyWithImpl(this._value, this._then);

  final RefreshStorageValue _value;
  // ignore: unused_field
  final $Res Function(RefreshStorageValue) _then;

  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as IMap<int, RefreshStorageValueItem<RefreshStorageItem>>,
    ));
  }
}

/// @nodoc
abstract class _$RefreshStorageValueCopyWith<$Res> implements $RefreshStorageValueCopyWith<$Res> {
  factory _$RefreshStorageValueCopyWith(_RefreshStorageValue value, $Res Function(_RefreshStorageValue) then) =
      __$RefreshStorageValueCopyWithImpl<$Res>;
  @override
  $Res call({IMap<int, RefreshStorageValueItem<RefreshStorageItem>> items});
}

/// @nodoc
class __$RefreshStorageValueCopyWithImpl<$Res> extends _$RefreshStorageValueCopyWithImpl<$Res>
    implements _$RefreshStorageValueCopyWith<$Res> {
  __$RefreshStorageValueCopyWithImpl(_RefreshStorageValue _value, $Res Function(_RefreshStorageValue) _then)
      : super(_value, (v) => _then(v as _RefreshStorageValue));

  @override
  _RefreshStorageValue get _value => super._value as _RefreshStorageValue;

  @override
  $Res call({
    Object? items = freezed,
  }) {
    return _then(_RefreshStorageValue(
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as IMap<int, RefreshStorageValueItem<RefreshStorageItem>>,
    ));
  }
}

/// @nodoc

class _$_RefreshStorageValue extends _RefreshStorageValue {
  const _$_RefreshStorageValue({required this.items}) : super._();

  @override final IMap<int, RefreshStorageValueItem<RefreshStorageItem>> items;

  @override
  String toString() {
    return 'RefreshStorageValue(items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RefreshStorageValue &&
            (identical(other.items, items) || const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  int get hashCode => runtimeType.hashCode ^ const DeepCollectionEquality().hash(items);

  @JsonKey(ignore: true) @override
  _$RefreshStorageValueCopyWith<_RefreshStorageValue> get copyWith =>
      __$RefreshStorageValueCopyWithImpl<_RefreshStorageValue>(this, _$identity);
}

abstract class _RefreshStorageValue extends RefreshStorageValue {
  const factory _RefreshStorageValue({required IMap<int, RefreshStorageValueItem<RefreshStorageItem>> items}) =
      _$_RefreshStorageValue;
  const _RefreshStorageValue._() : super._();

  @override
  IMap<int, RefreshStorageValueItem<RefreshStorageItem>> get items => throw _privateConstructorUsedError;
  @override @JsonKey(ignore: true)
  _$RefreshStorageValueCopyWith<_RefreshStorageValue> get copyWith => throw _privateConstructorUsedError;
}
