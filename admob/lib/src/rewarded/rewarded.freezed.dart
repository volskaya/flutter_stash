// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'rewarded.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
RewardItem _$RewardItemFromJson(Map<String, dynamic> json) {
  return _RewardItem.fromJson(json);
}

/// @nodoc
class _$RewardItemTearOff {
  const _$RewardItemTearOff();

// ignore: unused_element
  _RewardItem call({@required String type, @required int amount}) {
    return _RewardItem(
      type: type,
      amount: amount,
    );
  }

// ignore: unused_element
  RewardItem fromJson(Map<String, Object> json) {
    return RewardItem.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $RewardItem = _$RewardItemTearOff();

/// @nodoc
mixin _$RewardItem {
  String get type;
  int get amount;

  Map<String, dynamic> toJson();
  $RewardItemCopyWith<RewardItem> get copyWith;
}

/// @nodoc
abstract class $RewardItemCopyWith<$Res> {
  factory $RewardItemCopyWith(
          RewardItem value, $Res Function(RewardItem) then) =
      _$RewardItemCopyWithImpl<$Res>;
  $Res call({String type, int amount});
}

/// @nodoc
class _$RewardItemCopyWithImpl<$Res> implements $RewardItemCopyWith<$Res> {
  _$RewardItemCopyWithImpl(this._value, this._then);

  final RewardItem _value;
  // ignore: unused_field
  final $Res Function(RewardItem) _then;

  @override
  $Res call({
    Object type = freezed,
    Object amount = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as String,
      amount: amount == freezed ? _value.amount : amount as int,
    ));
  }
}

/// @nodoc
abstract class _$RewardItemCopyWith<$Res> implements $RewardItemCopyWith<$Res> {
  factory _$RewardItemCopyWith(
          _RewardItem value, $Res Function(_RewardItem) then) =
      __$RewardItemCopyWithImpl<$Res>;
  @override
  $Res call({String type, int amount});
}

/// @nodoc
class __$RewardItemCopyWithImpl<$Res> extends _$RewardItemCopyWithImpl<$Res>
    implements _$RewardItemCopyWith<$Res> {
  __$RewardItemCopyWithImpl(
      _RewardItem _value, $Res Function(_RewardItem) _then)
      : super(_value, (v) => _then(v as _RewardItem));

  @override
  _RewardItem get _value => super._value as _RewardItem;

  @override
  $Res call({
    Object type = freezed,
    Object amount = freezed,
  }) {
    return _then(_RewardItem(
      type: type == freezed ? _value.type : type as String,
      amount: amount == freezed ? _value.amount : amount as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_RewardItem implements _RewardItem {
  const _$_RewardItem({@required this.type, @required this.amount})
      : assert(type != null),
        assert(amount != null);

  factory _$_RewardItem.fromJson(Map<String, dynamic> json) =>
      _$_$_RewardItemFromJson(json);

  @override
  final String type;
  @override
  final int amount;

  @override
  String toString() {
    return 'RewardItem(type: $type, amount: $amount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RewardItem &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(amount);

  @override
  _$RewardItemCopyWith<_RewardItem> get copyWith =>
      __$RewardItemCopyWithImpl<_RewardItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RewardItemToJson(this);
  }
}

abstract class _RewardItem implements RewardItem {
  const factory _RewardItem({@required String type, @required int amount}) =
      _$_RewardItem;

  factory _RewardItem.fromJson(Map<String, dynamic> json) =
      _$_RewardItem.fromJson;

  @override
  String get type;
  @override
  int get amount;
  @override
  _$RewardItemCopyWith<_RewardItem> get copyWith;
}
