import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admob/src/helpers/converters.dart';

part 'layout_builder.freezed.dart';
part 'layout_builder.g.dart';

/// Expands the view to fit the parent size. Same as `double.infinity`.
const double MATCH_PARENT = -1;

/// Wrap the content to fit its own size.
const double WRAP_CONTENT = -2;

enum LayoutOrientation {
  @JsonValue(0)
  horizontal,
  @JsonValue(1)
  vertical,
}

enum LayoutGravity {
  @JsonValue(17)
  center,
  @JsonValue(1)
  centerHorizontal,
  @JsonValue(16)
  centerVertical,
  @JsonValue(3)
  left,
  @JsonValue(5)
  right,
  @JsonValue(48)
  top,
  @JsonValue(80)
  bottom
}

enum NativeAdSlot {
  @JsonValue('advertiser')
  advertiser,
  @JsonValue('attribution')
  attribution,
  @JsonValue('body')
  body,
  @JsonValue('button')
  button,
  @JsonValue('headline')
  headline,
  @JsonValue('icon')
  icon,
  @JsonValue('media')
  media,
  @JsonValue('price')
  price,
  @JsonValue('rating')
  rating,
  @JsonValue('store')
  store,
}

enum NativeTypeface {
  @JsonValue('regular')
  regular,
  @JsonValue('medium')
  medium,
  @JsonValue('bold')
  bold,
}

@freezed
abstract class NativeTextStyle with _$NativeTextStyle {
  const factory NativeTextStyle({
    @Default(16.0) double textSize,
    @Default(1.0) double letterSpacing,
    @Default(1) int minLines,
    int maxLines,
    NativeTypeface typeface,
    @ColorHexConverter() Color textColor,
  }) = _NativeTextStyle;

  factory NativeTextStyle.fromJson(Map<String, dynamic> json) => _$NativeTextStyleFromJson(json);

  static const textStyle = NativeTextStyle(textSize: 16.0, letterSpacing: 0.15);
  static const buttonStyle = NativeTextStyle(textSize: 14.0, letterSpacing: 1.5, typeface: NativeTypeface.medium);

  static NativeTypeface _getTypefaceFromWeight(FontWeight weight) {
    if (weight.index >= FontWeight.w600.index) {
      return NativeTypeface.bold;
    } else if (weight.index == FontWeight.w500.index) {
      return NativeTypeface.medium;
    } else {
      return NativeTypeface.regular;
    }
  }

  static NativeTextStyle fromFlutter(TextStyle style, {int minLines = 1, int maxLines}) => NativeTextStyle(
        textSize: style.fontSize,
        letterSpacing: style.letterSpacing,
        textColor: style.color,
        typeface: _getTypefaceFromWeight(style.fontWeight),
        minLines: minLines,
        maxLines: maxLines,
      );
}

@freezed
abstract class AdDecoration with _$AdDecoration {
  const factory AdDecoration({
    @ColorHexConverter() Color backgroundColor,
    @ColorHexConverter() Color borderColor,
    @Default(0.0) double borderWidth,
    @BorderRadiusConverter() BorderRadius borderRadius,
  }) = _AdDecoration;

  factory AdDecoration.fromJson(Map<String, dynamic> json) => _$AdDecorationFromJson(json);
}

@Freezed(unionKey: 'type')
abstract class AdView with _$AdView {
  const factory AdView.linearLayout({
    @EdgeInsetsConverter() EdgeInsets padding,
    @EdgeInsetsConverter() EdgeInsets margin,
    @Default(MATCH_PARENT) double width,
    @Default(WRAP_CONTENT) double height,
    @Default(LayoutOrientation.vertical) LayoutOrientation orientation,
    @Default(LayoutGravity.top) LayoutGravity gravity,
    @required List<AdView> children,
    AdDecoration decoration,
    double flex,
  }) = AdLinearLayout;

  const factory AdView.text({
    @required NativeAdSlot id,
    String text,
    NativeTextStyle style,
    @EdgeInsetsConverter() EdgeInsets padding,
    @EdgeInsetsConverter() EdgeInsets margin,
    @Default(MATCH_PARENT) double width,
    @Default(WRAP_CONTENT) double height,
    AdDecoration decoration,
  }) = AdTextView;

  const factory AdView.button({
    @required NativeAdSlot id,
    String text,
    NativeTextStyle style,
    @EdgeInsetsConverter() EdgeInsets padding,
    @EdgeInsetsConverter() EdgeInsets margin,
    @Default(MATCH_PARENT) double width,
    @Default(WRAP_CONTENT) double height,
    @ColorHexConverter() Color highlightColor,
    AdDecoration decoration,
  }) = AdButtonView;

  const factory AdView.ratingBar({
    @required NativeAdSlot id,
    @EdgeInsetsConverter() EdgeInsets padding,
    @EdgeInsetsConverter() EdgeInsets margin,
    @Default(WRAP_CONTENT) double width,
    @Default(WRAP_CONTENT) double height,
    AdDecoration decoration,
    double stepSize,
  }) = AdRatingBarView;

  const factory AdView.media({
    @required NativeAdSlot id,
    @EdgeInsetsConverter() EdgeInsets padding,
    @EdgeInsetsConverter() EdgeInsets margin,
    @Default(MATCH_PARENT) double width,
    @Default(WRAP_CONTENT) double height,
    AdDecoration decoration,
  }) = AdMediaView;

  const factory AdView.image({
    @required NativeAdSlot id,
    @EdgeInsetsConverter() EdgeInsets padding,
    @EdgeInsetsConverter() EdgeInsets margin,
    @Default(kMinInteractiveDimension) double width,
    @Default(kMinInteractiveDimension) double height,
    AdDecoration decoration,
  }) = AdImageView;

  factory AdView.fromJson(Map<String, dynamic> json) => _$AdViewFromJson(json);
}
