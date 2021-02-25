import 'package:freezed_annotation/freezed_annotation.dart';

part 'options.freezed.dart';
part 'options.g.dart';

const int ADCHOICES_TOP_LEFT = 0;
const int ADCHOICES_TOP_RIGHT = 1;
const int ADCHOICES_BOTTOM_RIGHT = 2;
const int ADCHOICES_BOTTOM_LEFT = 3;

const int MEDIA_ASPECT_RATIO_ANY = 1;
const int MEDIA_ASPECT_RATIO_LANDSCAPE = 2;
const int MEDIA_ASPECT_RATIO_PORTRAIT = 3;
const int MEDIA_ASPECT_RATIO_SQUARE = 4;

enum AdChoicesPlacement {
  @JsonValue(0)
  topLeft,
  @JsonValue(1)
  topRight,
  @JsonValue(2)
  bottomRight,
  @JsonValue(3)
  bottomLeft,
}

enum AdMediaAspectRatio {
  @JsonValue(0)
  unknown,
  @JsonValue(1)
  any,
  @JsonValue(2)
  landscape,
  @JsonValue(3)
  portrait,
  @JsonValue(4)
  square,
}

@freezed
abstract class VideoOptions with _$VideoOptions {
  const factory VideoOptions({
    @Default(true) bool startMuted,
  }) = _VideoOptions;

  factory VideoOptions.fromJson(Map<String, dynamic> json) => _$VideoOptionsFromJson(json);
}

@freezed
abstract class NativeAdOptions with _$NativeAdOptions {
  const factory NativeAdOptions({
    @Default(NativeAdOptions.defaultKey) String key,
    @Default(true) bool showVideoContent, // This is not an admob specific field.
    @Default(false) bool requestCustomMuteThisAd,
    @Default(false) bool requestMultipleImages,
    @Default(true) bool returnUrlsForImageAssets, // No point of preparing the native drawables.
    @Default(AdChoicesPlacement.topRight) AdChoicesPlacement adChoicesPlacement,
    @Default(AdMediaAspectRatio.landscape) AdMediaAspectRatio mediaAspectRatio,
    VideoOptions videoOptions,
  }) = _NativeAdOptions;

  factory NativeAdOptions.fromJson(Map<String, dynamic> json) => _$NativeAdOptionsFromJson(json);

  static const defaultKey = 'default';
}
