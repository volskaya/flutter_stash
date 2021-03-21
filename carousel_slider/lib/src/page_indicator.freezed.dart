// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'page_indicator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PageIndicatorPropsTearOff {
  const _$PageIndicatorPropsTearOff();

  _WarmAnimationProps warm({required Color color, required Color activeColor}) {
    return _WarmAnimationProps(
      color: color,
      activeColor: activeColor,
    );
  }

  _ScaleAnimationProps scale({required Color color, required Color activeColor, required double scale}) {
    return _ScaleAnimationProps(
      color: color,
      activeColor: activeColor,
      scale: scale,
    );
  }

  _WideAnimationProps wide({required Color color, required Color activeColor, BorderRadius? borderRadius}) {
    return _WideAnimationProps(
      color: color,
      activeColor: activeColor,
      borderRadius: borderRadius,
    );
  }
}

/// @nodoc
const $PageIndicatorProps = _$PageIndicatorPropsTearOff();

/// @nodoc
mixin _$PageIndicatorProps {
  Color get color => throw _privateConstructorUsedError;
  Color get activeColor => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Color color, Color activeColor) warm,
    required TResult Function(Color color, Color activeColor, double scale) scale,
    required TResult Function(Color color, Color activeColor, BorderRadius? borderRadius) wide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Color color, Color activeColor)? warm,
    TResult Function(Color color, Color activeColor, double scale)? scale,
    TResult Function(Color color, Color activeColor, BorderRadius? borderRadius)? wide,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WarmAnimationProps value) warm,
    required TResult Function(_ScaleAnimationProps value) scale,
    required TResult Function(_WideAnimationProps value) wide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WarmAnimationProps value)? warm,
    TResult Function(_ScaleAnimationProps value)? scale,
    TResult Function(_WideAnimationProps value)? wide,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PageIndicatorPropsCopyWith<PageIndicatorProps> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageIndicatorPropsCopyWith<$Res> {
  factory $PageIndicatorPropsCopyWith(PageIndicatorProps value, $Res Function(PageIndicatorProps) then) =
      _$PageIndicatorPropsCopyWithImpl<$Res>;
  $Res call({Color color, Color activeColor});
}

/// @nodoc
class _$PageIndicatorPropsCopyWithImpl<$Res> implements $PageIndicatorPropsCopyWith<$Res> {
  _$PageIndicatorPropsCopyWithImpl(this._value, this._then);

  final PageIndicatorProps _value;
  // ignore: unused_field
  final $Res Function(PageIndicatorProps) _then;

  @override
  $Res call({
    Object? color = freezed,
    Object? activeColor = freezed,
  }) {
    return _then(_value.copyWith(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      activeColor: activeColor == freezed
          ? _value.activeColor
          : activeColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
abstract class _$WarmAnimationPropsCopyWith<$Res> implements $PageIndicatorPropsCopyWith<$Res> {
  factory _$WarmAnimationPropsCopyWith(_WarmAnimationProps value, $Res Function(_WarmAnimationProps) then) =
      __$WarmAnimationPropsCopyWithImpl<$Res>;
  @override
  $Res call({Color color, Color activeColor});
}

/// @nodoc
class __$WarmAnimationPropsCopyWithImpl<$Res> extends _$PageIndicatorPropsCopyWithImpl<$Res>
    implements _$WarmAnimationPropsCopyWith<$Res> {
  __$WarmAnimationPropsCopyWithImpl(_WarmAnimationProps _value, $Res Function(_WarmAnimationProps) _then)
      : super(_value, (v) => _then(v as _WarmAnimationProps));

  @override
  _WarmAnimationProps get _value => super._value as _WarmAnimationProps;

  @override
  $Res call({
    Object? color = freezed,
    Object? activeColor = freezed,
  }) {
    return _then(_WarmAnimationProps(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      activeColor: activeColor == freezed
          ? _value.activeColor
          : activeColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
class _$_WarmAnimationProps with DiagnosticableTreeMixin implements _WarmAnimationProps {
  const _$_WarmAnimationProps({required this.color, required this.activeColor});

  @override final Color color;
  @override final Color activeColor;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PageIndicatorProps.warm(color: $color, activeColor: $activeColor)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PageIndicatorProps.warm'))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('activeColor', activeColor));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WarmAnimationProps &&
            (identical(other.color, color) || const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.activeColor, activeColor) ||
                const DeepCollectionEquality().equals(other.activeColor, activeColor)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(activeColor);

  @JsonKey(ignore: true) @override
  _$WarmAnimationPropsCopyWith<_WarmAnimationProps> get copyWith =>
      __$WarmAnimationPropsCopyWithImpl<_WarmAnimationProps>(this, _$identity);

  @override @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Color color, Color activeColor) warm,
    required TResult Function(Color color, Color activeColor, double scale) scale,
    required TResult Function(Color color, Color activeColor, BorderRadius? borderRadius) wide,
  }) {
    return warm(color, activeColor);
  }

  @override @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Color color, Color activeColor)? warm,
    TResult Function(Color color, Color activeColor, double scale)? scale,
    TResult Function(Color color, Color activeColor, BorderRadius? borderRadius)? wide,
    required TResult orElse(),
  }) {
    if (warm != null) {
      return warm(color, activeColor);
    }
    return orElse();
  }

  @override @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WarmAnimationProps value) warm,
    required TResult Function(_ScaleAnimationProps value) scale,
    required TResult Function(_WideAnimationProps value) wide,
  }) {
    return warm(this);
  }

  @override @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WarmAnimationProps value)? warm,
    TResult Function(_ScaleAnimationProps value)? scale,
    TResult Function(_WideAnimationProps value)? wide,
    required TResult orElse(),
  }) {
    if (warm != null) {
      return warm(this);
    }
    return orElse();
  }
}

abstract class _WarmAnimationProps implements PageIndicatorProps {
  const factory _WarmAnimationProps({required Color color, required Color activeColor}) = _$_WarmAnimationProps;

  @override
  Color get color => throw _privateConstructorUsedError;
  @override
  Color get activeColor => throw _privateConstructorUsedError;
  @override @JsonKey(ignore: true)
  _$WarmAnimationPropsCopyWith<_WarmAnimationProps> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ScaleAnimationPropsCopyWith<$Res> implements $PageIndicatorPropsCopyWith<$Res> {
  factory _$ScaleAnimationPropsCopyWith(_ScaleAnimationProps value, $Res Function(_ScaleAnimationProps) then) =
      __$ScaleAnimationPropsCopyWithImpl<$Res>;
  @override
  $Res call({Color color, Color activeColor, double scale});
}

/// @nodoc
class __$ScaleAnimationPropsCopyWithImpl<$Res> extends _$PageIndicatorPropsCopyWithImpl<$Res>
    implements _$ScaleAnimationPropsCopyWith<$Res> {
  __$ScaleAnimationPropsCopyWithImpl(_ScaleAnimationProps _value, $Res Function(_ScaleAnimationProps) _then)
      : super(_value, (v) => _then(v as _ScaleAnimationProps));

  @override
  _ScaleAnimationProps get _value => super._value as _ScaleAnimationProps;

  @override
  $Res call({
    Object? color = freezed,
    Object? activeColor = freezed,
    Object? scale = freezed,
  }) {
    return _then(_ScaleAnimationProps(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      activeColor: activeColor == freezed
          ? _value.activeColor
          : activeColor // ignore: cast_nullable_to_non_nullable
              as Color,
      scale: scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
class _$_ScaleAnimationProps with DiagnosticableTreeMixin implements _ScaleAnimationProps {
  const _$_ScaleAnimationProps({required this.color, required this.activeColor, required this.scale});

  @override final Color color;
  @override final Color activeColor;
  @override final double scale;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PageIndicatorProps.scale(color: $color, activeColor: $activeColor, scale: $scale)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PageIndicatorProps.scale'))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('activeColor', activeColor))
      ..add(DiagnosticsProperty('scale', scale));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ScaleAnimationProps &&
            (identical(other.color, color) || const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.activeColor, activeColor) ||
                const DeepCollectionEquality().equals(other.activeColor, activeColor)) &&
            (identical(other.scale, scale) || const DeepCollectionEquality().equals(other.scale, scale)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(activeColor) ^
      const DeepCollectionEquality().hash(scale);

  @JsonKey(ignore: true) @override
  _$ScaleAnimationPropsCopyWith<_ScaleAnimationProps> get copyWith =>
      __$ScaleAnimationPropsCopyWithImpl<_ScaleAnimationProps>(this, _$identity);

  @override @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Color color, Color activeColor) warm,
    required TResult Function(Color color, Color activeColor, double scale) scale,
    required TResult Function(Color color, Color activeColor, BorderRadius? borderRadius) wide,
  }) {
    return scale(color, activeColor, this.scale);
  }

  @override @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Color color, Color activeColor)? warm,
    TResult Function(Color color, Color activeColor, double scale)? scale,
    TResult Function(Color color, Color activeColor, BorderRadius? borderRadius)? wide,
    required TResult orElse(),
  }) {
    if (scale != null) {
      return scale(color, activeColor, this.scale);
    }
    return orElse();
  }

  @override @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WarmAnimationProps value) warm,
    required TResult Function(_ScaleAnimationProps value) scale,
    required TResult Function(_WideAnimationProps value) wide,
  }) {
    return scale(this);
  }

  @override @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WarmAnimationProps value)? warm,
    TResult Function(_ScaleAnimationProps value)? scale,
    TResult Function(_WideAnimationProps value)? wide,
    required TResult orElse(),
  }) {
    if (scale != null) {
      return scale(this);
    }
    return orElse();
  }
}

abstract class _ScaleAnimationProps implements PageIndicatorProps {
  const factory _ScaleAnimationProps({required Color color, required Color activeColor, required double scale}) =
      _$_ScaleAnimationProps;

  @override
  Color get color => throw _privateConstructorUsedError;
  @override
  Color get activeColor => throw _privateConstructorUsedError;
  double get scale => throw _privateConstructorUsedError;
  @override @JsonKey(ignore: true)
  _$ScaleAnimationPropsCopyWith<_ScaleAnimationProps> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$WideAnimationPropsCopyWith<$Res> implements $PageIndicatorPropsCopyWith<$Res> {
  factory _$WideAnimationPropsCopyWith(_WideAnimationProps value, $Res Function(_WideAnimationProps) then) =
      __$WideAnimationPropsCopyWithImpl<$Res>;
  @override
  $Res call({Color color, Color activeColor, BorderRadius? borderRadius});
}

/// @nodoc
class __$WideAnimationPropsCopyWithImpl<$Res> extends _$PageIndicatorPropsCopyWithImpl<$Res>
    implements _$WideAnimationPropsCopyWith<$Res> {
  __$WideAnimationPropsCopyWithImpl(_WideAnimationProps _value, $Res Function(_WideAnimationProps) _then)
      : super(_value, (v) => _then(v as _WideAnimationProps));

  @override
  _WideAnimationProps get _value => super._value as _WideAnimationProps;

  @override
  $Res call({
    Object? color = freezed,
    Object? activeColor = freezed,
    Object? borderRadius = freezed,
  }) {
    return _then(_WideAnimationProps(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      activeColor: activeColor == freezed
          ? _value.activeColor
          : activeColor // ignore: cast_nullable_to_non_nullable
              as Color,
      borderRadius: borderRadius == freezed
          ? _value.borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as BorderRadius?,
    ));
  }
}

/// @nodoc
class _$_WideAnimationProps with DiagnosticableTreeMixin implements _WideAnimationProps {
  const _$_WideAnimationProps({required this.color, required this.activeColor, this.borderRadius});

  @override final Color color;
  @override final Color activeColor;
  @override final BorderRadius? borderRadius;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PageIndicatorProps.wide(color: $color, activeColor: $activeColor, borderRadius: $borderRadius)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PageIndicatorProps.wide'))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('activeColor', activeColor))
      ..add(DiagnosticsProperty('borderRadius', borderRadius));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WideAnimationProps &&
            (identical(other.color, color) || const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.activeColor, activeColor) ||
                const DeepCollectionEquality().equals(other.activeColor, activeColor)) &&
            (identical(other.borderRadius, borderRadius) ||
                const DeepCollectionEquality().equals(other.borderRadius, borderRadius)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(activeColor) ^
      const DeepCollectionEquality().hash(borderRadius);

  @JsonKey(ignore: true) @override
  _$WideAnimationPropsCopyWith<_WideAnimationProps> get copyWith =>
      __$WideAnimationPropsCopyWithImpl<_WideAnimationProps>(this, _$identity);

  @override @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Color color, Color activeColor) warm,
    required TResult Function(Color color, Color activeColor, double scale) scale,
    required TResult Function(Color color, Color activeColor, BorderRadius? borderRadius) wide,
  }) {
    return wide(color, activeColor, borderRadius);
  }

  @override @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Color color, Color activeColor)? warm,
    TResult Function(Color color, Color activeColor, double scale)? scale,
    TResult Function(Color color, Color activeColor, BorderRadius? borderRadius)? wide,
    required TResult orElse(),
  }) {
    if (wide != null) {
      return wide(color, activeColor, borderRadius);
    }
    return orElse();
  }

  @override @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WarmAnimationProps value) warm,
    required TResult Function(_ScaleAnimationProps value) scale,
    required TResult Function(_WideAnimationProps value) wide,
  }) {
    return wide(this);
  }

  @override @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_WarmAnimationProps value)? warm,
    TResult Function(_ScaleAnimationProps value)? scale,
    TResult Function(_WideAnimationProps value)? wide,
    required TResult orElse(),
  }) {
    if (wide != null) {
      return wide(this);
    }
    return orElse();
  }
}

abstract class _WideAnimationProps implements PageIndicatorProps {
  const factory _WideAnimationProps({required Color color, required Color activeColor, BorderRadius? borderRadius}) =
      _$_WideAnimationProps;

  @override
  Color get color => throw _privateConstructorUsedError;
  @override
  Color get activeColor => throw _privateConstructorUsedError;
  BorderRadius? get borderRadius => throw _privateConstructorUsedError;
  @override @JsonKey(ignore: true)
  _$WideAnimationPropsCopyWith<_WideAnimationProps> get copyWith => throw _privateConstructorUsedError;
}
