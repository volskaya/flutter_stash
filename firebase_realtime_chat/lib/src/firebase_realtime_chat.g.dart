// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_realtime_chat.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$_FirebaseRealtimeChatPageStorage<
        T extends FirebaseRealtimeChatMessageImpl>
    on __FirebaseRealtimeChatPageStorage<T>, Store {
  final _$isEndReachedAtom =
      Atom(name: '__FirebaseRealtimeChatPageStorage.isEndReached');

  @override
  bool get isEndReached {
    _$isEndReachedAtom.reportRead();
    return super.isEndReached;
  }

  @override
  set isEndReached(bool value) {
    _$isEndReachedAtom.reportWrite(value, super.isEndReached, () {
      super.isEndReached = value;
    });
  }

  @override
  String toString() {
    return '''
isEndReached: ${isEndReached}
    ''';
  }
}

mixin _$FirebaseRealtimeChat<T extends FirebaseRealtimeChatMessageImpl,
        D extends FirebaseRealtimeChatParticipantImpl>
    on _FirebaseRealtimeChat<T, D>, Store {
  final _$_FirebaseRealtimeChatActionController =
      ActionController(name: '_FirebaseRealtimeChat');

  @override
  void movePendingItemsToSubscribedItems() {
    final _$actionInfo = _$_FirebaseRealtimeChatActionController.startAction(
        name: '_FirebaseRealtimeChat.movePendingItemsToSubscribedItems');
    try {
      return super.movePendingItemsToSubscribedItems();
    } finally {
      _$_FirebaseRealtimeChatActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
