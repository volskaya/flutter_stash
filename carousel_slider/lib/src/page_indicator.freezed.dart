// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'page_indicator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PageIndicatorPropsTearOff {
  const _$PageIndicatorPropsTearOff();

// ignore: unused_element
  _WarmAnimationProps warm(
      {@required Color color, @required Color activeColor}) {
    return _WarmAnimationProps(
      color: color,
      activeColor: activeColor,
    );
  }

// ignore: unused_element
  _ScaleAnimationProps scale(
      {@required Color color,
      @required Color activeColor,
      @required double scale}) {
    return _ScaleAnimationProps(
      color: color,
      activeColor: activeColor,
      scale: scale,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $PageIndicatorProps = _$PageIndicatorPropsTearOff();

/// @nodoc
mixin _$PageIndicatorProps {
  Color get color;
  Color get activeColor;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult warm(Color color, Color activeColor),
    @required TResult scale(Color color, Color activeColor, double scale),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult warm(Color color, Color activeColor),
    TResult scale(Color color, Color activeColor, double scale),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult warm(_WarmAnimationProps value),
    @required TResult scale(_ScaleAnimationProps value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult warm(_WarmAnimationProps value),
    TResult scale(_ScaleAnimationProps value),
    @required TResult orElse(),
  });

  $PageIndicatorPropsCopyWith<PageIndicatorProps> get copyWith;
}

/// @nodoc
abstract class $PageIndicatorPropsCopyWith<$Res> {
  factory $PageIndicatorPropsCopyWith(
          PageIndicatorProps value, $Res Function(PageIndicatorProps) then) =
      _$PageIndicatorPropsCopyWithImpl<$Res>;
  $Res call({Color color, Color activeColor});
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
    Object color = freezed,
    Object activeColor = freezed,
  }) {
    return _then(_value.copyWith(
      color: color == freezed ? _value.color : color as Color,
      activeColor:
          activeColor == freezed ? _value.activeColor : activeColor as Color,
    ));
  }
}

/// @nodoc
abstract class _$WarmAnimationPropsCopyWith<$Res>
    implements $PageIndicatorPropsCopyWith<$Res> {
  factory _$WarmAnimationPropsCopyWith(
          _WarmAnimationProps value, $Res Function(_WarmAnimationProps) then) =
      __$WarmAnimationPropsCopyWithImpl<$Res>;
  @override
  $Res call({Color color, Color activeColor});
}

/// @nodoc
class __$WarmAnimationPropsCopyWithImpl<$Res>
    extends _$PageIndicatorPropsCopyWithImpl<$Res>
    implements _$WarmAnimationPropsCopyWith<$Res> {
  __$WarmAnimationPropsCopyWithImpl(
      _WarmAnimationProps _value, $Res Function(_WarmAnimationProps) _then)
      : super(_value, (v) => _then(v as _WarmAnimationProps));

  @override
  _WarmAnimationProps get _value => super._value as _WarmAnimationProps;

  @override
  $Res call({
    Object color = freezed,
    Object activeColor = freezed,
  }) {
    return _then(_WarmAnimationProps(
      color: color == freezed ? _value.color : color as Color,
      activeColor:
          activeColor == freezed ? _value.activeColor : activeColor as Color,
    ));
  }
}

/// @nodoc
class _$_WarmAnimationProps
    with DiagnosticableTreeMixin
    implements _WarmAnimationProps {
  const _$_WarmAnimationProps(
      {@required this.color, @required this.activeColor})
      : assert(color != null),
        assert(activeColor != null);

  @override
  final Color color;
  @override
  final Color activeColor;

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
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.activeColor, activeColor) ||
                const DeepCollectionEquality()
                    .equals(other.activeColor, activeColor)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(activeColor);

  @override
  _$WarmAnimationPropsCopyWith<_WarmAnimationProps> get copyWith =>
      __$WarmAnimationPropsCopyWithImpl<_WarmAnimationProps>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult warm(Color color, Color activeColor),
    @required TResult scale(Color color, Color activeColor, double scale),
  }) {
    assert(warm != null);
    assert(scale != null);
    return warm(color, activeColor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult warm(Color color, Color activeColor),
    TResult scale(Color color, Color activeColor, double scale),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (warm != null) {
      return warm(color, activeColor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult warm(_WarmAnimationProps value),
    @required TResult scale(_ScaleAnimationProps value),
  }) {
    assert(warm != null);
    assert(scale != null);
    return warm(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult warm(_WarmAnimationProps value),
    TResult scale(_ScaleAnimationProps value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (warm != null) {
      return warm(this);
    }
    return orElse();
  }
}

abstract class _WarmAnimationProps implements PageIndicatorProps {
  const factory _WarmAnimationProps(
      {@required Color color,
      @required Color activeColor}) = _$_WarmAnimationProps;

  @override
  Color get color;
  @override
  Color get activeColor;
  @override
  _$WarmAnimationPropsCopyWith<_WarmAnimationProps> get copyWith;
}

/// @nodoc
abstract class _$ScaleAnimationPropsCopyWith<$Res>
    implements $PageIndicatorPropsCopyWith<$Res> {
  factory _$ScaleAnimationPropsCopyWith(_ScaleAnimationProps value,
          $Res Function(_ScaleAnimationProps) then) =
      __$ScaleAnimationPropsCopyWithImpl<$Res>;
  @override
  $Res call({Color color, Color activeColor, double scale});
}

/// @nodoc
class __$ScaleAnimationPropsCopyWithImpl<$Res>
    extends _$PageIndicatorPropsCopyWithImpl<$Res>
    implements _$ScaleAnimationPropsCopyWith<$Res> {
  __$ScaleAnimationPropsCopyWithImpl(
      _ScaleAnimationProps _value, $Res Function(_ScaleAnimationProps) _then)
      : super(_value, (v) => _then(v as _ScaleAnimationProps));

  @override
  _ScaleAnimationProps get _value => super._value as _ScaleAnimationProps;

  @override
  $Res call({
    Object color = freezed,
    Object activeColor = freezed,
    Object scale = freezed,
  }) {
    return _then(_ScaleAnimationProps(
      color: color == freezed ? _value.color : color as Color,
      activeColor:
          activeColor == freezed ? _value.activeColor : activeColor as Color,
      scale: scale == freezed ? _value.scale : scale as double,
    ));
  }
}

/// @nodoc
class _$_ScaleAnimationProps
    with DiagnosticableTreeMixin
    implements _ScaleAnimationProps {
  const _$_ScaleAnimationProps(
      {@required this.color, @required this.activeColor, @required this.scale})
      : assert(color != null),
        assert(activeColor != null),
        assert(scale != null);

  @override
  final Color color;
  @override
  final Color activeColor;
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
        (other is _ScaleAnimationProps &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.activeColor, activeColor) ||
                const DeepCollectionEquality()
                    .equals(other.activeColor, activeColor)) &&
            (identical(other.scale, scale) ||
                const DeepCollectionEquality().equals(other.scale, scale)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(activeColor) ^
      const DeepCollectionEquality().hash(scale);

  @override
  _$ScaleAnimationPropsCopyWith<_ScaleAnimationProps> get copyWith =>
      __$ScaleAnimationPropsCopyWithImpl<_ScaleAnimationProps>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult warm(Color color, Color activeColor),
    @required TResult scale(Color color, Color activeColor, double scale),
  }) {
    assert(warm != null);
    assert(scale != null);
    return scale(color, activeColor, this.scale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult warm(Color color, Color activeColor),
    TResult scale(Color color, Color activeColor, double scale),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (scale != null) {
      return scale(color, activeColor, this.scale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult warm(_WarmAnimationProps value),
    @required TResult scale(_ScaleAnimationProps value),
  }) {
    assert(warm != null);
    assert(scale != null);
    return scale(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult warm(_WarmAnimationProps value),
    TResult scale(_ScaleAnimationProps value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (scale != null) {
      return scale(this);
    }
    return orElse();
  }
}

abstract class _ScaleAnimationProps implements PageIndicatorProps {
  const factory _ScaleAnimationProps(
      {@required Color color,
      @required Color activeColor,
      @required double scale}) = _$_ScaleAnimationProps;

  @override
  Color get color;
  @override
  Color get activeColor;
  double get scale;
  @override
  _$ScaleAnimationPropsCopyWith<_ScaleAnimationProps> get copyWith;
}
