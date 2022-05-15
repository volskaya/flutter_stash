// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'encapsule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EncapsuleElementValue {
  double get bottomInset => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EncapsuleElementValueCopyWith<EncapsuleElementValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncapsuleElementValueCopyWith<$Res> {
  factory $EncapsuleElementValueCopyWith(EncapsuleElementValue value,
          $Res Function(EncapsuleElementValue) then) =
      _$EncapsuleElementValueCopyWithImpl<$Res>;
  $Res call({double bottomInset});
}

/// @nodoc
class _$EncapsuleElementValueCopyWithImpl<$Res>
    implements $EncapsuleElementValueCopyWith<$Res> {
  _$EncapsuleElementValueCopyWithImpl(this._value, this._then);

  final EncapsuleElementValue _value;
  // ignore: unused_field
  final $Res Function(EncapsuleElementValue) _then;

  @override
  $Res call({
    Object? bottomInset = freezed,
  }) {
    return _then(_value.copyWith(
      bottomInset: bottomInset == freezed
          ? _value.bottomInset
          : bottomInset // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$$_EncapsuleElementValueCopyWith<$Res>
    implements $EncapsuleElementValueCopyWith<$Res> {
  factory _$$_EncapsuleElementValueCopyWith(_$_EncapsuleElementValue value,
          $Res Function(_$_EncapsuleElementValue) then) =
      __$$_EncapsuleElementValueCopyWithImpl<$Res>;
  @override
  $Res call({double bottomInset});
}

/// @nodoc
class __$$_EncapsuleElementValueCopyWithImpl<$Res>
    extends _$EncapsuleElementValueCopyWithImpl<$Res>
    implements _$$_EncapsuleElementValueCopyWith<$Res> {
  __$$_EncapsuleElementValueCopyWithImpl(_$_EncapsuleElementValue _value,
      $Res Function(_$_EncapsuleElementValue) _then)
      : super(_value, (v) => _then(v as _$_EncapsuleElementValue));

  @override
  _$_EncapsuleElementValue get _value =>
      super._value as _$_EncapsuleElementValue;

  @override
  $Res call({
    Object? bottomInset = freezed,
  }) {
    return _then(_$_EncapsuleElementValue(
      bottomInset: bottomInset == freezed
          ? _value.bottomInset
          : bottomInset // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_EncapsuleElementValue
    with DiagnosticableTreeMixin
    implements _EncapsuleElementValue {
  const _$_EncapsuleElementValue({required this.bottomInset});

  @override
  final double bottomInset;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EncapsuleElementValue(bottomInset: $bottomInset)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EncapsuleElementValue'))
      ..add(DiagnosticsProperty('bottomInset', bottomInset));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EncapsuleElementValue &&
            const DeepCollectionEquality()
                .equals(other.bottomInset, bottomInset));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(bottomInset));

  @JsonKey(ignore: true)
  @override
  _$$_EncapsuleElementValueCopyWith<_$_EncapsuleElementValue> get copyWith =>
      __$$_EncapsuleElementValueCopyWithImpl<_$_EncapsuleElementValue>(
          this, _$identity);
}

abstract class _EncapsuleElementValue implements EncapsuleElementValue {
  const factory _EncapsuleElementValue({required final double bottomInset}) =
      _$_EncapsuleElementValue;

  @override
  double get bottomInset => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_EncapsuleElementValueCopyWith<_$_EncapsuleElementValue> get copyWith =>
      throw _privateConstructorUsedError;
}
