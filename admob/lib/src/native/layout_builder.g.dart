// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_builder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NativeTextStyle _$_$_NativeTextStyleFromJson(Map json) {
  return _$_NativeTextStyle(
    textSize: (json['textSize'] as num)?.toDouble() ?? 16.0,
    letterSpacing: (json['letterSpacing'] as num)?.toDouble() ?? 1.0,
    minLines: json['minLines'] as int ?? 1,
    maxLines: json['maxLines'] as int,
    typeface: _$enumDecodeNullable(_$NativeTypefaceEnumMap, json['typeface']),
    textColor: const ColorHexConverter().fromJson(json['textColor'] as String),
  );
}

Map<String, dynamic> _$_$_NativeTextStyleToJson(_$_NativeTextStyle instance) =>
    <String, dynamic>{
      'textSize': instance.textSize,
      'letterSpacing': instance.letterSpacing,
      'minLines': instance.minLines,
      'maxLines': instance.maxLines,
      'typeface': _$NativeTypefaceEnumMap[instance.typeface],
      'textColor': const ColorHexConverter().toJson(instance.textColor),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$NativeTypefaceEnumMap = {
  NativeTypeface.regular: 'regular',
  NativeTypeface.medium: 'medium',
  NativeTypeface.bold: 'bold',
};

_$_AdDecoration _$_$_AdDecorationFromJson(Map json) {
  return _$_AdDecoration(
    backgroundColor:
        const ColorHexConverter().fromJson(json['backgroundColor'] as String),
    borderColor:
        const ColorHexConverter().fromJson(json['borderColor'] as String),
    borderWidth: (json['borderWidth'] as num)?.toDouble() ?? 0.0,
    borderRadius:
        const BorderRadiusConverter().fromJson(json['borderRadius'] as Map),
  );
}

Map<String, dynamic> _$_$_AdDecorationToJson(_$_AdDecoration instance) =>
    <String, dynamic>{
      'backgroundColor':
          const ColorHexConverter().toJson(instance.backgroundColor),
      'borderColor': const ColorHexConverter().toJson(instance.borderColor),
      'borderWidth': instance.borderWidth,
      'borderRadius':
          const BorderRadiusConverter().toJson(instance.borderRadius),
    };

_$AdLinearLayout _$_$AdLinearLayoutFromJson(Map json) {
  return _$AdLinearLayout(
    padding: const EdgeInsetsConverter().fromJson(json['padding'] as Map),
    margin: const EdgeInsetsConverter().fromJson(json['margin'] as Map),
    width: (json['width'] as num)?.toDouble() ?? -1.0,
    height: (json['height'] as num)?.toDouble() ?? -2.0,
    orientation:
        _$enumDecodeNullable(_$LayoutOrientationEnumMap, json['orientation']) ??
            LayoutOrientation.vertical,
    gravity: _$enumDecodeNullable(_$LayoutGravityEnumMap, json['gravity']) ??
        LayoutGravity.top,
    children: (json['children'] as List)
        ?.map((e) => e == null
            ? null
            : AdView.fromJson((e as Map)?.map(
                (k, e) => MapEntry(k as String, e),
              )))
        ?.toList(),
    decoration: json['decoration'] == null
        ? null
        : AdDecoration.fromJson((json['decoration'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    flex: (json['flex'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$AdLinearLayoutToJson(_$AdLinearLayout instance) =>
    <String, dynamic>{
      'padding': const EdgeInsetsConverter().toJson(instance.padding),
      'margin': const EdgeInsetsConverter().toJson(instance.margin),
      'width': instance.width,
      'height': instance.height,
      'orientation': _$LayoutOrientationEnumMap[instance.orientation],
      'gravity': _$LayoutGravityEnumMap[instance.gravity],
      'children': instance.children?.map((e) => e?.toJson())?.toList(),
      'decoration': instance.decoration?.toJson(),
      'flex': instance.flex,
    };

const _$LayoutOrientationEnumMap = {
  LayoutOrientation.horizontal: 0,
  LayoutOrientation.vertical: 1,
};

const _$LayoutGravityEnumMap = {
  LayoutGravity.center: 17,
  LayoutGravity.centerHorizontal: 1,
  LayoutGravity.centerVertical: 16,
  LayoutGravity.left: 3,
  LayoutGravity.right: 5,
  LayoutGravity.top: 48,
  LayoutGravity.bottom: 80,
};

_$AdTextView _$_$AdTextViewFromJson(Map json) {
  return _$AdTextView(
    id: _$enumDecodeNullable(_$NativeAdSlotEnumMap, json['id']),
    text: json['text'] as String,
    style: json['style'] == null
        ? null
        : NativeTextStyle.fromJson((json['style'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    padding: const EdgeInsetsConverter().fromJson(json['padding'] as Map),
    margin: const EdgeInsetsConverter().fromJson(json['margin'] as Map),
    width: (json['width'] as num)?.toDouble() ?? -1.0,
    height: (json['height'] as num)?.toDouble() ?? -2.0,
    decoration: json['decoration'] == null
        ? null
        : AdDecoration.fromJson((json['decoration'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$_$AdTextViewToJson(_$AdTextView instance) =>
    <String, dynamic>{
      'id': _$NativeAdSlotEnumMap[instance.id],
      'text': instance.text,
      'style': instance.style?.toJson(),
      'padding': const EdgeInsetsConverter().toJson(instance.padding),
      'margin': const EdgeInsetsConverter().toJson(instance.margin),
      'width': instance.width,
      'height': instance.height,
      'decoration': instance.decoration?.toJson(),
    };

const _$NativeAdSlotEnumMap = {
  NativeAdSlot.advertiser: 'advertiser',
  NativeAdSlot.attribution: 'attribution',
  NativeAdSlot.body: 'body',
  NativeAdSlot.button: 'button',
  NativeAdSlot.headline: 'headline',
  NativeAdSlot.icon: 'icon',
  NativeAdSlot.media: 'media',
  NativeAdSlot.price: 'price',
  NativeAdSlot.rating: 'rating',
  NativeAdSlot.store: 'store',
};

_$AdButtonView _$_$AdButtonViewFromJson(Map json) {
  return _$AdButtonView(
    id: _$enumDecodeNullable(_$NativeAdSlotEnumMap, json['id']),
    text: json['text'] as String,
    style: json['style'] == null
        ? null
        : NativeTextStyle.fromJson((json['style'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    padding: const EdgeInsetsConverter().fromJson(json['padding'] as Map),
    margin: const EdgeInsetsConverter().fromJson(json['margin'] as Map),
    width: (json['width'] as num)?.toDouble() ?? -1.0,
    height: (json['height'] as num)?.toDouble() ?? -2.0,
    highlightColor:
        const ColorHexConverter().fromJson(json['highlightColor'] as String),
    decoration: json['decoration'] == null
        ? null
        : AdDecoration.fromJson((json['decoration'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$_$AdButtonViewToJson(_$AdButtonView instance) =>
    <String, dynamic>{
      'id': _$NativeAdSlotEnumMap[instance.id],
      'text': instance.text,
      'style': instance.style?.toJson(),
      'padding': const EdgeInsetsConverter().toJson(instance.padding),
      'margin': const EdgeInsetsConverter().toJson(instance.margin),
      'width': instance.width,
      'height': instance.height,
      'highlightColor':
          const ColorHexConverter().toJson(instance.highlightColor),
      'decoration': instance.decoration?.toJson(),
    };

_$AdRatingBarView _$_$AdRatingBarViewFromJson(Map json) {
  return _$AdRatingBarView(
    id: _$enumDecodeNullable(_$NativeAdSlotEnumMap, json['id']),
    padding: const EdgeInsetsConverter().fromJson(json['padding'] as Map),
    margin: const EdgeInsetsConverter().fromJson(json['margin'] as Map),
    width: (json['width'] as num)?.toDouble() ?? -2.0,
    height: (json['height'] as num)?.toDouble() ?? -2.0,
    decoration: json['decoration'] == null
        ? null
        : AdDecoration.fromJson((json['decoration'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    stepSize: (json['stepSize'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$AdRatingBarViewToJson(_$AdRatingBarView instance) =>
    <String, dynamic>{
      'id': _$NativeAdSlotEnumMap[instance.id],
      'padding': const EdgeInsetsConverter().toJson(instance.padding),
      'margin': const EdgeInsetsConverter().toJson(instance.margin),
      'width': instance.width,
      'height': instance.height,
      'decoration': instance.decoration?.toJson(),
      'stepSize': instance.stepSize,
    };

_$AdMediaView _$_$AdMediaViewFromJson(Map json) {
  return _$AdMediaView(
    id: _$enumDecodeNullable(_$NativeAdSlotEnumMap, json['id']),
    padding: const EdgeInsetsConverter().fromJson(json['padding'] as Map),
    margin: const EdgeInsetsConverter().fromJson(json['margin'] as Map),
    width: (json['width'] as num)?.toDouble() ?? -1.0,
    height: (json['height'] as num)?.toDouble() ?? -2.0,
    decoration: json['decoration'] == null
        ? null
        : AdDecoration.fromJson((json['decoration'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$_$AdMediaViewToJson(_$AdMediaView instance) =>
    <String, dynamic>{
      'id': _$NativeAdSlotEnumMap[instance.id],
      'padding': const EdgeInsetsConverter().toJson(instance.padding),
      'margin': const EdgeInsetsConverter().toJson(instance.margin),
      'width': instance.width,
      'height': instance.height,
      'decoration': instance.decoration?.toJson(),
    };

_$AdImageView _$_$AdImageViewFromJson(Map json) {
  return _$AdImageView(
    id: _$enumDecodeNullable(_$NativeAdSlotEnumMap, json['id']),
    padding: const EdgeInsetsConverter().fromJson(json['padding'] as Map),
    margin: const EdgeInsetsConverter().fromJson(json['margin'] as Map),
    width: (json['width'] as num)?.toDouble() ?? 48.0,
    height: (json['height'] as num)?.toDouble() ?? 48.0,
    decoration: json['decoration'] == null
        ? null
        : AdDecoration.fromJson((json['decoration'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$_$AdImageViewToJson(_$AdImageView instance) =>
    <String, dynamic>{
      'id': _$NativeAdSlotEnumMap[instance.id],
      'padding': const EdgeInsetsConverter().toJson(instance.padding),
      'margin': const EdgeInsetsConverter().toJson(instance.margin),
      'width': instance.width,
      'height': instance.height,
      'decoration': instance.decoration?.toJson(),
    };
