// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'inherited_animation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$InheritedAnimationValueTearOff {
  const _$InheritedAnimationValueTearOff();

  _InheritedAnimationValue call(
      {double opacity = 1.0,
      double scale = 1.0,
      Offset translation = Offset.zero}) {
    return _InheritedAnimationValue(
      opacity: opacity,
      scale: scale,
      translation: translation,
    );
  }
}

/// @nodoc
const $InheritedAnimationValue = _$InheritedAnimationValueTearOff();

/// @nodoc
mixin _$InheritedAnimationValue {
  double get opacity => throw _privateConstructorUsedError;
  double get scale => throw _privateConstructorUsedError;
  Offset get translation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InheritedAnimationValueCopyWith<InheritedAnimationValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InheritedAnimationValueCopyWith<$Res> {
  factory $InheritedAnimationValueCopyWith(InheritedAnimationValue value,
          $Res Function(InheritedAnimationValue) then) =
      _$InheritedAnimationValueCopyWithImpl<$Res>;
  $Res call({double opacity, double scale, Offset translation});
}

/// @nodoc
class _$InheritedAnimationValueCopyWithImpl<$Res>
    implements $InheritedAnimationValueCopyWith<$Res> {
  _$InheritedAnimationValueCopyWithImpl(this._value, this._then);

  final InheritedAnimationValue _value;
  // ignore: unused_field
  final $Res Function(InheritedAnimationValue) _then;

  @override
  $Res call({
    Object? opacity = freezed,
    Object? scale = freezed,
    Object? translation = freezed,
  }) {
    return _then(_value.copyWith(
      opacity: opacity == freezed
          ? _value.opacity
          : opacity // ignore: cast_nullable_to_non_nullable
              as double,
      scale: scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      translation: translation == freezed
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
abstract class _$InheritedAnimationValueCopyWith<$Res>
    implements $InheritedAnimationValueCopyWith<$Res> {
  factory _$InheritedAnimationValueCopyWith(_InheritedAnimationValue value,
          $Res Function(_InheritedAnimationValue) then) =
      __$InheritedAnimationValueCopyWithImpl<$Res>;
  @override
  $Res call({double opacity, double scale, Offset translation});
}

/// @nodoc
class __$InheritedAnimationValueCopyWithImpl<$Res>
    extends _$InheritedAnimationValueCopyWithImpl<$Res>
    implements _$InheritedAnimationValueCopyWith<$Res> {
  __$InheritedAnimationValueCopyWithImpl(_InheritedAnimationValue _value,
      $Res Function(_InheritedAnimationValue) _then)
      : super(_value, (v) => _then(v as _InheritedAnimationValue));

  @override
  _InheritedAnimationValue get _value =>
      super._value as _InheritedAnimationValue;

  @override
  $Res call({
    Object? opacity = freezed,
    Object? scale = freezed,
    Object? translation = freezed,
  }) {
    return _then(_InheritedAnimationValue(
      opacity: opacity == freezed
          ? _value.opacity
          : opacity // ignore: cast_nullable_to_non_nullable
              as double,
      scale: scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      translation: translation == freezed
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc

class _$_InheritedAnimationValue
    with DiagnosticableTreeMixin
    implements _InheritedAnimationValue {
  const _$_InheritedAnimationValue(
      {this.opacity = 1.0, this.scale = 1.0, this.translation = Offset.zero});

  @JsonKey(defaultValue: 1.0)
  @override
  final double opacity;
  @JsonKey(defaultValue: 1.0)
  @override
  final double scale;
  @JsonKey(defaultValue: Offset.zero)
  @override
  final Offset translation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InheritedAnimationValue(opacity: $opacity, scale: $scale, translation: $translation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InheritedAnimationValue'))
      ..add(DiagnosticsProperty('opacity', opacity))
      ..add(DiagnosticsProperty('scale', scale))
      ..add(DiagnosticsProperty('translation', translation));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InheritedAnimationValue &&
            (identical(other.opacity, opacity) ||
                const DeepCollectionEquality()
                    .equals(other.opacity, opacity)) &&
            (identical(other.scale, scale) ||
                const DeepCollectionEquality().equals(other.scale, scale)) &&
            (identical(other.translation, translation) ||
                const DeepCollectionEquality()
                    .equals(other.translation, translation)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(opacity) ^
      const DeepCollectionEquality().hash(scale) ^
      const DeepCollectionEquality().hash(translation);

  @JsonKey(ignore: true)
  @override
  _$InheritedAnimationValueCopyWith<_InheritedAnimationValue> get copyWith =>
      __$InheritedAnimationValueCopyWithImpl<_InheritedAnimationValue>(
          this, _$identity);
}

abstract class _InheritedAnimationValue implements InheritedAnimationValue {
  const factory _InheritedAnimationValue(
      {double opacity,
      double scale,
      Offset translation}) = _$_InheritedAnimationValue;

  @override
  double get opacity => throw _privateConstructorUsedError;
  @override
  double get scale => throw _privateConstructorUsedError;
  @override
  Offset get translation => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InheritedAnimationValueCopyWith<_InheritedAnimationValue> get copyWith =>
      throw _privateConstructorUsedError;
}
