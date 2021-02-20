// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Country _$_$_CountryFromJson(Map json) {
  return _$_Country(
    numCode: json['numCode'] as String,
    alphaCode2: json['alphaCode2'] as String,
    alphaCode3: json['alphaCode3'] as String,
    name: json['name'] as String,
    nationality: json['nationality'] as String,
    code: json['code'] as String,
    stripe: json['stripe'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_CountryToJson(_$_Country instance) =>
    <String, dynamic>{
      'numCode': instance.numCode,
      'alphaCode2': instance.alphaCode2,
      'alphaCode3': instance.alphaCode3,
      'name': instance.name,
      'nationality': instance.nationality,
      'code': instance.code,
      'stripe': instance.stripe,
    };
