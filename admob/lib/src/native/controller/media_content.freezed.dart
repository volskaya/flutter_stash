// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'media_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
MediaContent _$MediaContentFromJson(Map<String, dynamic> json) {
  return _MediaContent.fromJson(json);
}

/// @nodoc
class _$MediaContentTearOff {
  const _$MediaContentTearOff();

// ignore: unused_element
  _MediaContent call(
      {@required double aspectRatio,
      @required Duration duration,
      @required bool hasVideoContent}) {
    return _MediaContent(
      aspectRatio: aspectRatio,
      duration: duration,
      hasVideoContent: hasVideoContent,
    );
  }

// ignore: unused_element
  MediaContent fromJson(Map<String, Object> json) {
    return MediaContent.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $MediaContent = _$MediaContentTearOff();

/// @nodoc
mixin _$MediaContent {
  /// The aspect ratio of the media content, which can be an image or a video.
  /// This usually corresponds to the aspect ratio set in `options` ([NativeAdOptions]):
  ///
  /// - MEDIA_ASPECT_RATIO_ANY: Can be any of the aspect ratios said below
  /// - MEDIA_ASPECT_RATIO_LANDSCAPE: Usually 16:9
  /// - MEDIA_ASPECT_RATIO_PORTRAIT: Usually 4:3
  /// - MEDIA_ASPECT_RATIO_SQUARE: Usually 1:1
  double get aspectRatio;

  /// The duration of the video, if avaiable.
  Duration get duration;

  /// Indicates whether the media content has video content (`true`) or not (`false`).
  bool get hasVideoContent;

  Map<String, dynamic> toJson();
  $MediaContentCopyWith<MediaContent> get copyWith;
}

/// @nodoc
abstract class $MediaContentCopyWith<$Res> {
  factory $MediaContentCopyWith(
          MediaContent value, $Res Function(MediaContent) then) =
      _$MediaContentCopyWithImpl<$Res>;
  $Res call({double aspectRatio, Duration duration, bool hasVideoContent});
}

/// @nodoc
class _$MediaContentCopyWithImpl<$Res> implements $MediaContentCopyWith<$Res> {
  _$MediaContentCopyWithImpl(this._value, this._then);

  final MediaContent _value;
  // ignore: unused_field
  final $Res Function(MediaContent) _then;

  @override
  $Res call({
    Object aspectRatio = freezed,
    Object duration = freezed,
    Object hasVideoContent = freezed,
  }) {
    return _then(_value.copyWith(
      aspectRatio:
          aspectRatio == freezed ? _value.aspectRatio : aspectRatio as double,
      duration: duration == freezed ? _value.duration : duration as Duration,
      hasVideoContent: hasVideoContent == freezed
          ? _value.hasVideoContent
          : hasVideoContent as bool,
    ));
  }
}

/// @nodoc
abstract class _$MediaContentCopyWith<$Res>
    implements $MediaContentCopyWith<$Res> {
  factory _$MediaContentCopyWith(
          _MediaContent value, $Res Function(_MediaContent) then) =
      __$MediaContentCopyWithImpl<$Res>;
  @override
  $Res call({double aspectRatio, Duration duration, bool hasVideoContent});
}

/// @nodoc
class __$MediaContentCopyWithImpl<$Res> extends _$MediaContentCopyWithImpl<$Res>
    implements _$MediaContentCopyWith<$Res> {
  __$MediaContentCopyWithImpl(
      _MediaContent _value, $Res Function(_MediaContent) _then)
      : super(_value, (v) => _then(v as _MediaContent));

  @override
  _MediaContent get _value => super._value as _MediaContent;

  @override
  $Res call({
    Object aspectRatio = freezed,
    Object duration = freezed,
    Object hasVideoContent = freezed,
  }) {
    return _then(_MediaContent(
      aspectRatio:
          aspectRatio == freezed ? _value.aspectRatio : aspectRatio as double,
      duration: duration == freezed ? _value.duration : duration as Duration,
      hasVideoContent: hasVideoContent == freezed
          ? _value.hasVideoContent
          : hasVideoContent as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_MediaContent implements _MediaContent {
  const _$_MediaContent(
      {@required this.aspectRatio,
      @required this.duration,
      @required this.hasVideoContent})
      : assert(aspectRatio != null),
        assert(duration != null),
        assert(hasVideoContent != null);

  factory _$_MediaContent.fromJson(Map<String, dynamic> json) =>
      _$_$_MediaContentFromJson(json);

  @override

  /// The aspect ratio of the media content, which can be an image or a video.
  /// This usually corresponds to the aspect ratio set in `options` ([NativeAdOptions]):
  ///
  /// - MEDIA_ASPECT_RATIO_ANY: Can be any of the aspect ratios said below
  /// - MEDIA_ASPECT_RATIO_LANDSCAPE: Usually 16:9
  /// - MEDIA_ASPECT_RATIO_PORTRAIT: Usually 4:3
  /// - MEDIA_ASPECT_RATIO_SQUARE: Usually 1:1
  final double aspectRatio;
  @override

  /// The duration of the video, if avaiable.
  final Duration duration;
  @override

  /// Indicates whether the media content has video content (`true`) or not (`false`).
  final bool hasVideoContent;

  @override
  String toString() {
    return 'MediaContent(aspectRatio: $aspectRatio, duration: $duration, hasVideoContent: $hasVideoContent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MediaContent &&
            (identical(other.aspectRatio, aspectRatio) ||
                const DeepCollectionEquality()
                    .equals(other.aspectRatio, aspectRatio)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.hasVideoContent, hasVideoContent) ||
                const DeepCollectionEquality()
                    .equals(other.hasVideoContent, hasVideoContent)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(aspectRatio) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(hasVideoContent);

  @override
  _$MediaContentCopyWith<_MediaContent> get copyWith =>
      __$MediaContentCopyWithImpl<_MediaContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MediaContentToJson(this);
  }
}

abstract class _MediaContent implements MediaContent {
  const factory _MediaContent(
      {@required double aspectRatio,
      @required Duration duration,
      @required bool hasVideoContent}) = _$_MediaContent;

  factory _MediaContent.fromJson(Map<String, dynamic> json) =
      _$_MediaContent.fromJson;

  @override

  /// The aspect ratio of the media content, which can be an image or a video.
  /// This usually corresponds to the aspect ratio set in `options` ([NativeAdOptions]):
  ///
  /// - MEDIA_ASPECT_RATIO_ANY: Can be any of the aspect ratios said below
  /// - MEDIA_ASPECT_RATIO_LANDSCAPE: Usually 16:9
  /// - MEDIA_ASPECT_RATIO_PORTRAIT: Usually 4:3
  /// - MEDIA_ASPECT_RATIO_SQUARE: Usually 1:1
  double get aspectRatio;
  @override

  /// The duration of the video, if avaiable.
  Duration get duration;
  @override

  /// Indicates whether the media content has video content (`true`) or not (`false`).
  bool get hasVideoContent;
  @override
  _$MediaContentCopyWith<_MediaContent> get copyWith;
}
