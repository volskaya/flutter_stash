// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_coordinator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ConsentCoordinatorState _$_$_ConsentCoordinatorStateFromJson(Map json) {
  return _$_ConsentCoordinatorState(
    status: _$enumDecodeNullable(_$ConsentStatusEnumMap, json['status']) ??
        ConsentStatus.unknown,
    type: _$enumDecodeNullable(_$ConsentTypeEnumMap, json['type']) ??
        ConsentType.unknown,
    isContentFormAvailable: json['isContentFormAvailable'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_ConsentCoordinatorStateToJson(
        _$_ConsentCoordinatorState instance) =>
    <String, dynamic>{
      'status': _$ConsentStatusEnumMap[instance.status],
      'type': _$ConsentTypeEnumMap[instance.type],
      'isContentFormAvailable': instance.isContentFormAvailable,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ConsentStatusEnumMap = {
  ConsentStatus.unknown: 0,
  ConsentStatus.notRequired: 1,
  ConsentStatus.required: 2,
  ConsentStatus.obtained: 3,
};

const _$ConsentTypeEnumMap = {
  ConsentType.unknown: 0,
  ConsentType.nonPersonalized: 1,
  ConsentType.personalized: 2,
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConsentCoordinator on _ConsentCoordinator, Store {
  Computed<ConsentStatus> _$statusComputed;

  @override
  ConsentStatus get status =>
      (_$statusComputed ??= Computed<ConsentStatus>(() => super.status,
              name: '_ConsentCoordinator.status'))
          .value;
  Computed<ConsentType> _$typeComputed;

  @override
  ConsentType get type =>
      (_$typeComputed ??= Computed<ConsentType>(() => super.type,
              name: '_ConsentCoordinator.type'))
          .value;
  Computed<bool> _$isContentFormAvailableComputed;

  @override
  bool get isContentFormAvailable => (_$isContentFormAvailableComputed ??=
          Computed<bool>(() => super.isContentFormAvailable,
              name: '_ConsentCoordinator.isContentFormAvailable'))
      .value;

  @override
  String toString() {
    return '''
status: ${status},
type: ${type},
isContentFormAvailable: ${isContentFormAvailable}
    ''';
  }
}
