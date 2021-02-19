import 'dart:typed_data';

import 'package:admob/src/helpers/converters.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'native_ad.freezed.dart';
part 'native_ad.g.dart';

@freezed
abstract class NativeAdImageDrawable with _$NativeAdImageDrawable {
  factory NativeAdImageDrawable({
    @required double width,
    @required double height,
    @required @Uint8ListConverter() Uint8List bitmap,
  }) = _NativeAdImageDrawable;

  factory NativeAdImageDrawable.fromJson(Map<String, dynamic> json) => _$NativeAdImageDrawableFromJson(json);

  @late
  Size get size => Size(width, height);
}

@freezed
abstract class NativeAdImage with _$NativeAdImage {
  factory NativeAdImage({
    @required String uri,
    @required double scale,
    NativeAdImageDrawable drawable, // The drawable is null, if native ad options requested URLs only.
  }) = _NativeAdImage;

  factory NativeAdImage.fromJson(Map<String, dynamic> json) => _$NativeAdImageFromJson(json);
}

@freezed
abstract class NativeAdMediaContent with _$NativeAdMediaContent {
  const factory NativeAdMediaContent({
    @required double aspectRatio,
    @required bool hasVideoContent,
    @required double duration,
    @Uint8ListConverter() Uint8List mainImage,
  }) = _NativeAdMediaContent;

  factory NativeAdMediaContent.fromJson(Map<String, dynamic> json) => _$NativeAdMediaContentFromJson(json);
}

@freezed
abstract class AdChoicesInfo with _$AdChoicesInfo {
  factory AdChoicesInfo({
    @required String text,
    @JsonKey(defaultValue: <NativeAdImage>[]) @Default(<NativeAdImage>[]) List<NativeAdImage> images,
  }) = _AdChoicesInfo;

  factory AdChoicesInfo.fromJson(Map<String, dynamic> json) => _$AdChoicesInfoFromJson(json);

  @late
  NativeAdImage get image => images.isNotEmpty ? images.first : null;
}

@freezed
abstract class NativeAd with _$NativeAd {
  factory NativeAd({
    @required String headline,
    @required String body,
    NativeAdImage icon,
    String callToAction,
    String advertiser,
    String price,
    String store,
    double starRating,
    bool isCustomClickGestureEnabled,
    bool isCustomMuteThisAdEnabled,
    AdChoicesInfo adChoicesInfo,
    NativeAdMediaContent mediaContent,
    @JsonKey(defaultValue: <NativeAdImage>[]) @Default(<NativeAdImage>[]) List<NativeAdImage> images,
    @JsonKey(defaultValue: <String>[]) @Default(<String>[]) List<String> muteThisAdReasons,
  }) = NativeAdData;

  factory NativeAd.loading() = NativeAdLoadingData;
  factory NativeAd.error({@required String message}) = NativeAdErrorData;

  factory NativeAd.fromJson(Map<String, dynamic> json) => _$NativeAdFromJson(json);

  @late
  NativeAdImage get image => maybeMap(
        (data) => data.images.isNotEmpty ? data.images.first : null,
        orElse: () => null,
      );
}
