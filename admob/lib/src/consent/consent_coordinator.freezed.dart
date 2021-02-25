// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'consent_coordinator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ConsentCoordinatorState _$ConsentCoordinatorStateFromJson(
    Map<String, dynamic> json) {
  return _ConsentCoordinatorState.fromJson(json);
}

/// @nodoc
class _$ConsentCoordinatorStateTearOff {
  const _$ConsentCoordinatorStateTearOff();

// ignore: unused_element
  _ConsentCoordinatorState call(
      {ConsentStatus status = ConsentStatus.unknown,
      ConsentType type = ConsentType.unknown,
      bool isContentFormAvailable = false}) {
    return _ConsentCoordinatorState(
      status: status,
      type: type,
      isContentFormAvailable: isContentFormAvailable,
    );
  }

// ignore: unused_element
  ConsentCoordinatorState fromJson(Map<String, Object> json) {
    return ConsentCoordinatorState.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $ConsentCoordinatorState = _$ConsentCoordinatorStateTearOff();

/// @nodoc
mixin _$ConsentCoordinatorState {
  ConsentStatus get status;
  ConsentType get type;
  bool get isContentFormAvailable;

  Map<String, dynamic> toJson();
  $ConsentCoordinatorStateCopyWith<ConsentCoordinatorState> get copyWith;
}

/// @nodoc
abstract class $ConsentCoordinatorStateCopyWith<$Res> {
  factory $ConsentCoordinatorStateCopyWith(ConsentCoordinatorState value,
          $Res Function(ConsentCoordinatorState) then) =
      _$ConsentCoordinatorStateCopyWithImpl<$Res>;
  $Res call(
      {ConsentStatus status, ConsentType type, bool isContentFormAvailable});
}

/// @nodoc
class _$ConsentCoordinatorStateCopyWithImpl<$Res>
    implements $ConsentCoordinatorStateCopyWith<$Res> {
  _$ConsentCoordinatorStateCopyWithImpl(this._value, this._then);

  final ConsentCoordinatorState _value;
  // ignore: unused_field
  final $Res Function(ConsentCoordinatorState) _then;

  @override
  $Res call({
    Object status = freezed,
    Object type = freezed,
    Object isContentFormAvailable = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed ? _value.status : status as ConsentStatus,
      type: type == freezed ? _value.type : type as ConsentType,
      isContentFormAvailable: isContentFormAvailable == freezed
          ? _value.isContentFormAvailable
          : isContentFormAvailable as bool,
    ));
  }
}

/// @nodoc
abstract class _$ConsentCoordinatorStateCopyWith<$Res>
    implements $ConsentCoordinatorStateCopyWith<$Res> {
  factory _$ConsentCoordinatorStateCopyWith(_ConsentCoordinatorState value,
          $Res Function(_ConsentCoordinatorState) then) =
      __$ConsentCoordinatorStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {ConsentStatus status, ConsentType type, bool isContentFormAvailable});
}

/// @nodoc
class __$ConsentCoordinatorStateCopyWithImpl<$Res>
    extends _$ConsentCoordinatorStateCopyWithImpl<$Res>
    implements _$ConsentCoordinatorStateCopyWith<$Res> {
  __$ConsentCoordinatorStateCopyWithImpl(_ConsentCoordinatorState _value,
      $Res Function(_ConsentCoordinatorState) _then)
      : super(_value, (v) => _then(v as _ConsentCoordinatorState));

  @override
  _ConsentCoordinatorState get _value =>
      super._value as _ConsentCoordinatorState;

  @override
  $Res call({
    Object status = freezed,
    Object type = freezed,
    Object isContentFormAvailable = freezed,
  }) {
    return _then(_ConsentCoordinatorState(
      status: status == freezed ? _value.status : status as ConsentStatus,
      type: type == freezed ? _value.type : type as ConsentType,
      isContentFormAvailable: isContentFormAvailable == freezed
          ? _value.isContentFormAvailable
          : isContentFormAvailable as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ConsentCoordinatorState implements _ConsentCoordinatorState {
  const _$_ConsentCoordinatorState(
      {this.status = ConsentStatus.unknown,
      this.type = ConsentType.unknown,
      this.isContentFormAvailable = false})
      : assert(status != null),
        assert(type != null),
        assert(isContentFormAvailable != null);

  factory _$_ConsentCoordinatorState.fromJson(Map<String, dynamic> json) =>
      _$_$_ConsentCoordinatorStateFromJson(json);

  @JsonKey(defaultValue: ConsentStatus.unknown)
  @override
  final ConsentStatus status;
  @JsonKey(defaultValue: ConsentType.unknown)
  @override
  final ConsentType type;
  @JsonKey(defaultValue: false)
  @override
  final bool isContentFormAvailable;

  @override
  String toString() {
    return 'ConsentCoordinatorState(status: $status, type: $type, isContentFormAvailable: $isContentFormAvailable)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ConsentCoordinatorState &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.isContentFormAvailable, isContentFormAvailable) ||
                const DeepCollectionEquality().equals(
                    other.isContentFormAvailable, isContentFormAvailable)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(isContentFormAvailable);

  @override
  _$ConsentCoordinatorStateCopyWith<_ConsentCoordinatorState> get copyWith =>
      __$ConsentCoordinatorStateCopyWithImpl<_ConsentCoordinatorState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ConsentCoordinatorStateToJson(this);
  }
}

abstract class _ConsentCoordinatorState implements ConsentCoordinatorState {
  const factory _ConsentCoordinatorState(
      {ConsentStatus status,
      ConsentType type,
      bool isContentFormAvailable}) = _$_ConsentCoordinatorState;

  factory _ConsentCoordinatorState.fromJson(Map<String, dynamic> json) =
      _$_ConsentCoordinatorState.fromJson;

  @override
  ConsentStatus get status;
  @override
  ConsentType get type;
  @override
  bool get isContentFormAvailable;
  @override
  _$ConsentCoordinatorStateCopyWith<_ConsentCoordinatorState> get copyWith;
}
