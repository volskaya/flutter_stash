// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of revealing_bar;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$RevealingBarNotificationTearOff {
  const _$RevealingBarNotificationTearOff();

// ignore: unused_element
  _RevealingBarNotification call(
      {@required double maxExtent, double localOffset, double remoteOffset}) {
    return _RevealingBarNotification(
      maxExtent: maxExtent,
      localOffset: localOffset,
      remoteOffset: remoteOffset,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $RevealingBarNotification = _$RevealingBarNotificationTearOff();

/// @nodoc
mixin _$RevealingBarNotification {
  double get maxExtent;
  double get localOffset;
  double get remoteOffset;

  $RevealingBarNotificationCopyWith<RevealingBarNotification> get copyWith;
}

/// @nodoc
abstract class $RevealingBarNotificationCopyWith<$Res> {
  factory $RevealingBarNotificationCopyWith(RevealingBarNotification value,
          $Res Function(RevealingBarNotification) then) =
      _$RevealingBarNotificationCopyWithImpl<$Res>;
  $Res call({double maxExtent, double localOffset, double remoteOffset});
}

/// @nodoc
class _$RevealingBarNotificationCopyWithImpl<$Res>
    implements $RevealingBarNotificationCopyWith<$Res> {
  _$RevealingBarNotificationCopyWithImpl(this._value, this._then);

  final RevealingBarNotification _value;
  // ignore: unused_field
  final $Res Function(RevealingBarNotification) _then;

  @override
  $Res call({
    Object maxExtent = freezed,
    Object localOffset = freezed,
    Object remoteOffset = freezed,
  }) {
    return _then(_value.copyWith(
      maxExtent: maxExtent == freezed ? _value.maxExtent : maxExtent as double,
      localOffset:
          localOffset == freezed ? _value.localOffset : localOffset as double,
      remoteOffset: remoteOffset == freezed
          ? _value.remoteOffset
          : remoteOffset as double,
    ));
  }
}

/// @nodoc
abstract class _$RevealingBarNotificationCopyWith<$Res>
    implements $RevealingBarNotificationCopyWith<$Res> {
  factory _$RevealingBarNotificationCopyWith(_RevealingBarNotification value,
          $Res Function(_RevealingBarNotification) then) =
      __$RevealingBarNotificationCopyWithImpl<$Res>;
  @override
  $Res call({double maxExtent, double localOffset, double remoteOffset});
}

/// @nodoc
class __$RevealingBarNotificationCopyWithImpl<$Res>
    extends _$RevealingBarNotificationCopyWithImpl<$Res>
    implements _$RevealingBarNotificationCopyWith<$Res> {
  __$RevealingBarNotificationCopyWithImpl(_RevealingBarNotification _value,
      $Res Function(_RevealingBarNotification) _then)
      : super(_value, (v) => _then(v as _RevealingBarNotification));

  @override
  _RevealingBarNotification get _value =>
      super._value as _RevealingBarNotification;

  @override
  $Res call({
    Object maxExtent = freezed,
    Object localOffset = freezed,
    Object remoteOffset = freezed,
  }) {
    return _then(_RevealingBarNotification(
      maxExtent: maxExtent == freezed ? _value.maxExtent : maxExtent as double,
      localOffset:
          localOffset == freezed ? _value.localOffset : localOffset as double,
      remoteOffset: remoteOffset == freezed
          ? _value.remoteOffset
          : remoteOffset as double,
    ));
  }
}

/// @nodoc
class _$_RevealingBarNotification implements _RevealingBarNotification {
  const _$_RevealingBarNotification(
      {@required this.maxExtent, this.localOffset, this.remoteOffset})
      : assert(maxExtent != null);

  @override
  final double maxExtent;
  @override
  final double localOffset;
  @override
  final double remoteOffset;

  @override
  String toString() {
    return 'RevealingBarNotification(maxExtent: $maxExtent, localOffset: $localOffset, remoteOffset: $remoteOffset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RevealingBarNotification &&
            (identical(other.maxExtent, maxExtent) ||
                const DeepCollectionEquality()
                    .equals(other.maxExtent, maxExtent)) &&
            (identical(other.localOffset, localOffset) ||
                const DeepCollectionEquality()
                    .equals(other.localOffset, localOffset)) &&
            (identical(other.remoteOffset, remoteOffset) ||
                const DeepCollectionEquality()
                    .equals(other.remoteOffset, remoteOffset)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(maxExtent) ^
      const DeepCollectionEquality().hash(localOffset) ^
      const DeepCollectionEquality().hash(remoteOffset);

  @override
  _$RevealingBarNotificationCopyWith<_RevealingBarNotification> get copyWith =>
      __$RevealingBarNotificationCopyWithImpl<_RevealingBarNotification>(
          this, _$identity);
}

abstract class _RevealingBarNotification implements RevealingBarNotification {
  const factory _RevealingBarNotification(
      {@required double maxExtent,
      double localOffset,
      double remoteOffset}) = _$_RevealingBarNotification;

  @override
  double get maxExtent;
  @override
  double get localOffset;
  @override
  double get remoteOffset;
  @override
  _$RevealingBarNotificationCopyWith<_RevealingBarNotification> get copyWith;
}
