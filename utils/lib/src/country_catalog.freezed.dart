// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'country_catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Country _$CountryFromJson(Map<String, dynamic> json) {
  return _Country.fromJson(json);
}

/// @nodoc
class _$CountryTearOff {
  const _$CountryTearOff();

// ignore: unused_element
  _Country call(
      {@required @JsonKey() String numCode,
      @required @JsonKey() String alphaCode2,
      @required @JsonKey() String alphaCode3,
      @required @JsonKey() String name,
      @required @JsonKey() String nationality,
      @required @JsonKey() String code,
      @JsonKey(defaultValue: false) bool stripe = false}) {
    return _Country(
      numCode: numCode,
      alphaCode2: alphaCode2,
      alphaCode3: alphaCode3,
      name: name,
      nationality: nationality,
      code: code,
      stripe: stripe,
    );
  }

// ignore: unused_element
  Country fromJson(Map<String, Object> json) {
    return Country.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Country = _$CountryTearOff();

/// @nodoc
mixin _$Country {
  @JsonKey()
  String get numCode;
  @JsonKey()
  String get alphaCode2;
  @JsonKey()
  String get alphaCode3;
  @JsonKey()
  String get name;
  @JsonKey()
  String get nationality;
  @JsonKey()
  String get code;
  @JsonKey(defaultValue: false)
  bool get stripe;

  Map<String, dynamic> toJson();
  $CountryCopyWith<Country> get copyWith;
}

/// @nodoc
abstract class $CountryCopyWith<$Res> {
  factory $CountryCopyWith(Country value, $Res Function(Country) then) =
      _$CountryCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey() String numCode,
      @JsonKey() String alphaCode2,
      @JsonKey() String alphaCode3,
      @JsonKey() String name,
      @JsonKey() String nationality,
      @JsonKey() String code,
      @JsonKey(defaultValue: false) bool stripe});
}

/// @nodoc
class _$CountryCopyWithImpl<$Res> implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._value, this._then);

  final Country _value;
  // ignore: unused_field
  final $Res Function(Country) _then;

  @override
  $Res call({
    Object numCode = freezed,
    Object alphaCode2 = freezed,
    Object alphaCode3 = freezed,
    Object name = freezed,
    Object nationality = freezed,
    Object code = freezed,
    Object stripe = freezed,
  }) {
    return _then(_value.copyWith(
      numCode: numCode == freezed ? _value.numCode : numCode as String,
      alphaCode2:
          alphaCode2 == freezed ? _value.alphaCode2 : alphaCode2 as String,
      alphaCode3:
          alphaCode3 == freezed ? _value.alphaCode3 : alphaCode3 as String,
      name: name == freezed ? _value.name : name as String,
      nationality:
          nationality == freezed ? _value.nationality : nationality as String,
      code: code == freezed ? _value.code : code as String,
      stripe: stripe == freezed ? _value.stripe : stripe as bool,
    ));
  }
}

/// @nodoc
abstract class _$CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$CountryCopyWith(_Country value, $Res Function(_Country) then) =
      __$CountryCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey() String numCode,
      @JsonKey() String alphaCode2,
      @JsonKey() String alphaCode3,
      @JsonKey() String name,
      @JsonKey() String nationality,
      @JsonKey() String code,
      @JsonKey(defaultValue: false) bool stripe});
}

/// @nodoc
class __$CountryCopyWithImpl<$Res> extends _$CountryCopyWithImpl<$Res>
    implements _$CountryCopyWith<$Res> {
  __$CountryCopyWithImpl(_Country _value, $Res Function(_Country) _then)
      : super(_value, (v) => _then(v as _Country));

  @override
  _Country get _value => super._value as _Country;

  @override
  $Res call({
    Object numCode = freezed,
    Object alphaCode2 = freezed,
    Object alphaCode3 = freezed,
    Object name = freezed,
    Object nationality = freezed,
    Object code = freezed,
    Object stripe = freezed,
  }) {
    return _then(_Country(
      numCode: numCode == freezed ? _value.numCode : numCode as String,
      alphaCode2:
          alphaCode2 == freezed ? _value.alphaCode2 : alphaCode2 as String,
      alphaCode3:
          alphaCode3 == freezed ? _value.alphaCode3 : alphaCode3 as String,
      name: name == freezed ? _value.name : name as String,
      nationality:
          nationality == freezed ? _value.nationality : nationality as String,
      code: code == freezed ? _value.code : code as String,
      stripe: stripe == freezed ? _value.stripe : stripe as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Country implements _Country {
  const _$_Country(
      {@required @JsonKey() this.numCode,
      @required @JsonKey() this.alphaCode2,
      @required @JsonKey() this.alphaCode3,
      @required @JsonKey() this.name,
      @required @JsonKey() this.nationality,
      @required @JsonKey() this.code,
      @JsonKey(defaultValue: false) this.stripe = false})
      : assert(numCode != null),
        assert(alphaCode2 != null),
        assert(alphaCode3 != null),
        assert(name != null),
        assert(nationality != null),
        assert(code != null),
        assert(stripe != null);

  factory _$_Country.fromJson(Map<String, dynamic> json) =>
      _$_$_CountryFromJson(json);

  @override
  @JsonKey()
  final String numCode;
  @override
  @JsonKey()
  final String alphaCode2;
  @override
  @JsonKey()
  final String alphaCode3;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String nationality;
  @override
  @JsonKey()
  final String code;
  @override
  @JsonKey(defaultValue: false)
  final bool stripe;

  @override
  String toString() {
    return 'Country(numCode: $numCode, alphaCode2: $alphaCode2, alphaCode3: $alphaCode3, name: $name, nationality: $nationality, code: $code, stripe: $stripe)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Country &&
            (identical(other.numCode, numCode) ||
                const DeepCollectionEquality()
                    .equals(other.numCode, numCode)) &&
            (identical(other.alphaCode2, alphaCode2) ||
                const DeepCollectionEquality()
                    .equals(other.alphaCode2, alphaCode2)) &&
            (identical(other.alphaCode3, alphaCode3) ||
                const DeepCollectionEquality()
                    .equals(other.alphaCode3, alphaCode3)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.nationality, nationality) ||
                const DeepCollectionEquality()
                    .equals(other.nationality, nationality)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.stripe, stripe) ||
                const DeepCollectionEquality().equals(other.stripe, stripe)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(numCode) ^
      const DeepCollectionEquality().hash(alphaCode2) ^
      const DeepCollectionEquality().hash(alphaCode3) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(nationality) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(stripe);

  @override
  _$CountryCopyWith<_Country> get copyWith =>
      __$CountryCopyWithImpl<_Country>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CountryToJson(this);
  }
}

abstract class _Country implements Country {
  const factory _Country(
      {@required @JsonKey() String numCode,
      @required @JsonKey() String alphaCode2,
      @required @JsonKey() String alphaCode3,
      @required @JsonKey() String name,
      @required @JsonKey() String nationality,
      @required @JsonKey() String code,
      @JsonKey(defaultValue: false) bool stripe}) = _$_Country;

  factory _Country.fromJson(Map<String, dynamic> json) = _$_Country.fromJson;

  @override
  @JsonKey()
  String get numCode;
  @override
  @JsonKey()
  String get alphaCode2;
  @override
  @JsonKey()
  String get alphaCode3;
  @override
  @JsonKey()
  String get name;
  @override
  @JsonKey()
  String get nationality;
  @override
  @JsonKey()
  String get code;
  @override
  @JsonKey(defaultValue: false)
  bool get stripe;
  @override
  _$CountryCopyWith<_Country> get copyWith;
}
