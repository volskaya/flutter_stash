// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'layout_builder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
NativeTextStyle _$NativeTextStyleFromJson(Map<String, dynamic> json) {
  return _NativeTextStyle.fromJson(json);
}

/// @nodoc
class _$NativeTextStyleTearOff {
  const _$NativeTextStyleTearOff();

// ignore: unused_element
  _NativeTextStyle call(
      {double textSize = 16.0,
      double letterSpacing = 1.0,
      int minLines = 1,
      int maxLines,
      NativeTypeface typeface,
      @ColorHexConverter() Color textColor}) {
    return _NativeTextStyle(
      textSize: textSize,
      letterSpacing: letterSpacing,
      minLines: minLines,
      maxLines: maxLines,
      typeface: typeface,
      textColor: textColor,
    );
  }

// ignore: unused_element
  NativeTextStyle fromJson(Map<String, Object> json) {
    return NativeTextStyle.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $NativeTextStyle = _$NativeTextStyleTearOff();

/// @nodoc
mixin _$NativeTextStyle {
  double get textSize;
  double get letterSpacing;
  int get minLines;
  int get maxLines;
  NativeTypeface get typeface;
  @ColorHexConverter()
  Color get textColor;

  Map<String, dynamic> toJson();
  $NativeTextStyleCopyWith<NativeTextStyle> get copyWith;
}

/// @nodoc
abstract class $NativeTextStyleCopyWith<$Res> {
  factory $NativeTextStyleCopyWith(
          NativeTextStyle value, $Res Function(NativeTextStyle) then) =
      _$NativeTextStyleCopyWithImpl<$Res>;
  $Res call(
      {double textSize,
      double letterSpacing,
      int minLines,
      int maxLines,
      NativeTypeface typeface,
      @ColorHexConverter() Color textColor});
}

/// @nodoc
class _$NativeTextStyleCopyWithImpl<$Res>
    implements $NativeTextStyleCopyWith<$Res> {
  _$NativeTextStyleCopyWithImpl(this._value, this._then);

  final NativeTextStyle _value;
  // ignore: unused_field
  final $Res Function(NativeTextStyle) _then;

  @override
  $Res call({
    Object textSize = freezed,
    Object letterSpacing = freezed,
    Object minLines = freezed,
    Object maxLines = freezed,
    Object typeface = freezed,
    Object textColor = freezed,
  }) {
    return _then(_value.copyWith(
      textSize: textSize == freezed ? _value.textSize : textSize as double,
      letterSpacing: letterSpacing == freezed
          ? _value.letterSpacing
          : letterSpacing as double,
      minLines: minLines == freezed ? _value.minLines : minLines as int,
      maxLines: maxLines == freezed ? _value.maxLines : maxLines as int,
      typeface:
          typeface == freezed ? _value.typeface : typeface as NativeTypeface,
      textColor: textColor == freezed ? _value.textColor : textColor as Color,
    ));
  }
}

/// @nodoc
abstract class _$NativeTextStyleCopyWith<$Res>
    implements $NativeTextStyleCopyWith<$Res> {
  factory _$NativeTextStyleCopyWith(
          _NativeTextStyle value, $Res Function(_NativeTextStyle) then) =
      __$NativeTextStyleCopyWithImpl<$Res>;
  @override
  $Res call(
      {double textSize,
      double letterSpacing,
      int minLines,
      int maxLines,
      NativeTypeface typeface,
      @ColorHexConverter() Color textColor});
}

/// @nodoc
class __$NativeTextStyleCopyWithImpl<$Res>
    extends _$NativeTextStyleCopyWithImpl<$Res>
    implements _$NativeTextStyleCopyWith<$Res> {
  __$NativeTextStyleCopyWithImpl(
      _NativeTextStyle _value, $Res Function(_NativeTextStyle) _then)
      : super(_value, (v) => _then(v as _NativeTextStyle));

  @override
  _NativeTextStyle get _value => super._value as _NativeTextStyle;

  @override
  $Res call({
    Object textSize = freezed,
    Object letterSpacing = freezed,
    Object minLines = freezed,
    Object maxLines = freezed,
    Object typeface = freezed,
    Object textColor = freezed,
  }) {
    return _then(_NativeTextStyle(
      textSize: textSize == freezed ? _value.textSize : textSize as double,
      letterSpacing: letterSpacing == freezed
          ? _value.letterSpacing
          : letterSpacing as double,
      minLines: minLines == freezed ? _value.minLines : minLines as int,
      maxLines: maxLines == freezed ? _value.maxLines : maxLines as int,
      typeface:
          typeface == freezed ? _value.typeface : typeface as NativeTypeface,
      textColor: textColor == freezed ? _value.textColor : textColor as Color,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_NativeTextStyle implements _NativeTextStyle {
  const _$_NativeTextStyle(
      {this.textSize = 16.0,
      this.letterSpacing = 1.0,
      this.minLines = 1,
      this.maxLines,
      this.typeface,
      @ColorHexConverter() this.textColor})
      : assert(textSize != null),
        assert(letterSpacing != null),
        assert(minLines != null);

  factory _$_NativeTextStyle.fromJson(Map<String, dynamic> json) =>
      _$_$_NativeTextStyleFromJson(json);

  @JsonKey(defaultValue: 16.0)
  @override
  final double textSize;
  @JsonKey(defaultValue: 1.0)
  @override
  final double letterSpacing;
  @JsonKey(defaultValue: 1)
  @override
  final int minLines;
  @override
  final int maxLines;
  @override
  final NativeTypeface typeface;
  @override
  @ColorHexConverter()
  final Color textColor;

  @override
  String toString() {
    return 'NativeTextStyle(textSize: $textSize, letterSpacing: $letterSpacing, minLines: $minLines, maxLines: $maxLines, typeface: $typeface, textColor: $textColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NativeTextStyle &&
            (identical(other.textSize, textSize) ||
                const DeepCollectionEquality()
                    .equals(other.textSize, textSize)) &&
            (identical(other.letterSpacing, letterSpacing) ||
                const DeepCollectionEquality()
                    .equals(other.letterSpacing, letterSpacing)) &&
            (identical(other.minLines, minLines) ||
                const DeepCollectionEquality()
                    .equals(other.minLines, minLines)) &&
            (identical(other.maxLines, maxLines) ||
                const DeepCollectionEquality()
                    .equals(other.maxLines, maxLines)) &&
            (identical(other.typeface, typeface) ||
                const DeepCollectionEquality()
                    .equals(other.typeface, typeface)) &&
            (identical(other.textColor, textColor) ||
                const DeepCollectionEquality()
                    .equals(other.textColor, textColor)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(textSize) ^
      const DeepCollectionEquality().hash(letterSpacing) ^
      const DeepCollectionEquality().hash(minLines) ^
      const DeepCollectionEquality().hash(maxLines) ^
      const DeepCollectionEquality().hash(typeface) ^
      const DeepCollectionEquality().hash(textColor);

  @override
  _$NativeTextStyleCopyWith<_NativeTextStyle> get copyWith =>
      __$NativeTextStyleCopyWithImpl<_NativeTextStyle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NativeTextStyleToJson(this);
  }
}

abstract class _NativeTextStyle implements NativeTextStyle {
  const factory _NativeTextStyle(
      {double textSize,
      double letterSpacing,
      int minLines,
      int maxLines,
      NativeTypeface typeface,
      @ColorHexConverter() Color textColor}) = _$_NativeTextStyle;

  factory _NativeTextStyle.fromJson(Map<String, dynamic> json) =
      _$_NativeTextStyle.fromJson;

  @override
  double get textSize;
  @override
  double get letterSpacing;
  @override
  int get minLines;
  @override
  int get maxLines;
  @override
  NativeTypeface get typeface;
  @override
  @ColorHexConverter()
  Color get textColor;
  @override
  _$NativeTextStyleCopyWith<_NativeTextStyle> get copyWith;
}

AdDecoration _$AdDecorationFromJson(Map<String, dynamic> json) {
  return _AdDecoration.fromJson(json);
}

/// @nodoc
class _$AdDecorationTearOff {
  const _$AdDecorationTearOff();

// ignore: unused_element
  _AdDecoration call(
      {@ColorHexConverter() Color backgroundColor,
      @ColorHexConverter() Color borderColor,
      double borderWidth = 0.0,
      @BorderRadiusConverter() BorderRadius borderRadius}) {
    return _AdDecoration(
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
    );
  }

// ignore: unused_element
  AdDecoration fromJson(Map<String, Object> json) {
    return AdDecoration.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $AdDecoration = _$AdDecorationTearOff();

/// @nodoc
mixin _$AdDecoration {
  @ColorHexConverter()
  Color get backgroundColor;
  @ColorHexConverter()
  Color get borderColor;
  double get borderWidth;
  @BorderRadiusConverter()
  BorderRadius get borderRadius;

  Map<String, dynamic> toJson();
  $AdDecorationCopyWith<AdDecoration> get copyWith;
}

/// @nodoc
abstract class $AdDecorationCopyWith<$Res> {
  factory $AdDecorationCopyWith(
          AdDecoration value, $Res Function(AdDecoration) then) =
      _$AdDecorationCopyWithImpl<$Res>;
  $Res call(
      {@ColorHexConverter() Color backgroundColor,
      @ColorHexConverter() Color borderColor,
      double borderWidth,
      @BorderRadiusConverter() BorderRadius borderRadius});
}

/// @nodoc
class _$AdDecorationCopyWithImpl<$Res> implements $AdDecorationCopyWith<$Res> {
  _$AdDecorationCopyWithImpl(this._value, this._then);

  final AdDecoration _value;
  // ignore: unused_field
  final $Res Function(AdDecoration) _then;

  @override
  $Res call({
    Object backgroundColor = freezed,
    Object borderColor = freezed,
    Object borderWidth = freezed,
    Object borderRadius = freezed,
  }) {
    return _then(_value.copyWith(
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor as Color,
      borderColor:
          borderColor == freezed ? _value.borderColor : borderColor as Color,
      borderWidth:
          borderWidth == freezed ? _value.borderWidth : borderWidth as double,
      borderRadius: borderRadius == freezed
          ? _value.borderRadius
          : borderRadius as BorderRadius,
    ));
  }
}

/// @nodoc
abstract class _$AdDecorationCopyWith<$Res>
    implements $AdDecorationCopyWith<$Res> {
  factory _$AdDecorationCopyWith(
          _AdDecoration value, $Res Function(_AdDecoration) then) =
      __$AdDecorationCopyWithImpl<$Res>;
  @override
  $Res call(
      {@ColorHexConverter() Color backgroundColor,
      @ColorHexConverter() Color borderColor,
      double borderWidth,
      @BorderRadiusConverter() BorderRadius borderRadius});
}

/// @nodoc
class __$AdDecorationCopyWithImpl<$Res> extends _$AdDecorationCopyWithImpl<$Res>
    implements _$AdDecorationCopyWith<$Res> {
  __$AdDecorationCopyWithImpl(
      _AdDecoration _value, $Res Function(_AdDecoration) _then)
      : super(_value, (v) => _then(v as _AdDecoration));

  @override
  _AdDecoration get _value => super._value as _AdDecoration;

  @override
  $Res call({
    Object backgroundColor = freezed,
    Object borderColor = freezed,
    Object borderWidth = freezed,
    Object borderRadius = freezed,
  }) {
    return _then(_AdDecoration(
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor as Color,
      borderColor:
          borderColor == freezed ? _value.borderColor : borderColor as Color,
      borderWidth:
          borderWidth == freezed ? _value.borderWidth : borderWidth as double,
      borderRadius: borderRadius == freezed
          ? _value.borderRadius
          : borderRadius as BorderRadius,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_AdDecoration implements _AdDecoration {
  const _$_AdDecoration(
      {@ColorHexConverter() this.backgroundColor,
      @ColorHexConverter() this.borderColor,
      this.borderWidth = 0.0,
      @BorderRadiusConverter() this.borderRadius})
      : assert(borderWidth != null);

  factory _$_AdDecoration.fromJson(Map<String, dynamic> json) =>
      _$_$_AdDecorationFromJson(json);

  @override
  @ColorHexConverter()
  final Color backgroundColor;
  @override
  @ColorHexConverter()
  final Color borderColor;
  @JsonKey(defaultValue: 0.0)
  @override
  final double borderWidth;
  @override
  @BorderRadiusConverter()
  final BorderRadius borderRadius;

  @override
  String toString() {
    return 'AdDecoration(backgroundColor: $backgroundColor, borderColor: $borderColor, borderWidth: $borderWidth, borderRadius: $borderRadius)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AdDecoration &&
            (identical(other.backgroundColor, backgroundColor) ||
                const DeepCollectionEquality()
                    .equals(other.backgroundColor, backgroundColor)) &&
            (identical(other.borderColor, borderColor) ||
                const DeepCollectionEquality()
                    .equals(other.borderColor, borderColor)) &&
            (identical(other.borderWidth, borderWidth) ||
                const DeepCollectionEquality()
                    .equals(other.borderWidth, borderWidth)) &&
            (identical(other.borderRadius, borderRadius) ||
                const DeepCollectionEquality()
                    .equals(other.borderRadius, borderRadius)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(backgroundColor) ^
      const DeepCollectionEquality().hash(borderColor) ^
      const DeepCollectionEquality().hash(borderWidth) ^
      const DeepCollectionEquality().hash(borderRadius);

  @override
  _$AdDecorationCopyWith<_AdDecoration> get copyWith =>
      __$AdDecorationCopyWithImpl<_AdDecoration>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AdDecorationToJson(this);
  }
}

abstract class _AdDecoration implements AdDecoration {
  const factory _AdDecoration(
      {@ColorHexConverter() Color backgroundColor,
      @ColorHexConverter() Color borderColor,
      double borderWidth,
      @BorderRadiusConverter() BorderRadius borderRadius}) = _$_AdDecoration;

  factory _AdDecoration.fromJson(Map<String, dynamic> json) =
      _$_AdDecoration.fromJson;

  @override
  @ColorHexConverter()
  Color get backgroundColor;
  @override
  @ColorHexConverter()
  Color get borderColor;
  @override
  double get borderWidth;
  @override
  @BorderRadiusConverter()
  BorderRadius get borderRadius;
  @override
  _$AdDecorationCopyWith<_AdDecoration> get copyWith;
}

AdView _$AdViewFromJson(Map<String, dynamic> json) {
  switch (json['type'] as String) {
    case 'linearLayout':
      return AdLinearLayout.fromJson(json);
    case 'text':
      return AdTextView.fromJson(json);
    case 'button':
      return AdButtonView.fromJson(json);
    case 'ratingBar':
      return AdRatingBarView.fromJson(json);
    case 'media':
      return AdMediaView.fromJson(json);
    case 'image':
      return AdImageView.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$AdViewTearOff {
  const _$AdViewTearOff();

// ignore: unused_element
  AdLinearLayout linearLayout(
      {@EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width = MATCH_PARENT,
      double height = WRAP_CONTENT,
      LayoutOrientation orientation = LayoutOrientation.vertical,
      LayoutGravity gravity = LayoutGravity.top,
      @required List<AdView> children,
      AdDecoration decoration,
      double flex}) {
    return AdLinearLayout(
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      orientation: orientation,
      gravity: gravity,
      children: children,
      decoration: decoration,
      flex: flex,
    );
  }

// ignore: unused_element
  AdTextView text(
      {@required NativeAdSlot id,
      String text,
      NativeTextStyle style,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width = MATCH_PARENT,
      double height = WRAP_CONTENT,
      AdDecoration decoration}) {
    return AdTextView(
      id: id,
      text: text,
      style: style,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: decoration,
    );
  }

// ignore: unused_element
  AdButtonView button(
      {@required NativeAdSlot id,
      String text,
      NativeTextStyle style,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width = MATCH_PARENT,
      double height = WRAP_CONTENT,
      @ColorHexConverter() Color highlightColor,
      AdDecoration decoration}) {
    return AdButtonView(
      id: id,
      text: text,
      style: style,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      highlightColor: highlightColor,
      decoration: decoration,
    );
  }

// ignore: unused_element
  AdRatingBarView ratingBar(
      {@required NativeAdSlot id,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width = WRAP_CONTENT,
      double height = WRAP_CONTENT,
      AdDecoration decoration,
      double stepSize}) {
    return AdRatingBarView(
      id: id,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: decoration,
      stepSize: stepSize,
    );
  }

// ignore: unused_element
  AdMediaView media(
      {@required NativeAdSlot id,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width = MATCH_PARENT,
      double height = WRAP_CONTENT,
      AdDecoration decoration}) {
    return AdMediaView(
      id: id,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: decoration,
    );
  }

// ignore: unused_element
  AdImageView image(
      {@required NativeAdSlot id,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width = kMinInteractiveDimension,
      double height = kMinInteractiveDimension,
      AdDecoration decoration}) {
    return AdImageView(
      id: id,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: decoration,
    );
  }

// ignore: unused_element
  AdView fromJson(Map<String, Object> json) {
    return AdView.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $AdView = _$AdViewTearOff();

/// @nodoc
mixin _$AdView {
  @EdgeInsetsConverter()
  EdgeInsets get padding;
  @EdgeInsetsConverter()
  EdgeInsets get margin;
  double get width;
  double get height;
  AdDecoration get decoration;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult linearLayout(
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            LayoutOrientation orientation,
            LayoutGravity gravity,
            List<AdView> children,
            AdDecoration decoration,
            double flex),
    @required
        TResult text(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult button(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            @ColorHexConverter() Color highlightColor,
            AdDecoration decoration),
    @required
        TResult ratingBar(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration,
            double stepSize),
    @required
        TResult media(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult image(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult linearLayout(
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        LayoutOrientation orientation,
        LayoutGravity gravity,
        List<AdView> children,
        AdDecoration decoration,
        double flex),
    TResult text(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult button(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        @ColorHexConverter() Color highlightColor,
        AdDecoration decoration),
    TResult ratingBar(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration,
        double stepSize),
    TResult media(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult image(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult linearLayout(AdLinearLayout value),
    @required TResult text(AdTextView value),
    @required TResult button(AdButtonView value),
    @required TResult ratingBar(AdRatingBarView value),
    @required TResult media(AdMediaView value),
    @required TResult image(AdImageView value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult linearLayout(AdLinearLayout value),
    TResult text(AdTextView value),
    TResult button(AdButtonView value),
    TResult ratingBar(AdRatingBarView value),
    TResult media(AdMediaView value),
    TResult image(AdImageView value),
    @required TResult orElse(),
  });
  Map<String, dynamic> toJson();
  $AdViewCopyWith<AdView> get copyWith;
}

/// @nodoc
abstract class $AdViewCopyWith<$Res> {
  factory $AdViewCopyWith(AdView value, $Res Function(AdView) then) =
      _$AdViewCopyWithImpl<$Res>;
  $Res call(
      {@EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      AdDecoration decoration});

  $AdDecorationCopyWith<$Res> get decoration;
}

/// @nodoc
class _$AdViewCopyWithImpl<$Res> implements $AdViewCopyWith<$Res> {
  _$AdViewCopyWithImpl(this._value, this._then);

  final AdView _value;
  // ignore: unused_field
  final $Res Function(AdView) _then;

  @override
  $Res call({
    Object padding = freezed,
    Object margin = freezed,
    Object width = freezed,
    Object height = freezed,
    Object decoration = freezed,
  }) {
    return _then(_value.copyWith(
      padding: padding == freezed ? _value.padding : padding as EdgeInsets,
      margin: margin == freezed ? _value.margin : margin as EdgeInsets,
      width: width == freezed ? _value.width : width as double,
      height: height == freezed ? _value.height : height as double,
      decoration: decoration == freezed
          ? _value.decoration
          : decoration as AdDecoration,
    ));
  }

  @override
  $AdDecorationCopyWith<$Res> get decoration {
    if (_value.decoration == null) {
      return null;
    }
    return $AdDecorationCopyWith<$Res>(_value.decoration, (value) {
      return _then(_value.copyWith(decoration: value));
    });
  }
}

/// @nodoc
abstract class $AdLinearLayoutCopyWith<$Res> implements $AdViewCopyWith<$Res> {
  factory $AdLinearLayoutCopyWith(
          AdLinearLayout value, $Res Function(AdLinearLayout) then) =
      _$AdLinearLayoutCopyWithImpl<$Res>;
  @override
  $Res call(
      {@EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      LayoutOrientation orientation,
      LayoutGravity gravity,
      List<AdView> children,
      AdDecoration decoration,
      double flex});

  @override
  $AdDecorationCopyWith<$Res> get decoration;
}

/// @nodoc
class _$AdLinearLayoutCopyWithImpl<$Res> extends _$AdViewCopyWithImpl<$Res>
    implements $AdLinearLayoutCopyWith<$Res> {
  _$AdLinearLayoutCopyWithImpl(
      AdLinearLayout _value, $Res Function(AdLinearLayout) _then)
      : super(_value, (v) => _then(v as AdLinearLayout));

  @override
  AdLinearLayout get _value => super._value as AdLinearLayout;

  @override
  $Res call({
    Object padding = freezed,
    Object margin = freezed,
    Object width = freezed,
    Object height = freezed,
    Object orientation = freezed,
    Object gravity = freezed,
    Object children = freezed,
    Object decoration = freezed,
    Object flex = freezed,
  }) {
    return _then(AdLinearLayout(
      padding: padding == freezed ? _value.padding : padding as EdgeInsets,
      margin: margin == freezed ? _value.margin : margin as EdgeInsets,
      width: width == freezed ? _value.width : width as double,
      height: height == freezed ? _value.height : height as double,
      orientation: orientation == freezed
          ? _value.orientation
          : orientation as LayoutOrientation,
      gravity: gravity == freezed ? _value.gravity : gravity as LayoutGravity,
      children:
          children == freezed ? _value.children : children as List<AdView>,
      decoration: decoration == freezed
          ? _value.decoration
          : decoration as AdDecoration,
      flex: flex == freezed ? _value.flex : flex as double,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$AdLinearLayout implements AdLinearLayout {
  const _$AdLinearLayout(
      {@EdgeInsetsConverter() this.padding,
      @EdgeInsetsConverter() this.margin,
      this.width = MATCH_PARENT,
      this.height = WRAP_CONTENT,
      this.orientation = LayoutOrientation.vertical,
      this.gravity = LayoutGravity.top,
      @required this.children,
      this.decoration,
      this.flex})
      : assert(width != null),
        assert(height != null),
        assert(orientation != null),
        assert(gravity != null),
        assert(children != null);

  factory _$AdLinearLayout.fromJson(Map<String, dynamic> json) =>
      _$_$AdLinearLayoutFromJson(json);

  @override
  @EdgeInsetsConverter()
  final EdgeInsets padding;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets margin;
  @JsonKey(defaultValue: MATCH_PARENT)
  @override
  final double width;
  @JsonKey(defaultValue: WRAP_CONTENT)
  @override
  final double height;
  @JsonKey(defaultValue: LayoutOrientation.vertical)
  @override
  final LayoutOrientation orientation;
  @JsonKey(defaultValue: LayoutGravity.top)
  @override
  final LayoutGravity gravity;
  @override
  final List<AdView> children;
  @override
  final AdDecoration decoration;
  @override
  final double flex;

  @override
  String toString() {
    return 'AdView.linearLayout(padding: $padding, margin: $margin, width: $width, height: $height, orientation: $orientation, gravity: $gravity, children: $children, decoration: $decoration, flex: $flex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdLinearLayout &&
            (identical(other.padding, padding) ||
                const DeepCollectionEquality()
                    .equals(other.padding, padding)) &&
            (identical(other.margin, margin) ||
                const DeepCollectionEquality().equals(other.margin, margin)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.orientation, orientation) ||
                const DeepCollectionEquality()
                    .equals(other.orientation, orientation)) &&
            (identical(other.gravity, gravity) ||
                const DeepCollectionEquality()
                    .equals(other.gravity, gravity)) &&
            (identical(other.children, children) ||
                const DeepCollectionEquality()
                    .equals(other.children, children)) &&
            (identical(other.decoration, decoration) ||
                const DeepCollectionEquality()
                    .equals(other.decoration, decoration)) &&
            (identical(other.flex, flex) ||
                const DeepCollectionEquality().equals(other.flex, flex)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(padding) ^
      const DeepCollectionEquality().hash(margin) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(orientation) ^
      const DeepCollectionEquality().hash(gravity) ^
      const DeepCollectionEquality().hash(children) ^
      const DeepCollectionEquality().hash(decoration) ^
      const DeepCollectionEquality().hash(flex);

  @override
  $AdLinearLayoutCopyWith<AdLinearLayout> get copyWith =>
      _$AdLinearLayoutCopyWithImpl<AdLinearLayout>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult linearLayout(
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            LayoutOrientation orientation,
            LayoutGravity gravity,
            List<AdView> children,
            AdDecoration decoration,
            double flex),
    @required
        TResult text(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult button(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            @ColorHexConverter() Color highlightColor,
            AdDecoration decoration),
    @required
        TResult ratingBar(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration,
            double stepSize),
    @required
        TResult media(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult image(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return linearLayout(padding, margin, width, height, orientation, gravity,
        children, decoration, flex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult linearLayout(
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        LayoutOrientation orientation,
        LayoutGravity gravity,
        List<AdView> children,
        AdDecoration decoration,
        double flex),
    TResult text(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult button(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        @ColorHexConverter() Color highlightColor,
        AdDecoration decoration),
    TResult ratingBar(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration,
        double stepSize),
    TResult media(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult image(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (linearLayout != null) {
      return linearLayout(padding, margin, width, height, orientation, gravity,
          children, decoration, flex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult linearLayout(AdLinearLayout value),
    @required TResult text(AdTextView value),
    @required TResult button(AdButtonView value),
    @required TResult ratingBar(AdRatingBarView value),
    @required TResult media(AdMediaView value),
    @required TResult image(AdImageView value),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return linearLayout(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult linearLayout(AdLinearLayout value),
    TResult text(AdTextView value),
    TResult button(AdButtonView value),
    TResult ratingBar(AdRatingBarView value),
    TResult media(AdMediaView value),
    TResult image(AdImageView value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (linearLayout != null) {
      return linearLayout(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$AdLinearLayoutToJson(this)..['type'] = 'linearLayout';
  }
}

abstract class AdLinearLayout implements AdView {
  const factory AdLinearLayout(
      {@EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      LayoutOrientation orientation,
      LayoutGravity gravity,
      @required List<AdView> children,
      AdDecoration decoration,
      double flex}) = _$AdLinearLayout;

  factory AdLinearLayout.fromJson(Map<String, dynamic> json) =
      _$AdLinearLayout.fromJson;

  @override
  @EdgeInsetsConverter()
  EdgeInsets get padding;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get margin;
  @override
  double get width;
  @override
  double get height;
  LayoutOrientation get orientation;
  LayoutGravity get gravity;
  List<AdView> get children;
  @override
  AdDecoration get decoration;
  double get flex;
  @override
  $AdLinearLayoutCopyWith<AdLinearLayout> get copyWith;
}

/// @nodoc
abstract class $AdTextViewCopyWith<$Res> implements $AdViewCopyWith<$Res> {
  factory $AdTextViewCopyWith(
          AdTextView value, $Res Function(AdTextView) then) =
      _$AdTextViewCopyWithImpl<$Res>;
  @override
  $Res call(
      {NativeAdSlot id,
      String text,
      NativeTextStyle style,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      AdDecoration decoration});

  $NativeTextStyleCopyWith<$Res> get style;
  @override
  $AdDecorationCopyWith<$Res> get decoration;
}

/// @nodoc
class _$AdTextViewCopyWithImpl<$Res> extends _$AdViewCopyWithImpl<$Res>
    implements $AdTextViewCopyWith<$Res> {
  _$AdTextViewCopyWithImpl(AdTextView _value, $Res Function(AdTextView) _then)
      : super(_value, (v) => _then(v as AdTextView));

  @override
  AdTextView get _value => super._value as AdTextView;

  @override
  $Res call({
    Object id = freezed,
    Object text = freezed,
    Object style = freezed,
    Object padding = freezed,
    Object margin = freezed,
    Object width = freezed,
    Object height = freezed,
    Object decoration = freezed,
  }) {
    return _then(AdTextView(
      id: id == freezed ? _value.id : id as NativeAdSlot,
      text: text == freezed ? _value.text : text as String,
      style: style == freezed ? _value.style : style as NativeTextStyle,
      padding: padding == freezed ? _value.padding : padding as EdgeInsets,
      margin: margin == freezed ? _value.margin : margin as EdgeInsets,
      width: width == freezed ? _value.width : width as double,
      height: height == freezed ? _value.height : height as double,
      decoration: decoration == freezed
          ? _value.decoration
          : decoration as AdDecoration,
    ));
  }

  @override
  $NativeTextStyleCopyWith<$Res> get style {
    if (_value.style == null) {
      return null;
    }
    return $NativeTextStyleCopyWith<$Res>(_value.style, (value) {
      return _then(_value.copyWith(style: value));
    });
  }
}

@JsonSerializable()

/// @nodoc
class _$AdTextView implements AdTextView {
  const _$AdTextView(
      {@required this.id,
      this.text,
      this.style,
      @EdgeInsetsConverter() this.padding,
      @EdgeInsetsConverter() this.margin,
      this.width = MATCH_PARENT,
      this.height = WRAP_CONTENT,
      this.decoration})
      : assert(id != null),
        assert(width != null),
        assert(height != null);

  factory _$AdTextView.fromJson(Map<String, dynamic> json) =>
      _$_$AdTextViewFromJson(json);

  @override
  final NativeAdSlot id;
  @override
  final String text;
  @override
  final NativeTextStyle style;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets padding;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets margin;
  @JsonKey(defaultValue: MATCH_PARENT)
  @override
  final double width;
  @JsonKey(defaultValue: WRAP_CONTENT)
  @override
  final double height;
  @override
  final AdDecoration decoration;

  @override
  String toString() {
    return 'AdView.text(id: $id, text: $text, style: $style, padding: $padding, margin: $margin, width: $width, height: $height, decoration: $decoration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdTextView &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.style, style) ||
                const DeepCollectionEquality().equals(other.style, style)) &&
            (identical(other.padding, padding) ||
                const DeepCollectionEquality()
                    .equals(other.padding, padding)) &&
            (identical(other.margin, margin) ||
                const DeepCollectionEquality().equals(other.margin, margin)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.decoration, decoration) ||
                const DeepCollectionEquality()
                    .equals(other.decoration, decoration)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(style) ^
      const DeepCollectionEquality().hash(padding) ^
      const DeepCollectionEquality().hash(margin) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(decoration);

  @override
  $AdTextViewCopyWith<AdTextView> get copyWith =>
      _$AdTextViewCopyWithImpl<AdTextView>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult linearLayout(
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            LayoutOrientation orientation,
            LayoutGravity gravity,
            List<AdView> children,
            AdDecoration decoration,
            double flex),
    @required
        TResult text(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult button(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            @ColorHexConverter() Color highlightColor,
            AdDecoration decoration),
    @required
        TResult ratingBar(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration,
            double stepSize),
    @required
        TResult media(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult image(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return text(
        id, this.text, style, padding, margin, width, height, decoration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult linearLayout(
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        LayoutOrientation orientation,
        LayoutGravity gravity,
        List<AdView> children,
        AdDecoration decoration,
        double flex),
    TResult text(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult button(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        @ColorHexConverter() Color highlightColor,
        AdDecoration decoration),
    TResult ratingBar(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration,
        double stepSize),
    TResult media(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult image(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (text != null) {
      return text(
          id, this.text, style, padding, margin, width, height, decoration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult linearLayout(AdLinearLayout value),
    @required TResult text(AdTextView value),
    @required TResult button(AdButtonView value),
    @required TResult ratingBar(AdRatingBarView value),
    @required TResult media(AdMediaView value),
    @required TResult image(AdImageView value),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult linearLayout(AdLinearLayout value),
    TResult text(AdTextView value),
    TResult button(AdButtonView value),
    TResult ratingBar(AdRatingBarView value),
    TResult media(AdMediaView value),
    TResult image(AdImageView value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$AdTextViewToJson(this)..['type'] = 'text';
  }
}

abstract class AdTextView implements AdView {
  const factory AdTextView(
      {@required NativeAdSlot id,
      String text,
      NativeTextStyle style,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      AdDecoration decoration}) = _$AdTextView;

  factory AdTextView.fromJson(Map<String, dynamic> json) =
      _$AdTextView.fromJson;

  NativeAdSlot get id;
  String get text;
  NativeTextStyle get style;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get padding;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get margin;
  @override
  double get width;
  @override
  double get height;
  @override
  AdDecoration get decoration;
  @override
  $AdTextViewCopyWith<AdTextView> get copyWith;
}

/// @nodoc
abstract class $AdButtonViewCopyWith<$Res> implements $AdViewCopyWith<$Res> {
  factory $AdButtonViewCopyWith(
          AdButtonView value, $Res Function(AdButtonView) then) =
      _$AdButtonViewCopyWithImpl<$Res>;
  @override
  $Res call(
      {NativeAdSlot id,
      String text,
      NativeTextStyle style,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      @ColorHexConverter() Color highlightColor,
      AdDecoration decoration});

  $NativeTextStyleCopyWith<$Res> get style;
  @override
  $AdDecorationCopyWith<$Res> get decoration;
}

/// @nodoc
class _$AdButtonViewCopyWithImpl<$Res> extends _$AdViewCopyWithImpl<$Res>
    implements $AdButtonViewCopyWith<$Res> {
  _$AdButtonViewCopyWithImpl(
      AdButtonView _value, $Res Function(AdButtonView) _then)
      : super(_value, (v) => _then(v as AdButtonView));

  @override
  AdButtonView get _value => super._value as AdButtonView;

  @override
  $Res call({
    Object id = freezed,
    Object text = freezed,
    Object style = freezed,
    Object padding = freezed,
    Object margin = freezed,
    Object width = freezed,
    Object height = freezed,
    Object highlightColor = freezed,
    Object decoration = freezed,
  }) {
    return _then(AdButtonView(
      id: id == freezed ? _value.id : id as NativeAdSlot,
      text: text == freezed ? _value.text : text as String,
      style: style == freezed ? _value.style : style as NativeTextStyle,
      padding: padding == freezed ? _value.padding : padding as EdgeInsets,
      margin: margin == freezed ? _value.margin : margin as EdgeInsets,
      width: width == freezed ? _value.width : width as double,
      height: height == freezed ? _value.height : height as double,
      highlightColor: highlightColor == freezed
          ? _value.highlightColor
          : highlightColor as Color,
      decoration: decoration == freezed
          ? _value.decoration
          : decoration as AdDecoration,
    ));
  }

  @override
  $NativeTextStyleCopyWith<$Res> get style {
    if (_value.style == null) {
      return null;
    }
    return $NativeTextStyleCopyWith<$Res>(_value.style, (value) {
      return _then(_value.copyWith(style: value));
    });
  }
}

@JsonSerializable()

/// @nodoc
class _$AdButtonView implements AdButtonView {
  const _$AdButtonView(
      {@required this.id,
      this.text,
      this.style,
      @EdgeInsetsConverter() this.padding,
      @EdgeInsetsConverter() this.margin,
      this.width = MATCH_PARENT,
      this.height = WRAP_CONTENT,
      @ColorHexConverter() this.highlightColor,
      this.decoration})
      : assert(id != null),
        assert(width != null),
        assert(height != null);

  factory _$AdButtonView.fromJson(Map<String, dynamic> json) =>
      _$_$AdButtonViewFromJson(json);

  @override
  final NativeAdSlot id;
  @override
  final String text;
  @override
  final NativeTextStyle style;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets padding;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets margin;
  @JsonKey(defaultValue: MATCH_PARENT)
  @override
  final double width;
  @JsonKey(defaultValue: WRAP_CONTENT)
  @override
  final double height;
  @override
  @ColorHexConverter()
  final Color highlightColor;
  @override
  final AdDecoration decoration;

  @override
  String toString() {
    return 'AdView.button(id: $id, text: $text, style: $style, padding: $padding, margin: $margin, width: $width, height: $height, highlightColor: $highlightColor, decoration: $decoration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdButtonView &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.style, style) ||
                const DeepCollectionEquality().equals(other.style, style)) &&
            (identical(other.padding, padding) ||
                const DeepCollectionEquality()
                    .equals(other.padding, padding)) &&
            (identical(other.margin, margin) ||
                const DeepCollectionEquality().equals(other.margin, margin)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.highlightColor, highlightColor) ||
                const DeepCollectionEquality()
                    .equals(other.highlightColor, highlightColor)) &&
            (identical(other.decoration, decoration) ||
                const DeepCollectionEquality()
                    .equals(other.decoration, decoration)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(style) ^
      const DeepCollectionEquality().hash(padding) ^
      const DeepCollectionEquality().hash(margin) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(highlightColor) ^
      const DeepCollectionEquality().hash(decoration);

  @override
  $AdButtonViewCopyWith<AdButtonView> get copyWith =>
      _$AdButtonViewCopyWithImpl<AdButtonView>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult linearLayout(
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            LayoutOrientation orientation,
            LayoutGravity gravity,
            List<AdView> children,
            AdDecoration decoration,
            double flex),
    @required
        TResult text(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult button(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            @ColorHexConverter() Color highlightColor,
            AdDecoration decoration),
    @required
        TResult ratingBar(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration,
            double stepSize),
    @required
        TResult media(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult image(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return button(id, this.text, style, padding, margin, width, height,
        highlightColor, decoration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult linearLayout(
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        LayoutOrientation orientation,
        LayoutGravity gravity,
        List<AdView> children,
        AdDecoration decoration,
        double flex),
    TResult text(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult button(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        @ColorHexConverter() Color highlightColor,
        AdDecoration decoration),
    TResult ratingBar(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration,
        double stepSize),
    TResult media(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult image(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (button != null) {
      return button(id, this.text, style, padding, margin, width, height,
          highlightColor, decoration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult linearLayout(AdLinearLayout value),
    @required TResult text(AdTextView value),
    @required TResult button(AdButtonView value),
    @required TResult ratingBar(AdRatingBarView value),
    @required TResult media(AdMediaView value),
    @required TResult image(AdImageView value),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return button(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult linearLayout(AdLinearLayout value),
    TResult text(AdTextView value),
    TResult button(AdButtonView value),
    TResult ratingBar(AdRatingBarView value),
    TResult media(AdMediaView value),
    TResult image(AdImageView value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (button != null) {
      return button(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$AdButtonViewToJson(this)..['type'] = 'button';
  }
}

abstract class AdButtonView implements AdView {
  const factory AdButtonView(
      {@required NativeAdSlot id,
      String text,
      NativeTextStyle style,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      @ColorHexConverter() Color highlightColor,
      AdDecoration decoration}) = _$AdButtonView;

  factory AdButtonView.fromJson(Map<String, dynamic> json) =
      _$AdButtonView.fromJson;

  NativeAdSlot get id;
  String get text;
  NativeTextStyle get style;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get padding;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get margin;
  @override
  double get width;
  @override
  double get height;
  @ColorHexConverter()
  Color get highlightColor;
  @override
  AdDecoration get decoration;
  @override
  $AdButtonViewCopyWith<AdButtonView> get copyWith;
}

/// @nodoc
abstract class $AdRatingBarViewCopyWith<$Res> implements $AdViewCopyWith<$Res> {
  factory $AdRatingBarViewCopyWith(
          AdRatingBarView value, $Res Function(AdRatingBarView) then) =
      _$AdRatingBarViewCopyWithImpl<$Res>;
  @override
  $Res call(
      {NativeAdSlot id,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      AdDecoration decoration,
      double stepSize});

  @override
  $AdDecorationCopyWith<$Res> get decoration;
}

/// @nodoc
class _$AdRatingBarViewCopyWithImpl<$Res> extends _$AdViewCopyWithImpl<$Res>
    implements $AdRatingBarViewCopyWith<$Res> {
  _$AdRatingBarViewCopyWithImpl(
      AdRatingBarView _value, $Res Function(AdRatingBarView) _then)
      : super(_value, (v) => _then(v as AdRatingBarView));

  @override
  AdRatingBarView get _value => super._value as AdRatingBarView;

  @override
  $Res call({
    Object id = freezed,
    Object padding = freezed,
    Object margin = freezed,
    Object width = freezed,
    Object height = freezed,
    Object decoration = freezed,
    Object stepSize = freezed,
  }) {
    return _then(AdRatingBarView(
      id: id == freezed ? _value.id : id as NativeAdSlot,
      padding: padding == freezed ? _value.padding : padding as EdgeInsets,
      margin: margin == freezed ? _value.margin : margin as EdgeInsets,
      width: width == freezed ? _value.width : width as double,
      height: height == freezed ? _value.height : height as double,
      decoration: decoration == freezed
          ? _value.decoration
          : decoration as AdDecoration,
      stepSize: stepSize == freezed ? _value.stepSize : stepSize as double,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$AdRatingBarView implements AdRatingBarView {
  const _$AdRatingBarView(
      {@required this.id,
      @EdgeInsetsConverter() this.padding,
      @EdgeInsetsConverter() this.margin,
      this.width = WRAP_CONTENT,
      this.height = WRAP_CONTENT,
      this.decoration,
      this.stepSize})
      : assert(id != null),
        assert(width != null),
        assert(height != null);

  factory _$AdRatingBarView.fromJson(Map<String, dynamic> json) =>
      _$_$AdRatingBarViewFromJson(json);

  @override
  final NativeAdSlot id;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets padding;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets margin;
  @JsonKey(defaultValue: WRAP_CONTENT)
  @override
  final double width;
  @JsonKey(defaultValue: WRAP_CONTENT)
  @override
  final double height;
  @override
  final AdDecoration decoration;
  @override
  final double stepSize;

  @override
  String toString() {
    return 'AdView.ratingBar(id: $id, padding: $padding, margin: $margin, width: $width, height: $height, decoration: $decoration, stepSize: $stepSize)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdRatingBarView &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.padding, padding) ||
                const DeepCollectionEquality()
                    .equals(other.padding, padding)) &&
            (identical(other.margin, margin) ||
                const DeepCollectionEquality().equals(other.margin, margin)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.decoration, decoration) ||
                const DeepCollectionEquality()
                    .equals(other.decoration, decoration)) &&
            (identical(other.stepSize, stepSize) ||
                const DeepCollectionEquality()
                    .equals(other.stepSize, stepSize)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(padding) ^
      const DeepCollectionEquality().hash(margin) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(decoration) ^
      const DeepCollectionEquality().hash(stepSize);

  @override
  $AdRatingBarViewCopyWith<AdRatingBarView> get copyWith =>
      _$AdRatingBarViewCopyWithImpl<AdRatingBarView>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult linearLayout(
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            LayoutOrientation orientation,
            LayoutGravity gravity,
            List<AdView> children,
            AdDecoration decoration,
            double flex),
    @required
        TResult text(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult button(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            @ColorHexConverter() Color highlightColor,
            AdDecoration decoration),
    @required
        TResult ratingBar(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration,
            double stepSize),
    @required
        TResult media(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult image(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return ratingBar(id, padding, margin, width, height, decoration, stepSize);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult linearLayout(
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        LayoutOrientation orientation,
        LayoutGravity gravity,
        List<AdView> children,
        AdDecoration decoration,
        double flex),
    TResult text(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult button(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        @ColorHexConverter() Color highlightColor,
        AdDecoration decoration),
    TResult ratingBar(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration,
        double stepSize),
    TResult media(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult image(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (ratingBar != null) {
      return ratingBar(
          id, padding, margin, width, height, decoration, stepSize);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult linearLayout(AdLinearLayout value),
    @required TResult text(AdTextView value),
    @required TResult button(AdButtonView value),
    @required TResult ratingBar(AdRatingBarView value),
    @required TResult media(AdMediaView value),
    @required TResult image(AdImageView value),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return ratingBar(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult linearLayout(AdLinearLayout value),
    TResult text(AdTextView value),
    TResult button(AdButtonView value),
    TResult ratingBar(AdRatingBarView value),
    TResult media(AdMediaView value),
    TResult image(AdImageView value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (ratingBar != null) {
      return ratingBar(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$AdRatingBarViewToJson(this)..['type'] = 'ratingBar';
  }
}

abstract class AdRatingBarView implements AdView {
  const factory AdRatingBarView(
      {@required NativeAdSlot id,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      AdDecoration decoration,
      double stepSize}) = _$AdRatingBarView;

  factory AdRatingBarView.fromJson(Map<String, dynamic> json) =
      _$AdRatingBarView.fromJson;

  NativeAdSlot get id;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get padding;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get margin;
  @override
  double get width;
  @override
  double get height;
  @override
  AdDecoration get decoration;
  double get stepSize;
  @override
  $AdRatingBarViewCopyWith<AdRatingBarView> get copyWith;
}

/// @nodoc
abstract class $AdMediaViewCopyWith<$Res> implements $AdViewCopyWith<$Res> {
  factory $AdMediaViewCopyWith(
          AdMediaView value, $Res Function(AdMediaView) then) =
      _$AdMediaViewCopyWithImpl<$Res>;
  @override
  $Res call(
      {NativeAdSlot id,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      AdDecoration decoration});

  @override
  $AdDecorationCopyWith<$Res> get decoration;
}

/// @nodoc
class _$AdMediaViewCopyWithImpl<$Res> extends _$AdViewCopyWithImpl<$Res>
    implements $AdMediaViewCopyWith<$Res> {
  _$AdMediaViewCopyWithImpl(
      AdMediaView _value, $Res Function(AdMediaView) _then)
      : super(_value, (v) => _then(v as AdMediaView));

  @override
  AdMediaView get _value => super._value as AdMediaView;

  @override
  $Res call({
    Object id = freezed,
    Object padding = freezed,
    Object margin = freezed,
    Object width = freezed,
    Object height = freezed,
    Object decoration = freezed,
  }) {
    return _then(AdMediaView(
      id: id == freezed ? _value.id : id as NativeAdSlot,
      padding: padding == freezed ? _value.padding : padding as EdgeInsets,
      margin: margin == freezed ? _value.margin : margin as EdgeInsets,
      width: width == freezed ? _value.width : width as double,
      height: height == freezed ? _value.height : height as double,
      decoration: decoration == freezed
          ? _value.decoration
          : decoration as AdDecoration,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$AdMediaView implements AdMediaView {
  const _$AdMediaView(
      {@required this.id,
      @EdgeInsetsConverter() this.padding,
      @EdgeInsetsConverter() this.margin,
      this.width = MATCH_PARENT,
      this.height = WRAP_CONTENT,
      this.decoration})
      : assert(id != null),
        assert(width != null),
        assert(height != null);

  factory _$AdMediaView.fromJson(Map<String, dynamic> json) =>
      _$_$AdMediaViewFromJson(json);

  @override
  final NativeAdSlot id;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets padding;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets margin;
  @JsonKey(defaultValue: MATCH_PARENT)
  @override
  final double width;
  @JsonKey(defaultValue: WRAP_CONTENT)
  @override
  final double height;
  @override
  final AdDecoration decoration;

  @override
  String toString() {
    return 'AdView.media(id: $id, padding: $padding, margin: $margin, width: $width, height: $height, decoration: $decoration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdMediaView &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.padding, padding) ||
                const DeepCollectionEquality()
                    .equals(other.padding, padding)) &&
            (identical(other.margin, margin) ||
                const DeepCollectionEquality().equals(other.margin, margin)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.decoration, decoration) ||
                const DeepCollectionEquality()
                    .equals(other.decoration, decoration)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(padding) ^
      const DeepCollectionEquality().hash(margin) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(decoration);

  @override
  $AdMediaViewCopyWith<AdMediaView> get copyWith =>
      _$AdMediaViewCopyWithImpl<AdMediaView>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult linearLayout(
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            LayoutOrientation orientation,
            LayoutGravity gravity,
            List<AdView> children,
            AdDecoration decoration,
            double flex),
    @required
        TResult text(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult button(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            @ColorHexConverter() Color highlightColor,
            AdDecoration decoration),
    @required
        TResult ratingBar(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration,
            double stepSize),
    @required
        TResult media(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult image(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return media(id, padding, margin, width, height, decoration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult linearLayout(
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        LayoutOrientation orientation,
        LayoutGravity gravity,
        List<AdView> children,
        AdDecoration decoration,
        double flex),
    TResult text(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult button(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        @ColorHexConverter() Color highlightColor,
        AdDecoration decoration),
    TResult ratingBar(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration,
        double stepSize),
    TResult media(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult image(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (media != null) {
      return media(id, padding, margin, width, height, decoration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult linearLayout(AdLinearLayout value),
    @required TResult text(AdTextView value),
    @required TResult button(AdButtonView value),
    @required TResult ratingBar(AdRatingBarView value),
    @required TResult media(AdMediaView value),
    @required TResult image(AdImageView value),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return media(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult linearLayout(AdLinearLayout value),
    TResult text(AdTextView value),
    TResult button(AdButtonView value),
    TResult ratingBar(AdRatingBarView value),
    TResult media(AdMediaView value),
    TResult image(AdImageView value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (media != null) {
      return media(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$AdMediaViewToJson(this)..['type'] = 'media';
  }
}

abstract class AdMediaView implements AdView {
  const factory AdMediaView(
      {@required NativeAdSlot id,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      AdDecoration decoration}) = _$AdMediaView;

  factory AdMediaView.fromJson(Map<String, dynamic> json) =
      _$AdMediaView.fromJson;

  NativeAdSlot get id;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get padding;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get margin;
  @override
  double get width;
  @override
  double get height;
  @override
  AdDecoration get decoration;
  @override
  $AdMediaViewCopyWith<AdMediaView> get copyWith;
}

/// @nodoc
abstract class $AdImageViewCopyWith<$Res> implements $AdViewCopyWith<$Res> {
  factory $AdImageViewCopyWith(
          AdImageView value, $Res Function(AdImageView) then) =
      _$AdImageViewCopyWithImpl<$Res>;
  @override
  $Res call(
      {NativeAdSlot id,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      AdDecoration decoration});

  @override
  $AdDecorationCopyWith<$Res> get decoration;
}

/// @nodoc
class _$AdImageViewCopyWithImpl<$Res> extends _$AdViewCopyWithImpl<$Res>
    implements $AdImageViewCopyWith<$Res> {
  _$AdImageViewCopyWithImpl(
      AdImageView _value, $Res Function(AdImageView) _then)
      : super(_value, (v) => _then(v as AdImageView));

  @override
  AdImageView get _value => super._value as AdImageView;

  @override
  $Res call({
    Object id = freezed,
    Object padding = freezed,
    Object margin = freezed,
    Object width = freezed,
    Object height = freezed,
    Object decoration = freezed,
  }) {
    return _then(AdImageView(
      id: id == freezed ? _value.id : id as NativeAdSlot,
      padding: padding == freezed ? _value.padding : padding as EdgeInsets,
      margin: margin == freezed ? _value.margin : margin as EdgeInsets,
      width: width == freezed ? _value.width : width as double,
      height: height == freezed ? _value.height : height as double,
      decoration: decoration == freezed
          ? _value.decoration
          : decoration as AdDecoration,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$AdImageView implements AdImageView {
  const _$AdImageView(
      {@required this.id,
      @EdgeInsetsConverter() this.padding,
      @EdgeInsetsConverter() this.margin,
      this.width = kMinInteractiveDimension,
      this.height = kMinInteractiveDimension,
      this.decoration})
      : assert(id != null),
        assert(width != null),
        assert(height != null);

  factory _$AdImageView.fromJson(Map<String, dynamic> json) =>
      _$_$AdImageViewFromJson(json);

  @override
  final NativeAdSlot id;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets padding;
  @override
  @EdgeInsetsConverter()
  final EdgeInsets margin;
  @JsonKey(defaultValue: kMinInteractiveDimension)
  @override
  final double width;
  @JsonKey(defaultValue: kMinInteractiveDimension)
  @override
  final double height;
  @override
  final AdDecoration decoration;

  @override
  String toString() {
    return 'AdView.image(id: $id, padding: $padding, margin: $margin, width: $width, height: $height, decoration: $decoration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AdImageView &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.padding, padding) ||
                const DeepCollectionEquality()
                    .equals(other.padding, padding)) &&
            (identical(other.margin, margin) ||
                const DeepCollectionEquality().equals(other.margin, margin)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.decoration, decoration) ||
                const DeepCollectionEquality()
                    .equals(other.decoration, decoration)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(padding) ^
      const DeepCollectionEquality().hash(margin) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(decoration);

  @override
  $AdImageViewCopyWith<AdImageView> get copyWith =>
      _$AdImageViewCopyWithImpl<AdImageView>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult linearLayout(
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            LayoutOrientation orientation,
            LayoutGravity gravity,
            List<AdView> children,
            AdDecoration decoration,
            double flex),
    @required
        TResult text(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult button(
            NativeAdSlot id,
            String text,
            NativeTextStyle style,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            @ColorHexConverter() Color highlightColor,
            AdDecoration decoration),
    @required
        TResult ratingBar(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration,
            double stepSize),
    @required
        TResult media(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
    @required
        TResult image(
            NativeAdSlot id,
            @EdgeInsetsConverter() EdgeInsets padding,
            @EdgeInsetsConverter() EdgeInsets margin,
            double width,
            double height,
            AdDecoration decoration),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return image(id, padding, margin, width, height, decoration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult linearLayout(
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        LayoutOrientation orientation,
        LayoutGravity gravity,
        List<AdView> children,
        AdDecoration decoration,
        double flex),
    TResult text(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult button(
        NativeAdSlot id,
        String text,
        NativeTextStyle style,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        @ColorHexConverter() Color highlightColor,
        AdDecoration decoration),
    TResult ratingBar(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration,
        double stepSize),
    TResult media(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    TResult image(
        NativeAdSlot id,
        @EdgeInsetsConverter() EdgeInsets padding,
        @EdgeInsetsConverter() EdgeInsets margin,
        double width,
        double height,
        AdDecoration decoration),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (image != null) {
      return image(id, padding, margin, width, height, decoration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult linearLayout(AdLinearLayout value),
    @required TResult text(AdTextView value),
    @required TResult button(AdButtonView value),
    @required TResult ratingBar(AdRatingBarView value),
    @required TResult media(AdMediaView value),
    @required TResult image(AdImageView value),
  }) {
    assert(linearLayout != null);
    assert(text != null);
    assert(button != null);
    assert(ratingBar != null);
    assert(media != null);
    assert(image != null);
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult linearLayout(AdLinearLayout value),
    TResult text(AdTextView value),
    TResult button(AdButtonView value),
    TResult ratingBar(AdRatingBarView value),
    TResult media(AdMediaView value),
    TResult image(AdImageView value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$AdImageViewToJson(this)..['type'] = 'image';
  }
}

abstract class AdImageView implements AdView {
  const factory AdImageView(
      {@required NativeAdSlot id,
      @EdgeInsetsConverter() EdgeInsets padding,
      @EdgeInsetsConverter() EdgeInsets margin,
      double width,
      double height,
      AdDecoration decoration}) = _$AdImageView;

  factory AdImageView.fromJson(Map<String, dynamic> json) =
      _$AdImageView.fromJson;

  NativeAdSlot get id;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get padding;
  @override
  @EdgeInsetsConverter()
  EdgeInsets get margin;
  @override
  double get width;
  @override
  double get height;
  @override
  AdDecoration get decoration;
  @override
  $AdImageViewCopyWith<AdImageView> get copyWith;
}
