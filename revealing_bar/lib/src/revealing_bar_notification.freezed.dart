// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'revealing_bar_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RevealingBarNotification {
  double get maxExtent => throw _privateConstructorUsedError;
  double? get localOffset => throw _privateConstructorUsedError;
  double? get remoteOffset => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RevealingBarNotificationCopyWith<RevealingBarNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevealingBarNotificationCopyWith<$Res> {
  factory $RevealingBarNotificationCopyWith(RevealingBarNotification value,
          $Res Function(RevealingBarNotification) then) =
      _$RevealingBarNotificationCopyWithImpl<$Res>;
  $Res call({double maxExtent, double? localOffset, double? remoteOffset});
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
    Object? maxExtent = freezed,
    Object? localOffset = freezed,
    Object? remoteOffset = freezed,
  }) {
    return _then(_value.copyWith(
      maxExtent: maxExtent == freezed
          ? _value.maxExtent
          : maxExtent // ignore: cast_nullable_to_non_nullable
              as double,
      localOffset: localOffset == freezed
          ? _value.localOffset
          : localOffset // ignore: cast_nullable_to_non_nullable
              as double?,
      remoteOffset: remoteOffset == freezed
          ? _value.remoteOffset
          : remoteOffset // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
abstract class _$$_RevealingBarNotificationCopyWith<$Res>
    implements $RevealingBarNotificationCopyWith<$Res> {
  factory _$$_RevealingBarNotificationCopyWith(
          _$_RevealingBarNotification value,
          $Res Function(_$_RevealingBarNotification) then) =
      __$$_RevealingBarNotificationCopyWithImpl<$Res>;
  @override
  $Res call({double maxExtent, double? localOffset, double? remoteOffset});
}

/// @nodoc
class __$$_RevealingBarNotificationCopyWithImpl<$Res>
    extends _$RevealingBarNotificationCopyWithImpl<$Res>
    implements _$$_RevealingBarNotificationCopyWith<$Res> {
  __$$_RevealingBarNotificationCopyWithImpl(_$_RevealingBarNotification _value,
      $Res Function(_$_RevealingBarNotification) _then)
      : super(_value, (v) => _then(v as _$_RevealingBarNotification));

  @override
  _$_RevealingBarNotification get _value =>
      super._value as _$_RevealingBarNotification;

  @override
  $Res call({
    Object? maxExtent = freezed,
    Object? localOffset = freezed,
    Object? remoteOffset = freezed,
  }) {
    return _then(_$_RevealingBarNotification(
      maxExtent: maxExtent == freezed
          ? _value.maxExtent
          : maxExtent // ignore: cast_nullable_to_non_nullable
              as double,
      localOffset: localOffset == freezed
          ? _value.localOffset
          : localOffset // ignore: cast_nullable_to_non_nullable
              as double?,
      remoteOffset: remoteOffset == freezed
          ? _value.remoteOffset
          : remoteOffset // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$_RevealingBarNotification implements _RevealingBarNotification {
  const _$_RevealingBarNotification(
      {required this.maxExtent, this.localOffset, this.remoteOffset});

  @override
  final double maxExtent;
  @override
  final double? localOffset;
  @override
  final double? remoteOffset;

  @override
  String toString() {
    return 'RevealingBarNotification(maxExtent: $maxExtent, localOffset: $localOffset, remoteOffset: $remoteOffset)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RevealingBarNotification &&
            const DeepCollectionEquality().equals(other.maxExtent, maxExtent) &&
            const DeepCollectionEquality()
                .equals(other.localOffset, localOffset) &&
            const DeepCollectionEquality()
                .equals(other.remoteOffset, remoteOffset));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(maxExtent),
      const DeepCollectionEquality().hash(localOffset),
      const DeepCollectionEquality().hash(remoteOffset));

  @JsonKey(ignore: true)
  @override
  _$$_RevealingBarNotificationCopyWith<_$_RevealingBarNotification>
      get copyWith => __$$_RevealingBarNotificationCopyWithImpl<
          _$_RevealingBarNotification>(this, _$identity);
}

abstract class _RevealingBarNotification implements RevealingBarNotification {
  const factory _RevealingBarNotification(
      {required final double maxExtent,
      final double? localOffset,
      final double? remoteOffset}) = _$_RevealingBarNotification;

  @override
  double get maxExtent => throw _privateConstructorUsedError;
  @override
  double? get localOffset => throw _privateConstructorUsedError;
  @override
  double? get remoteOffset => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RevealingBarNotificationCopyWith<_$_RevealingBarNotification>
      get copyWith => throw _privateConstructorUsedError;
}
