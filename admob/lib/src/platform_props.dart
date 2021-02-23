import 'package:admob/src/native/controller/options.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'platform_props.freezed.dart';
part 'platform_props.g.dart';

@freezed
abstract class NativeAdPlatformProps with _$NativeAdPlatformProps {
  const factory NativeAdPlatformProps({
    @required String unitId,
    @required Map<String, NativeAdOptions> options,
  }) = _NativeAdPlatformProps;

  factory NativeAdPlatformProps.fromJson(Map<String, dynamic> json) => _$NativeAdPlatformPropsFromJson(json);
}

@freezed
abstract class PlatformProps with _$PlatformProps {
  const factory PlatformProps({
    @required NativeAdPlatformProps nativeAd,
  }) = _PlatformProps;

  factory PlatformProps.fromJson(Map<String, dynamic> json) => _$PlatformPropsFromJson(json);
}
