// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encapsule_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EncapsuleStore on _EncapsuleScaffoldStore, Store {
  Computed<EncapsuleElementValue?>? _$capsuleComputed;

  @override
  EncapsuleElementValue? get capsule => (_$capsuleComputed ??=
          Computed<EncapsuleElementValue?>(() => super.capsule,
              name: '_EncapsuleScaffoldStore.capsule'))
      .value;
  Computed<EncapsuleSheet?>? _$sheetComputed;

  @override
  EncapsuleSheet? get sheet =>
      (_$sheetComputed ??= Computed<EncapsuleSheet?>(() => super.sheet,
              name: '_EncapsuleScaffoldStore.sheet'))
          .value;
  Computed<EncapsuleNotification?>? _$notificationComputed;

  @override
  EncapsuleNotification? get notification => (_$notificationComputed ??=
          Computed<EncapsuleNotification?>(() => super.notification,
              name: '_EncapsuleScaffoldStore.notification'))
      .value;

  late final _$_EncapsuleScaffoldStoreActionController =
      ActionController(name: '_EncapsuleScaffoldStore', context: context);

  @override
  void pushNotification(EncapsuleNotification item,
      [Set<String> _replacements = const <String>{}]) {
    final _$actionInfo = _$_EncapsuleScaffoldStoreActionController.startAction(
        name: '_EncapsuleScaffoldStore.pushNotification');
    try {
      return super.pushNotification(item, _replacements);
    } finally {
      _$_EncapsuleScaffoldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dismissNotification(EncapsuleNotification item) {
    final _$actionInfo = _$_EncapsuleScaffoldStoreActionController.startAction(
        name: '_EncapsuleScaffoldStore.dismissNotification');
    try {
      return super.dismissNotification(item);
    } finally {
      _$_EncapsuleScaffoldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pushSheet(EncapsuleSheet item) {
    final _$actionInfo = _$_EncapsuleScaffoldStoreActionController.startAction(
        name: '_EncapsuleScaffoldStore.pushSheet');
    try {
      return super.pushSheet(item);
    } finally {
      _$_EncapsuleScaffoldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSheet(EncapsuleSheet item) {
    final _$actionInfo = _$_EncapsuleScaffoldStoreActionController.startAction(
        name: '_EncapsuleScaffoldStore.removeSheet');
    try {
      return super.removeSheet(item);
    } finally {
      _$_EncapsuleScaffoldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dismissNotificationsWhere(
      bool Function(EncapsuleNotification) conditional,
      {bool includeImportant = true}) {
    final _$actionInfo = _$_EncapsuleScaffoldStoreActionController.startAction(
        name: '_EncapsuleScaffoldStore.dismissNotificationsWhere');
    try {
      return super.dismissNotificationsWhere(conditional,
          includeImportant: includeImportant);
    } finally {
      _$_EncapsuleScaffoldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dismissAllNotifications({bool includingUndismissible = false}) {
    final _$actionInfo = _$_EncapsuleScaffoldStoreActionController.startAction(
        name: '_EncapsuleScaffoldStore.dismissAllNotifications');
    try {
      return super.dismissAllNotifications(
          includingUndismissible: includingUndismissible);
    } finally {
      _$_EncapsuleScaffoldStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
capsule: ${capsule},
sheet: ${sheet},
notification: ${notification}
    ''';
  }
}
