// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_ad_builder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NativeAdPlatformViewProps _$_$_NativeAdPlatformViewPropsFromJson(Map json) {
  return _$_NativeAdPlatformViewProps(
    controllerId: json['controllerId'] as String,
    view: json['view'] == null
        ? null
        : AdView.fromJson((json['view'] as Map)?.map(
            (k, e) => MapEntry(k as String, e),
          )),
  );
}

Map<String, dynamic> _$_$_NativeAdPlatformViewPropsToJson(
        _$_NativeAdPlatformViewProps instance) =>
    <String, dynamic>{
      'controllerId': instance.controllerId,
      'view': instance.view?.toJson(),
    };
