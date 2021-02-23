// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'platform_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
NativeAdPlatformProps _$NativeAdPlatformPropsFromJson(
    Map<String, dynamic> json) {
  return _NativeAdPlatformProps.fromJson(json);
}

/// @nodoc
class _$NativeAdPlatformPropsTearOff {
  const _$NativeAdPlatformPropsTearOff();

// ignore: unused_element
  _NativeAdPlatformProps call(
      {@required String unitId,
      @required Map<String, NativeAdOptions> options}) {
    return _NativeAdPlatformProps(
      unitId: unitId,
      options: options,
    );
  }

// ignore: unused_element
  NativeAdPlatformProps fromJson(Map<String, Object> json) {
    return NativeAdPlatformProps.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $NativeAdPlatformProps = _$NativeAdPlatformPropsTearOff();

/// @nodoc
mixin _$NativeAdPlatformProps {
  String get unitId;
  Map<String, NativeAdOptions> get options;

  Map<String, dynamic> toJson();
  $NativeAdPlatformPropsCopyWith<NativeAdPlatformProps> get copyWith;
}

/// @nodoc
abstract class $NativeAdPlatformPropsCopyWith<$Res> {
  factory $NativeAdPlatformPropsCopyWith(NativeAdPlatformProps value,
          $Res Function(NativeAdPlatformProps) then) =
      _$NativeAdPlatformPropsCopyWithImpl<$Res>;
  $Res call({String unitId, Map<String, NativeAdOptions> options});
}

/// @nodoc
class _$NativeAdPlatformPropsCopyWithImpl<$Res>
    implements $NativeAdPlatformPropsCopyWith<$Res> {
  _$NativeAdPlatformPropsCopyWithImpl(this._value, this._then);

  final NativeAdPlatformProps _value;
  // ignore: unused_field
  final $Res Function(NativeAdPlatformProps) _then;

  @override
  $Res call({
    Object unitId = freezed,
    Object options = freezed,
  }) {
    return _then(_value.copyWith(
      unitId: unitId == freezed ? _value.unitId : unitId as String,
      options: options == freezed
          ? _value.options
          : options as Map<String, NativeAdOptions>,
    ));
  }
}

/// @nodoc
abstract class _$NativeAdPlatformPropsCopyWith<$Res>
    implements $NativeAdPlatformPropsCopyWith<$Res> {
  factory _$NativeAdPlatformPropsCopyWith(_NativeAdPlatformProps value,
          $Res Function(_NativeAdPlatformProps) then) =
      __$NativeAdPlatformPropsCopyWithImpl<$Res>;
  @override
  $Res call({String unitId, Map<String, NativeAdOptions> options});
}

/// @nodoc
class __$NativeAdPlatformPropsCopyWithImpl<$Res>
    extends _$NativeAdPlatformPropsCopyWithImpl<$Res>
    implements _$NativeAdPlatformPropsCopyWith<$Res> {
  __$NativeAdPlatformPropsCopyWithImpl(_NativeAdPlatformProps _value,
      $Res Function(_NativeAdPlatformProps) _then)
      : super(_value, (v) => _then(v as _NativeAdPlatformProps));

  @override
  _NativeAdPlatformProps get _value => super._value as _NativeAdPlatformProps;

  @override
  $Res call({
    Object unitId = freezed,
    Object options = freezed,
  }) {
    return _then(_NativeAdPlatformProps(
      unitId: unitId == freezed ? _value.unitId : unitId as String,
      options: options == freezed
          ? _value.options
          : options as Map<String, NativeAdOptions>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_NativeAdPlatformProps implements _NativeAdPlatformProps {
  const _$_NativeAdPlatformProps(
      {@required this.unitId, @required this.options})
      : assert(unitId != null),
        assert(options != null);

  factory _$_NativeAdPlatformProps.fromJson(Map<String, dynamic> json) =>
      _$_$_NativeAdPlatformPropsFromJson(json);

  @override
  final String unitId;
  @override
  final Map<String, NativeAdOptions> options;

  @override
  String toString() {
    return 'NativeAdPlatformProps(unitId: $unitId, options: $options)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NativeAdPlatformProps &&
            (identical(other.unitId, unitId) ||
                const DeepCollectionEquality().equals(other.unitId, unitId)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(unitId) ^
      const DeepCollectionEquality().hash(options);

  @override
  _$NativeAdPlatformPropsCopyWith<_NativeAdPlatformProps> get copyWith =>
      __$NativeAdPlatformPropsCopyWithImpl<_NativeAdPlatformProps>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NativeAdPlatformPropsToJson(this);
  }
}

abstract class _NativeAdPlatformProps implements NativeAdPlatformProps {
  const factory _NativeAdPlatformProps(
          {@required String unitId,
          @required Map<String, NativeAdOptions> options}) =
      _$_NativeAdPlatformProps;

  factory _NativeAdPlatformProps.fromJson(Map<String, dynamic> json) =
      _$_NativeAdPlatformProps.fromJson;

  @override
  String get unitId;
  @override
  Map<String, NativeAdOptions> get options;
  @override
  _$NativeAdPlatformPropsCopyWith<_NativeAdPlatformProps> get copyWith;
}

PlatformProps _$PlatformPropsFromJson(Map<String, dynamic> json) {
  return _PlatformProps.fromJson(json);
}

/// @nodoc
class _$PlatformPropsTearOff {
  const _$PlatformPropsTearOff();

// ignore: unused_element
  _PlatformProps call({@required NativeAdPlatformProps nativeAd}) {
    return _PlatformProps(
      nativeAd: nativeAd,
    );
  }

// ignore: unused_element
  PlatformProps fromJson(Map<String, Object> json) {
    return PlatformProps.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $PlatformProps = _$PlatformPropsTearOff();

/// @nodoc
mixin _$PlatformProps {
  NativeAdPlatformProps get nativeAd;

  Map<String, dynamic> toJson();
  $PlatformPropsCopyWith<PlatformProps> get copyWith;
}

/// @nodoc
abstract class $PlatformPropsCopyWith<$Res> {
  factory $PlatformPropsCopyWith(
          PlatformProps value, $Res Function(PlatformProps) then) =
      _$PlatformPropsCopyWithImpl<$Res>;
  $Res call({NativeAdPlatformProps nativeAd});

  $NativeAdPlatformPropsCopyWith<$Res> get nativeAd;
}

/// @nodoc
class _$PlatformPropsCopyWithImpl<$Res>
    implements $PlatformPropsCopyWith<$Res> {
  _$PlatformPropsCopyWithImpl(this._value, this._then);

  final PlatformProps _value;
  // ignore: unused_field
  final $Res Function(PlatformProps) _then;

  @override
  $Res call({
    Object nativeAd = freezed,
  }) {
    return _then(_value.copyWith(
      nativeAd: nativeAd == freezed
          ? _value.nativeAd
          : nativeAd as NativeAdPlatformProps,
    ));
  }

  @override
  $NativeAdPlatformPropsCopyWith<$Res> get nativeAd {
    if (_value.nativeAd == null) {
      return null;
    }
    return $NativeAdPlatformPropsCopyWith<$Res>(_value.nativeAd, (value) {
      return _then(_value.copyWith(nativeAd: value));
    });
  }
}

/// @nodoc
abstract class _$PlatformPropsCopyWith<$Res>
    implements $PlatformPropsCopyWith<$Res> {
  factory _$PlatformPropsCopyWith(
          _PlatformProps value, $Res Function(_PlatformProps) then) =
      __$PlatformPropsCopyWithImpl<$Res>;
  @override
  $Res call({NativeAdPlatformProps nativeAd});

  @override
  $NativeAdPlatformPropsCopyWith<$Res> get nativeAd;
}

/// @nodoc
class __$PlatformPropsCopyWithImpl<$Res>
    extends _$PlatformPropsCopyWithImpl<$Res>
    implements _$PlatformPropsCopyWith<$Res> {
  __$PlatformPropsCopyWithImpl(
      _PlatformProps _value, $Res Function(_PlatformProps) _then)
      : super(_value, (v) => _then(v as _PlatformProps));

  @override
  _PlatformProps get _value => super._value as _PlatformProps;

  @override
  $Res call({
    Object nativeAd = freezed,
  }) {
    return _then(_PlatformProps(
      nativeAd: nativeAd == freezed
          ? _value.nativeAd
          : nativeAd as NativeAdPlatformProps,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_PlatformProps implements _PlatformProps {
  const _$_PlatformProps({@required this.nativeAd}) : assert(nativeAd != null);

  factory _$_PlatformProps.fromJson(Map<String, dynamic> json) =>
      _$_$_PlatformPropsFromJson(json);

  @override
  final NativeAdPlatformProps nativeAd;

  @override
  String toString() {
    return 'PlatformProps(nativeAd: $nativeAd)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PlatformProps &&
            (identical(other.nativeAd, nativeAd) ||
                const DeepCollectionEquality()
                    .equals(other.nativeAd, nativeAd)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(nativeAd);

  @override
  _$PlatformPropsCopyWith<_PlatformProps> get copyWith =>
      __$PlatformPropsCopyWithImpl<_PlatformProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PlatformPropsToJson(this);
  }
}

abstract class _PlatformProps implements PlatformProps {
  const factory _PlatformProps({@required NativeAdPlatformProps nativeAd}) =
      _$_PlatformProps;

  factory _PlatformProps.fromJson(Map<String, dynamic> json) =
      _$_PlatformProps.fromJson;

  @override
  NativeAdPlatformProps get nativeAd;
  @override
  _$PlatformPropsCopyWith<_PlatformProps> get copyWith;
}
