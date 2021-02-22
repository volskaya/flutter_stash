// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_realtime_chat.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$_FirebaseRealtimeChatPageStorage<
        T extends FirebaseRealtimeChatMessageImpl>
    on __FirebaseRealtimeChatPageStorage<T>, Store {
  final _$paginatedItemsAtom =
      Atom(name: '__FirebaseRealtimeChatPageStorage.paginatedItems');

  @override
  IList<T> get paginatedItems {
    _$paginatedItemsAtom.reportRead();
    return super.paginatedItems;
  }

  @override
  set paginatedItems(IList<T> value) {
    if (super.paginatedItems != value) {
      _$paginatedItemsAtom.reportWrite(value, super.paginatedItems, () {
        super.paginatedItems = value;
      });
    }
  }

  final _$subscribedItemsAtom =
      Atom(name: '__FirebaseRealtimeChatPageStorage.subscribedItems');

  @override
  IList<T> get subscribedItems {
    _$subscribedItemsAtom.reportRead();
    return super.subscribedItems;
  }

  @override
  set subscribedItems(IList<T> value) {
    if (super.subscribedItems != value) {
      _$subscribedItemsAtom.reportWrite(value, super.subscribedItems, () {
        super.subscribedItems = value;
      });
    }
  }

  final _$pendingItemsAtom =
      Atom(name: '__FirebaseRealtimeChatPageStorage.pendingItems');

  @override
  IList<T> get pendingItems {
    _$pendingItemsAtom.reportRead();
    return super.pendingItems;
  }

  @override
  set pendingItems(IList<T> value) {
    if (super.pendingItems != value) {
      _$pendingItemsAtom.reportWrite(value, super.pendingItems, () {
        super.pendingItems = value;
      });
    }
  }

  final _$isEndReachedAtom =
      Atom(name: '__FirebaseRealtimeChatPageStorage.isEndReached');

  @override
  bool get isEndReached {
    _$isEndReachedAtom.reportRead();
    return super.isEndReached;
  }

  @override
  set isEndReached(bool value) {
    if (super.isEndReached != value) {
      _$isEndReachedAtom.reportWrite(value, super.isEndReached, () {
        super.isEndReached = value;
      });
    }
  }

  final _$participantsAtom =
      Atom(name: '__FirebaseRealtimeChatPageStorage.participants');

  @override
  Set<String> get participants {
    _$participantsAtom.reportRead();
    return super.participants;
  }

  @override
  set participants(Set<String> value) {
    if (super.participants != value) {
      _$participantsAtom.reportWrite(value, super.participants, () {
        super.participants = value;
      });
    }
  }

  @override
  String toString() {
    return '''
paginatedItems: ${paginatedItems},
subscribedItems: ${subscribedItems},
pendingItems: ${pendingItems},
isEndReached: ${isEndReached},
participants: ${participants}
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
  void _setupPageStorage(BuildContext context) {
    final _$actionInfo = _$_FirebaseRealtimeChatActionController.startAction(
        name: '_FirebaseRealtimeChat._setupPageStorage');
    try {
      return super._setupPageStorage(context);
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
