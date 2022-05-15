// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'revealing_bar_pod.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RevealingBarProps {
  double get safeArea => throw _privateConstructorUsedError;
  bool get onlyShowBelowSafeArea => throw _privateConstructorUsedError;
  bool get revealAtEnd => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RevealingBarPropsCopyWith<RevealingBarProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevealingBarPropsCopyWith<$Res> {
  factory $RevealingBarPropsCopyWith(
          RevealingBarProps value, $Res Function(RevealingBarProps) then) =
      _$RevealingBarPropsCopyWithImpl<$Res>;
  $Res call({double safeArea, bool onlyShowBelowSafeArea, bool revealAtEnd});
}

/// @nodoc
class _$RevealingBarPropsCopyWithImpl<$Res>
    implements $RevealingBarPropsCopyWith<$Res> {
  _$RevealingBarPropsCopyWithImpl(this._value, this._then);

  final RevealingBarProps _value;
  // ignore: unused_field
  final $Res Function(RevealingBarProps) _then;

  @override
  $Res call({
    Object? safeArea = freezed,
    Object? onlyShowBelowSafeArea = freezed,
    Object? revealAtEnd = freezed,
  }) {
    return _then(_value.copyWith(
      safeArea: safeArea == freezed
          ? _value.safeArea
          : safeArea // ignore: cast_nullable_to_non_nullable
              as double,
      onlyShowBelowSafeArea: onlyShowBelowSafeArea == freezed
          ? _value.onlyShowBelowSafeArea
          : onlyShowBelowSafeArea // ignore: cast_nullable_to_non_nullable
              as bool,
      revealAtEnd: revealAtEnd == freezed
          ? _value.revealAtEnd
          : revealAtEnd // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_RevealingBarPropsCopyWith<$Res>
    implements $RevealingBarPropsCopyWith<$Res> {
  factory _$$_RevealingBarPropsCopyWith(_$_RevealingBarProps value,
          $Res Function(_$_RevealingBarProps) then) =
      __$$_RevealingBarPropsCopyWithImpl<$Res>;
  @override
  $Res call({double safeArea, bool onlyShowBelowSafeArea, bool revealAtEnd});
}

/// @nodoc
class __$$_RevealingBarPropsCopyWithImpl<$Res>
    extends _$RevealingBarPropsCopyWithImpl<$Res>
    implements _$$_RevealingBarPropsCopyWith<$Res> {
  __$$_RevealingBarPropsCopyWithImpl(
      _$_RevealingBarProps _value, $Res Function(_$_RevealingBarProps) _then)
      : super(_value, (v) => _then(v as _$_RevealingBarProps));

  @override
  _$_RevealingBarProps get _value => super._value as _$_RevealingBarProps;

  @override
  $Res call({
    Object? safeArea = freezed,
    Object? onlyShowBelowSafeArea = freezed,
    Object? revealAtEnd = freezed,
  }) {
    return _then(_$_RevealingBarProps(
      safeArea: safeArea == freezed
          ? _value.safeArea
          : safeArea // ignore: cast_nullable_to_non_nullable
              as double,
      onlyShowBelowSafeArea: onlyShowBelowSafeArea == freezed
          ? _value.onlyShowBelowSafeArea
          : onlyShowBelowSafeArea // ignore: cast_nullable_to_non_nullable
              as bool,
      revealAtEnd: revealAtEnd == freezed
          ? _value.revealAtEnd
          : revealAtEnd // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_RevealingBarProps extends _RevealingBarProps
    with DiagnosticableTreeMixin {
  const _$_RevealingBarProps(
      {this.safeArea = 0.0,
      this.onlyShowBelowSafeArea = false,
      this.revealAtEnd = false})
      : super._();

  @override
  @JsonKey()
  final double safeArea;
  @override
  @JsonKey()
  final bool onlyShowBelowSafeArea;
  @override
  @JsonKey()
  final bool revealAtEnd;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RevealingBarProps(safeArea: $safeArea, onlyShowBelowSafeArea: $onlyShowBelowSafeArea, revealAtEnd: $revealAtEnd)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RevealingBarProps'))
      ..add(DiagnosticsProperty('safeArea', safeArea))
      ..add(DiagnosticsProperty('onlyShowBelowSafeArea', onlyShowBelowSafeArea))
      ..add(DiagnosticsProperty('revealAtEnd', revealAtEnd));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RevealingBarProps &&
            const DeepCollectionEquality().equals(other.safeArea, safeArea) &&
            const DeepCollectionEquality()
                .equals(other.onlyShowBelowSafeArea, onlyShowBelowSafeArea) &&
            const DeepCollectionEquality()
                .equals(other.revealAtEnd, revealAtEnd));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(safeArea),
      const DeepCollectionEquality().hash(onlyShowBelowSafeArea),
      const DeepCollectionEquality().hash(revealAtEnd));

  @JsonKey(ignore: true)
  @override
  _$$_RevealingBarPropsCopyWith<_$_RevealingBarProps> get copyWith =>
      __$$_RevealingBarPropsCopyWithImpl<_$_RevealingBarProps>(
          this, _$identity);
}

abstract class _RevealingBarProps extends RevealingBarProps {
  const factory _RevealingBarProps(
      {final double safeArea,
      final bool onlyShowBelowSafeArea,
      final bool revealAtEnd}) = _$_RevealingBarProps;
  const _RevealingBarProps._() : super._();

  @override
  double get safeArea => throw _privateConstructorUsedError;
  @override
  bool get onlyShowBelowSafeArea => throw _privateConstructorUsedError;
  @override
  bool get revealAtEnd => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RevealingBarPropsCopyWith<_$_RevealingBarProps> get copyWith =>
      throw _privateConstructorUsedError;
}
