// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MediaContent _$_$_MediaContentFromJson(Map json) {
  return _$_MediaContent(
    aspectRatio: (json['aspectRatio'] as num)?.toDouble(),
    duration: json['duration'] == null
        ? null
        : Duration(microseconds: json['duration'] as int),
    hasVideoContent: json['hasVideoContent'] as bool,
  );
}

Map<String, dynamic> _$_$_MediaContentToJson(_$_MediaContent instance) =>
    <String, dynamic>{
      'aspectRatio': instance.aspectRatio,
      'duration': instance.duration?.inMicroseconds,
      'hasVideoContent': instance.hasVideoContent,
    };
