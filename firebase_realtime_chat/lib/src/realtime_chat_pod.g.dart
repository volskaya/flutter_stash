// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_chat_pod.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RealtimeChatPod<T extends RealtimeChatMessageImpl, D extends RealtimeChatParticipantImpl>
    on _RealtimeChatPod<T, D>, Store {
  final _$paginatedAtom = Atom(name: '_RealtimeChatPod.paginated');

  @override
  List<T> get paginated {
    _$paginatedAtom.reportRead();
    return super.paginated;
  }

  @override
  set paginated(List<T> value) {
    _$paginatedAtom.reportWrite(value, super.paginated, () {
      super.paginated = value;
    });
  }

  final _$subscribedAtom = Atom(name: '_RealtimeChatPod.subscribed');

  @override
  List<T> get subscribed {
    _$subscribedAtom.reportRead();
    return super.subscribed;
  }

  @override
  set subscribed(List<T> value) {
    _$subscribedAtom.reportWrite(value, super.subscribed, () {
      super.subscribed = value;
    });
  }

  final _$pendingAtom = Atom(name: '_RealtimeChatPod.pending');

  @override
  List<T> get pending {
    _$pendingAtom.reportRead();
    return super.pending;
  }

  @override
  set pending(List<T> value) {
    _$pendingAtom.reportWrite(value, super.pending, () {
      super.pending = value;
    });
  }

  final _$participantsAtom = Atom(name: '_RealtimeChatPod.participants');

  @override
  Set<String> get participants {
    _$participantsAtom.reportRead();
    return super.participants;
  }

  @override
  set participants(Set<String> value) {
    _$participantsAtom.reportWrite(value, super.participants, () {
      super.participants = value;
    });
  }

  final _$endedAtom = Atom(name: '_RealtimeChatPod.ended');

  @override
  bool get ended {
    _$endedAtom.reportRead();
    return super.ended;
  }

  @override
  set ended(bool value) {
    if (super.ended != value) {
      _$endedAtom.reportWrite(value, super.ended, () {
        super.ended = value;
      });
    }
  }

  final _$pageAtom = Atom(name: '_RealtimeChatPod.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    if (super.page != value) {
      _$pageAtom.reportWrite(value, super.page, () {
        super.page = value;
      });
    }
  }

  final _$_paginateAsyncAction = AsyncAction('_RealtimeChatPod._paginate');

  @override
  Future<dynamic> _paginate([int? timestamp]) {
    return _$_paginateAsyncAction.run(() => super._paginate(timestamp));
  }

  final _$_RealtimeChatPodActionController = ActionController(name: '_RealtimeChatPod');

  @override
  void movePendingItemsToSubscribedItems() {
    final _$actionInfo =
        _$_RealtimeChatPodActionController.startAction(name: '_RealtimeChatPod.movePendingItemsToSubscribedItems');
    try {
      return super.movePendingItemsToSubscribedItems();
    } finally {
      _$_RealtimeChatPodActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
paginated: ${paginated},
subscribed: ${subscribed},
pending: ${pending},
participants: ${participants},
ended: ${ended},
page: ${page}
    ''';
  }
}
