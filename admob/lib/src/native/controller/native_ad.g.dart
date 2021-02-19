// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NativeAdImageDrawable _$_$_NativeAdImageDrawableFromJson(Map json) {
  return _$_NativeAdImageDrawable(
    width: (json['width'] as num)?.toDouble(),
    height: (json['height'] as num)?.toDouble(),
    bitmap: const Uint8ListConverter().fromJson(json['bitmap']),
  );
}

Map<String, dynamic> _$_$_NativeAdImageDrawableToJson(
        _$_NativeAdImageDrawable instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'bitmap': const Uint8ListConverter().toJson(instance.bitmap),
    };

_$_NativeAdImage _$_$_NativeAdImageFromJson(Map json) {
  return _$_NativeAdImage(
    uri: json['uri'] as String,
    scale: (json['scale'] as num)?.toDouble(),
    drawable: json['drawable'] == null
        ? null
        : NativeAdImageDrawable.fromJson((json['drawable'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$_$_NativeAdImageToJson(_$_NativeAdImage instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'scale': instance.scale,
      'drawable': instance.drawable?.toJson(),
    };

_$_NativeAdMediaContent _$_$_NativeAdMediaContentFromJson(Map json) {
  return _$_NativeAdMediaContent(
    aspectRatio: (json['aspectRatio'] as num)?.toDouble(),
    hasVideoContent: json['hasVideoContent'] as bool,
    duration: (json['duration'] as num)?.toDouble(),
    mainImage: const Uint8ListConverter().fromJson(json['mainImage']),
  );
}

Map<String, dynamic> _$_$_NativeAdMediaContentToJson(
        _$_NativeAdMediaContent instance) =>
    <String, dynamic>{
      'aspectRatio': instance.aspectRatio,
      'hasVideoContent': instance.hasVideoContent,
      'duration': instance.duration,
      'mainImage': const Uint8ListConverter().toJson(instance.mainImage),
    };

_$_AdChoicesInfo _$_$_AdChoicesInfoFromJson(Map json) {
  return _$_AdChoicesInfo(
    text: json['text'] as String,
    images: (json['images'] as List)
            ?.map((e) => e == null
                ? null
                : NativeAdImage.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_AdChoicesInfoToJson(_$_AdChoicesInfo instance) =>
    <String, dynamic>{
      'text': instance.text,
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
    };

_$NativeAdData _$_$NativeAdDataFromJson(Map json) {
  return _$NativeAdData(
    headline: json['headline'] as String,
    body: json['body'] as String,
    icon: json['icon'] == null
        ? null
        : NativeAdImage.fromJson((json['icon'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    callToAction: json['callToAction'] as String,
    advertiser: json['advertiser'] as String,
    price: json['price'] as String,
    store: json['store'] as String,
    starRating: (json['starRating'] as num)?.toDouble(),
    isCustomClickGestureEnabled: json['isCustomClickGestureEnabled'] as bool,
    isCustomMuteThisAdEnabled: json['isCustomMuteThisAdEnabled'] as bool,
    adChoicesInfo: json['adChoicesInfo'] == null
        ? null
        : AdChoicesInfo.fromJson((json['adChoicesInfo'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    mediaContent: json['mediaContent'] == null
        ? null
        : NativeAdMediaContent.fromJson((json['mediaContent'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
    images: (json['images'] as List)
            ?.map((e) => e == null
                ? null
                : NativeAdImage.fromJson((e as Map)?.map(
                    (k, e) => MapEntry(k as String, e),
                  )))
            ?.toList() ??
        [],
    muteThisAdReasons: (json['muteThisAdReasons'] as List)
            ?.map((e) => e as String)
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$_$NativeAdDataToJson(_$NativeAdData instance) =>
    <String, dynamic>{
      'headline': instance.headline,
      'body': instance.body,
      'icon': instance.icon?.toJson(),
      'callToAction': instance.callToAction,
      'advertiser': instance.advertiser,
      'price': instance.price,
      'store': instance.store,
      'starRating': instance.starRating,
      'isCustomClickGestureEnabled': instance.isCustomClickGestureEnabled,
      'isCustomMuteThisAdEnabled': instance.isCustomMuteThisAdEnabled,
      'adChoicesInfo': instance.adChoicesInfo?.toJson(),
      'mediaContent': instance.mediaContent?.toJson(),
      'images': instance.images?.map((e) => e?.toJson())?.toList(),
      'muteThisAdReasons': instance.muteThisAdReasons,
    };

_$NativeAdLoadingData _$_$NativeAdLoadingDataFromJson(Map json) {
  return _$NativeAdLoadingData();
}

Map<String, dynamic> _$_$NativeAdLoadingDataToJson(
        _$NativeAdLoadingData instance) =>
    <String, dynamic>{};

_$NativeAdErrorData _$_$NativeAdErrorDataFromJson(Map json) {
  return _$NativeAdErrorData(
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$_$NativeAdErrorDataToJson(
        _$NativeAdErrorData instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
