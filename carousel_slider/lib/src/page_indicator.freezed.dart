// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'page_indicator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PageIndicatorProps {
  ui.Color get color => throw _privateConstructorUsedError;
  ui.Color get activeColor => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ui.Color color, ui.Color activeColor) warm,
    required TResult Function(
            ui.Color color, ui.Color activeColor, double scale)
        scale,
    required TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)
        wide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ui.Color color, ui.Color activeColor)? warm,
    TResult Function(ui.Color color, ui.Color activeColor, double scale)? scale,
    TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)?
        wide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ui.Color color, ui.Color activeColor)? warm,
    TResult Function(ui.Color color, ui.Color activeColor, double scale)? scale,
    TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)?
        wide,
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_WarmAnimationProps value)? warm,
    TResult Function(_ScaleAnimationProps value)? scale,
    TResult Function(_WideAnimationProps value)? wide,
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
  $PageIndicatorPropsCopyWith<PageIndicatorProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageIndicatorPropsCopyWith<$Res> {
  factory $PageIndicatorPropsCopyWith(
          PageIndicatorProps value, $Res Function(PageIndicatorProps) then) =
      _$PageIndicatorPropsCopyWithImpl<$Res>;
  $Res call({ui.Color color, ui.Color activeColor});
}

/// @nodoc
class _$PageIndicatorPropsCopyWithImpl<$Res>
    implements $PageIndicatorPropsCopyWith<$Res> {
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
              as ui.Color,
      activeColor: activeColor == freezed
          ? _value.activeColor
          : activeColor // ignore: cast_nullable_to_non_nullable
              as ui.Color,
    ));
  }
}

/// @nodoc
abstract class _$$_WarmAnimationPropsCopyWith<$Res>
    implements $PageIndicatorPropsCopyWith<$Res> {
  factory _$$_WarmAnimationPropsCopyWith(_$_WarmAnimationProps value,
          $Res Function(_$_WarmAnimationProps) then) =
      __$$_WarmAnimationPropsCopyWithImpl<$Res>;
  @override
  $Res call({ui.Color color, ui.Color activeColor});
}

/// @nodoc
class __$$_WarmAnimationPropsCopyWithImpl<$Res>
    extends _$PageIndicatorPropsCopyWithImpl<$Res>
    implements _$$_WarmAnimationPropsCopyWith<$Res> {
  __$$_WarmAnimationPropsCopyWithImpl(
      _$_WarmAnimationProps _value, $Res Function(_$_WarmAnimationProps) _then)
      : super(_value, (v) => _then(v as _$_WarmAnimationProps));

  @override
  _$_WarmAnimationProps get _value => super._value as _$_WarmAnimationProps;

  @override
  $Res call({
    Object? color = freezed,
    Object? activeColor = freezed,
  }) {
    return _then(_$_WarmAnimationProps(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ui.Color,
      activeColor: activeColor == freezed
          ? _value.activeColor
          : activeColor // ignore: cast_nullable_to_non_nullable
              as ui.Color,
    ));
  }
}

/// @nodoc

class _$_WarmAnimationProps
    with DiagnosticableTreeMixin
    implements _WarmAnimationProps {
  const _$_WarmAnimationProps({required this.color, required this.activeColor});

  @override
  final ui.Color color;
  @override
  final ui.Color activeColor;

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
        (other.runtimeType == runtimeType &&
            other is _$_WarmAnimationProps &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality()
                .equals(other.activeColor, activeColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(activeColor));

  @JsonKey(ignore: true)
  @override
  _$$_WarmAnimationPropsCopyWith<_$_WarmAnimationProps> get copyWith =>
      __$$_WarmAnimationPropsCopyWithImpl<_$_WarmAnimationProps>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ui.Color color, ui.Color activeColor) warm,
    required TResult Function(
            ui.Color color, ui.Color activeColor, double scale)
        scale,
    required TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)
        wide,
  }) {
    return warm(color, activeColor);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ui.Color color, ui.Color activeColor)? warm,
    TResult Function(ui.Color color, ui.Color activeColor, double scale)? scale,
    TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)?
        wide,
  }) {
    return warm?.call(color, activeColor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ui.Color color, ui.Color activeColor)? warm,
    TResult Function(ui.Color color, ui.Color activeColor, double scale)? scale,
    TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)?
        wide,
    required TResult orElse(),
  }) {
    if (warm != null) {
      return warm(color, activeColor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WarmAnimationProps value) warm,
    required TResult Function(_ScaleAnimationProps value) scale,
    required TResult Function(_WideAnimationProps value) wide,
  }) {
    return warm(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_WarmAnimationProps value)? warm,
    TResult Function(_ScaleAnimationProps value)? scale,
    TResult Function(_WideAnimationProps value)? wide,
  }) {
    return warm?.call(this);
  }

  @override
  @optionalTypeArgs
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
  const factory _WarmAnimationProps(
      {required final ui.Color color,
      required final ui.Color activeColor}) = _$_WarmAnimationProps;

  @override
  ui.Color get color => throw _privateConstructorUsedError;
  @override
  ui.Color get activeColor => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_WarmAnimationPropsCopyWith<_$_WarmAnimationProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ScaleAnimationPropsCopyWith<$Res>
    implements $PageIndicatorPropsCopyWith<$Res> {
  factory _$$_ScaleAnimationPropsCopyWith(_$_ScaleAnimationProps value,
          $Res Function(_$_ScaleAnimationProps) then) =
      __$$_ScaleAnimationPropsCopyWithImpl<$Res>;
  @override
  $Res call({ui.Color color, ui.Color activeColor, double scale});
}

/// @nodoc
class __$$_ScaleAnimationPropsCopyWithImpl<$Res>
    extends _$PageIndicatorPropsCopyWithImpl<$Res>
    implements _$$_ScaleAnimationPropsCopyWith<$Res> {
  __$$_ScaleAnimationPropsCopyWithImpl(_$_ScaleAnimationProps _value,
      $Res Function(_$_ScaleAnimationProps) _then)
      : super(_value, (v) => _then(v as _$_ScaleAnimationProps));

  @override
  _$_ScaleAnimationProps get _value => super._value as _$_ScaleAnimationProps;

  @override
  $Res call({
    Object? color = freezed,
    Object? activeColor = freezed,
    Object? scale = freezed,
  }) {
    return _then(_$_ScaleAnimationProps(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ui.Color,
      activeColor: activeColor == freezed
          ? _value.activeColor
          : activeColor // ignore: cast_nullable_to_non_nullable
              as ui.Color,
      scale: scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$_ScaleAnimationProps
    with DiagnosticableTreeMixin
    implements _ScaleAnimationProps {
  const _$_ScaleAnimationProps(
      {required this.color, required this.activeColor, required this.scale});

  @override
  final ui.Color color;
  @override
  final ui.Color activeColor;
  @override
  final double scale;

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
        (other.runtimeType == runtimeType &&
            other is _$_ScaleAnimationProps &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality()
                .equals(other.activeColor, activeColor) &&
            const DeepCollectionEquality().equals(other.scale, scale));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(activeColor),
      const DeepCollectionEquality().hash(scale));

  @JsonKey(ignore: true)
  @override
  _$$_ScaleAnimationPropsCopyWith<_$_ScaleAnimationProps> get copyWith =>
      __$$_ScaleAnimationPropsCopyWithImpl<_$_ScaleAnimationProps>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ui.Color color, ui.Color activeColor) warm,
    required TResult Function(
            ui.Color color, ui.Color activeColor, double scale)
        scale,
    required TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)
        wide,
  }) {
    return scale(color, activeColor, this.scale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ui.Color color, ui.Color activeColor)? warm,
    TResult Function(ui.Color color, ui.Color activeColor, double scale)? scale,
    TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)?
        wide,
  }) {
    return scale?.call(color, activeColor, this.scale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ui.Color color, ui.Color activeColor)? warm,
    TResult Function(ui.Color color, ui.Color activeColor, double scale)? scale,
    TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)?
        wide,
    required TResult orElse(),
  }) {
    if (scale != null) {
      return scale(color, activeColor, this.scale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WarmAnimationProps value) warm,
    required TResult Function(_ScaleAnimationProps value) scale,
    required TResult Function(_WideAnimationProps value) wide,
  }) {
    return scale(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_WarmAnimationProps value)? warm,
    TResult Function(_ScaleAnimationProps value)? scale,
    TResult Function(_WideAnimationProps value)? wide,
  }) {
    return scale?.call(this);
  }

  @override
  @optionalTypeArgs
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
  const factory _ScaleAnimationProps(
      {required final ui.Color color,
      required final ui.Color activeColor,
      required final double scale}) = _$_ScaleAnimationProps;

  @override
  ui.Color get color => throw _privateConstructorUsedError;
  @override
  ui.Color get activeColor => throw _privateConstructorUsedError;
  double get scale => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ScaleAnimationPropsCopyWith<_$_ScaleAnimationProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_WideAnimationPropsCopyWith<$Res>
    implements $PageIndicatorPropsCopyWith<$Res> {
  factory _$$_WideAnimationPropsCopyWith(_$_WideAnimationProps value,
          $Res Function(_$_WideAnimationProps) then) =
      __$$_WideAnimationPropsCopyWithImpl<$Res>;
  @override
  $Res call({ui.Color color, ui.Color activeColor, BorderRadius? borderRadius});
}

/// @nodoc
class __$$_WideAnimationPropsCopyWithImpl<$Res>
    extends _$PageIndicatorPropsCopyWithImpl<$Res>
    implements _$$_WideAnimationPropsCopyWith<$Res> {
  __$$_WideAnimationPropsCopyWithImpl(
      _$_WideAnimationProps _value, $Res Function(_$_WideAnimationProps) _then)
      : super(_value, (v) => _then(v as _$_WideAnimationProps));

  @override
  _$_WideAnimationProps get _value => super._value as _$_WideAnimationProps;

  @override
  $Res call({
    Object? color = freezed,
    Object? activeColor = freezed,
    Object? borderRadius = freezed,
  }) {
    return _then(_$_WideAnimationProps(
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ui.Color,
      activeColor: activeColor == freezed
          ? _value.activeColor
          : activeColor // ignore: cast_nullable_to_non_nullable
              as ui.Color,
      borderRadius: borderRadius == freezed
          ? _value.borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as BorderRadius?,
    ));
  }
}

/// @nodoc

class _$_WideAnimationProps
    with DiagnosticableTreeMixin
    implements _WideAnimationProps {
  const _$_WideAnimationProps(
      {required this.color, required this.activeColor, this.borderRadius});

  @override
  final ui.Color color;
  @override
  final ui.Color activeColor;
  @override
  final BorderRadius? borderRadius;

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
        (other.runtimeType == runtimeType &&
            other is _$_WideAnimationProps &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality()
                .equals(other.activeColor, activeColor) &&
            const DeepCollectionEquality()
                .equals(other.borderRadius, borderRadius));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(activeColor),
      const DeepCollectionEquality().hash(borderRadius));

  @JsonKey(ignore: true)
  @override
  _$$_WideAnimationPropsCopyWith<_$_WideAnimationProps> get copyWith =>
      __$$_WideAnimationPropsCopyWithImpl<_$_WideAnimationProps>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ui.Color color, ui.Color activeColor) warm,
    required TResult Function(
            ui.Color color, ui.Color activeColor, double scale)
        scale,
    required TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)
        wide,
  }) {
    return wide(color, activeColor, borderRadius);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ui.Color color, ui.Color activeColor)? warm,
    TResult Function(ui.Color color, ui.Color activeColor, double scale)? scale,
    TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)?
        wide,
  }) {
    return wide?.call(color, activeColor, borderRadius);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ui.Color color, ui.Color activeColor)? warm,
    TResult Function(ui.Color color, ui.Color activeColor, double scale)? scale,
    TResult Function(
            ui.Color color, ui.Color activeColor, BorderRadius? borderRadius)?
        wide,
    required TResult orElse(),
  }) {
    if (wide != null) {
      return wide(color, activeColor, borderRadius);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_WarmAnimationProps value) warm,
    required TResult Function(_ScaleAnimationProps value) scale,
    required TResult Function(_WideAnimationProps value) wide,
  }) {
    return wide(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_WarmAnimationProps value)? warm,
    TResult Function(_ScaleAnimationProps value)? scale,
    TResult Function(_WideAnimationProps value)? wide,
  }) {
    return wide?.call(this);
  }

  @override
  @optionalTypeArgs
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
  const factory _WideAnimationProps(
      {required final ui.Color color,
      required final ui.Color activeColor,
      final BorderRadius? borderRadius}) = _$_WideAnimationProps;

  @override
  ui.Color get color => throw _privateConstructorUsedError;
  @override
  ui.Color get activeColor => throw _privateConstructorUsedError;
  BorderRadius? get borderRadius => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_WideAnimationPropsCopyWith<_$_WideAnimationProps> get copyWith =>
      throw _privateConstructorUsedError;
}
