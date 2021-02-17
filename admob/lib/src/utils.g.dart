// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utils.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AdError _$_$_AdErrorFromJson(Map json) {
  return _$_AdError(
    code: json['code'] as int,
    message: json['message'] as String,
    domain: json['domain'] as String,
  );
}

Map<String, dynamic> _$_$_AdErrorToJson(_$_AdError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'domain': instance.domain,
    };
