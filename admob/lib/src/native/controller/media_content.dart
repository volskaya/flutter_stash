import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_content.freezed.dart';
part 'media_content.g.dart';

/// Class used to tell the info about the media content of a Native Ad.
/// It's usually used alongside [NativeAdController]. A media content is
/// never null.
///
/// The Media Content can be an image or a video. If you're using test ads,
/// video ads needs to be requested using the Native Video Test Ad Unit Id,
/// which you can get by calling `MobileAds.nativeAdVideoTestUnitId`
@freezed
abstract class MediaContent with _$MediaContent {
  const factory MediaContent({
    /// The aspect ratio of the media content, which can be an image or a video.
    /// This usually corresponds to the aspect ratio set in `options` ([NativeAdOptions]):
    ///
    /// - MEDIA_ASPECT_RATIO_ANY: Can be any of the aspect ratios said below
    /// - MEDIA_ASPECT_RATIO_LANDSCAPE: Usually 16:9
    /// - MEDIA_ASPECT_RATIO_PORTRAIT: Usually 4:3
    /// - MEDIA_ASPECT_RATIO_SQUARE: Usually 1:1
    @required double aspectRatio,

    /// The duration of the video, if avaiable.
    @required Duration duration,

    /// Indicates whether the media content has video content (`true`) or not (`false`).
    @required bool hasVideoContent,
  }) = _MediaContent;

  factory MediaContent.fromJson(Map<String, dynamic> json) => _$MediaContentFromJson(json);
}
