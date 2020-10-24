import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_realtime_chat/src/firebase_realtime_chat_impl.dart';
import 'package:firebase_realtime_chat/src/firebase_realtime_chat_mirror_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:log/log.dart';
import 'package:mobx/mobx.dart';
import 'package:quiver/strings.dart';
import 'package:refresh_storage/refresh_storage.dart';
import 'package:sembast/sembast.dart';

part 'firebase_realtime_chat.g.dart';

typedef FirebaseRealtimeChatMessageBuilder<T extends FirebaseRealtimeChatMessageImpl> = T Function(Map value);
typedef FirebaseRealtimeChatParticipantBuilder<T extends FirebaseRealtimeChatParticipantImpl> = T Function();

class _FirebaseRealtimeChatPageStorage<T extends FirebaseRealtimeChatMessageImpl> = __FirebaseRealtimeChatPageStorage<T>
    with _$_FirebaseRealtimeChatPageStorage<T>;

abstract class __FirebaseRealtimeChatPageStorage<T extends FirebaseRealtimeChatMessageImpl> with Store {
  final paginatedItems = ObservableList<T>();
  final subscribedItems = ObservableList<T>();
  final pendingItems = ObservableList<T>();

  @observable
  bool isEndReached = false;
  int page = 0;

  @observable
  Set<String> participants = const <String>{};
}

/// Firebase realtime chat list & ui builder, similar to FirestoreCollectionBuilder.
class FirebaseRealtimeChat<T extends FirebaseRealtimeChatMessageImpl,
    D extends FirebaseRealtimeChatParticipantImpl> = _FirebaseRealtimeChat<T, D> with _$FirebaseRealtimeChat<T, D>;

abstract class _FirebaseRealtimeChat<T extends FirebaseRealtimeChatMessageImpl,
    D extends FirebaseRealtimeChatParticipantImpl> with Store {
  _FirebaseRealtimeChat({
    @required this.collection,
    @required this.messageBuilder,
    @required this.participantBuilder,
    this.itemsPerPage = 20,
    Set<String> participants,
  }) : _participants = participants;

  /// Realtime database list this chat will target.
  final DatabaseReference collection;

  /// Message model builder with optional json.
  final FirebaseRealtimeChatMessageBuilder<T> messageBuilder;

  /// Participant model builder.
  final FirebaseRealtimeChatParticipantBuilder<D> participantBuilder;

  /// Number of item to paginate per page. Subscribed items will still fetch as much as possible.
  final int itemsPerPage;

  /// If the participant IDs are defined manually, there won't be any subscription observing
  /// user IDs in the database.
  final Set<String> _participants;
  Set<String> get participants => _storage?.participants ?? const <String>{};

  static final _log = Log.named('FirebaseRealtimeChat');

  DatabaseReference get chatReference => collection.child(chatId);
  DatabaseReference get participantsCollection => chatReference.child('participants');
  DatabaseReference get participantListCollection => chatReference.child('participantIds');
  DatabaseReference get messageCollection => chatReference.child('messages');

  // Assigned in `initialize`.
  String senderId;
  String chatId;

  _FirebaseRealtimeChatPageStorage<T> _storage;
  D _lastPresence;
  StreamSubscription<Event> _onAddedSubscription;
  StreamSubscription<Event> _onDisconnectReaction;
  StreamSubscription<Event> _participantsSubscription;
  DateTime subscriptionTime;

  final scrollController = ScrollController();
  final _seenItems = <String>{};
  ObservableList<T> get paginatedItems => _storage.paginatedItems;
  ObservableList<T> get subscribedItems => _storage.subscribedItems;
  ObservableList<T> get pendingItems => _storage.pendingItems;
  bool _fetchingPage = false;

  bool get _isSubscribed => _onAddedSubscription != null;
  int get page => _storage.page;
  set page(int val) => _storage.page = val;
  bool get isEndReached => _storage.isEndReached;
  set isEndReached(bool val) => _storage.isEndReached = val;
  DateTime pageTimestamp = DateTime.now();
  bool _disposed = false;
  int get length => subscribedItems.length + paginatedItems.length;

  bool get _isScrolled {
    assert(scrollController.hasClients);
    return scrollController.offset > 0;
  }

  /// Uses cursor only from the nearest online confirmed document.
  /// Pagination timestamps don't care about the online confirmation.
  int get _paginationTimestamp =>
      paginatedItems.reversed.firstWhere((item) => item.createTime != null, orElse: () => null)?.createTime;

  /// Uses cursor only from the nearest online confirmed document
  int get _subscriptionTimestamp => paginatedItems
      .firstWhere((item) => (item.online || item.readBy.isNotEmpty) && item.createTime != null, orElse: () => null)
      ?.createTime;

  /// Call pagination on either the last item or 1 page in advance
  bool shouldPaginate(int paginatedItemIndex) =>
      paginatedItemIndex == paginatedItems.length - 1 || paginatedItemIndex == paginatedItems.length - itemsPerPage;

  /// Get an item by its N index across both `subscribedItems` & `paginatedItems`
  T getItem(int index) =>
      index > (subscribedItems.length - 1) ? paginatedItems[index - subscribedItems.length] : subscribedItems[index];

  Future fetchPage(int page, [int timestamp]) async {
    // This method is called by lists, that use this chat class.
    // The pagination, without `timestamp`, can only be called, when
    // pagination already holds results, and when thats true,
    // `_paginationTimestamp` will be available too
    assert(paginatedItems.isNotEmpty || timestamp != null);

    if (_fetchingPage) return;
    _fetchingPage = true;

    if (page <= this.page || _storage.isEndReached) {
      _log.d('Skipping redundant pagination for page: $page');
      return;
    }

    try {
      await _paginate(timestamp);
    } catch (e) {
      _log.e(e);
    } finally {
      _fetchingPage = false;
    }

    assert(page == this.page); // Double check page numbers
  }

  Future _paginate(int timestamp) async {
    final oldestTimestamp = _paginationTimestamp ?? timestamp;
    _log.v('Paginating page ${page + 1}, startingAt $oldestTimestamp');

    // Prefer offline over online
    FirebaseRealtimeChatMessageSource usedSource;
    var messages = <T>[];
    var items = const <String, dynamic>{};

    // Initially try to paginate from the offline storage
    final offlineSnapshots = await FirebaseRealtimeChatMirrorStorage.instance.find(
      messageCollection.path,
      Finder(
        filter: Filter.lessThan('createTime', oldestTimestamp),
        sortOrders: [SortOrder('createTime', false)],
        limit: itemsPerPage,
      ),
    );

    if (offlineSnapshots.isNotEmpty) {
      usedSource = FirebaseRealtimeChatMessageSource.mirrorStorage;
      _log.wtf('Got ${offlineSnapshots.length} items from offline storage');

      // If offlineSnapshots are not empty, map them to items
      items = Map<String, dynamic>.fromEntries(
        offlineSnapshots.map(
          (record) => MapEntry<String, dynamic>(record.key, record.value),
        ),
      );
    } else {
      // If offline storage have no items, fall back to realtime db
      usedSource = FirebaseRealtimeChatMessageSource.realtimeDatabase;
      final query = messageCollection.orderByChild('createTime').limitToLast(itemsPerPage).endAt(oldestTimestamp - 1);
      _log.wtf('No offline items, fetching from realtime db');

      try {
        final onlineSnapshots = await query.once();
        if (onlineSnapshots.value != null) {
          items = Map<String, dynamic>.from(onlineSnapshots.value as Map);
        }
      } catch (e) {
        _log.e(e);
      }
    }

    try {
      messages = items.entries.where((entry) {
        final isSeen = _seenItems.contains(entry.key);
        if (isSeen) _log.w('${chatReference.path} paginated a redundant item: ${entry.key}');
        return !isSeen;
      }).map((entry) {
        _seenItems.add(entry.key);

        // HACK: Forges a [DataSnapshot] with a custom patch.
        final snapshot = DataSnapshot.fake(entry.key, entry.value as Map);
        final message = messageBuilder(entry.value as Map)
          ..reference = messageCollection.child(entry.key)
          ..snapshot = snapshot
          ..list = FirebaseRealtimeChatMessageList.paginated
          ..source = usedSource;

        if (message.source == FirebaseRealtimeChatMessageSource.realtimeDatabase) message.updateMirror();
        return message;
      }).toList(growable: false)
        // NOTE: Firebase query returns the documents unordered.
        ..sort((a, b) => b.createTime.compareTo(a.createTime));
    } catch (e) {
      _log.e(e);
    }

    // Assert order is correct, by making sure document timestamps
    // are ordered newest to oldest.
    assert((() {
      if (messages.length <= 1) return true; // Not enough items.
      var timestamp = messages.first.createTime;
      for (final message in messages.skip(1)) {
        if (message.createTime > timestamp) return false; // Next timestamp is later than current message.
        timestamp = message.createTime;
      }
      return true;
    })());

    _log.d('Paginated ${messages.length} items');

    switch (usedSource) {
      case FirebaseRealtimeChatMessageSource.realtimeDatabase:
        if (messages.length < itemsPerPage) {
          _log.v('Collection end reached');
          isEndReached = true;
        }
        break;
      default:
      // Do nothing
    }

    paginatedItems.addAll(messages);
    page += 1;
    pageTimestamp = DateTime.now();
  }

  void _startSubscription({int timestamp}) {
    assert(!_isSubscribed);
    assert(timestamp != null || paginatedItems.isEmpty, 'Paginated items are not empty, use a timestamp from it');

    var query = messageCollection.orderByChild('createTime');

    // If timestamp exists,
    if (timestamp != null) {
      _log.v('Subscribing with a timestamp @ $timestamp');
      query = query.startAt(timestamp + 1, key: 'createTime');
    } else {
      _log.v('Subscribing with no timestamp');
    }

    _onAddedSubscription = query.onChildAdded.listen(
      (child) {
        _log.wtf('New subscribed message: $child - ${child.snapshot.value}');

        // This shouldn't normally happen
        if (_seenItems.contains(child.snapshot.key)) {
          _log.e(' - Key ${child.snapshot.key} has already been added');
          return;
        }

        // When the list is scrolled, new items are pushed to pending items
        final list = _isScrolled ? FirebaseRealtimeChatMessageList.pending : FirebaseRealtimeChatMessageList.subscribed;
        final targetList = _isScrolled ? pendingItems : subscribedItems;
        _seenItems.add(child.snapshot.key);
        targetList.add(
          messageBuilder(child.snapshot.value as Map)
            ..reference = messageCollection.child(child.snapshot.key)
            ..snapshot = child.snapshot
            ..list = list
            ..updateMirror(),
        );
      },
    );
  }

  Future _disposeSubscription() async {
    await _onAddedSubscription?.cancel();
    _onAddedSubscription = null;
  }

  /// When device resumes from sleep or reconnects to the network,
  /// you're expected to redo `_startParticipating`
  Future _startParticipating() async {
    assert(!_disposed);

    // NOTE: At the moment, rules enforce having an existing presence,
    // to be allowed to read message documents
    await reportPresence(online: true);

    // Don't subscribe to the participant ID list, if the IDs were passed manually.
    if (_participants == null) {
      _participantsSubscription?.cancel();
      _participantsSubscription = participantListCollection.onValue.listen(
          (event) => _storage.participants = Set<String>.from(event.snapshot.value as List ?? const <String>[]));
    } else {
      assert(_storage.participants == _participants);
    }
  }

  void _handleScroll() {
    assert(scrollController.hasClients);
    if (!_isScrolled) movePendingItemsToSubscribedItems();
  }

  @action
  void movePendingItemsToSubscribedItems() {
    if (pendingItems.isNotEmpty) {
      subscribedItems.addAll(pendingItems);
      pendingItems.clear();
    }
  }

  Future reportPresence({bool online = true, bool writing = false}) async {
    // If reporting presence, add an `onDisconnect` reaction, to clean
    // this up, if the database loses connection with the client
    if (_onDisconnectReaction == null) {
      _log.v('Registering an `onDisconnect` reaction, to reset senders participant data');
      _onDisconnectReaction = FirebaseDatabase.instance.reference().child('.info/connected').onValue.listen(
        (event) async {
          // Not connected.
          if (event.snapshot.value != true) return;

          try {
            // Auto notify of user being in the chat.
            await participantsCollection.child(senderId).update(<String, dynamic>{
              'online': true,
              'writing': false,
              'updateTime': ServerValue.timestamp,
            });
          } on PlatformException catch (e) {
            _log.e(e);
          }

          try {
            // Register a database disconnect event, for when the user loses connection.
            await participantsCollection.child(senderId).onDisconnect().update(<String, dynamic>{
              'online': false,
              'writing': false,
              'updateTime': ServerValue.timestamp,
            });
          } on PlatformException catch (e) {
            _log.e(e);
          }
        },
      );
    }

    final presence = participantBuilder()
      ..online = online
      ..writing = writing;
    if (_lastPresence?.online != presence.online || _lastPresence?.writing != presence.writing) {
      _lastPresence = presence;

      try {
        await participantsCollection.child(senderId).update(<String, dynamic>{
          ...Map<String, dynamic>.from(presence.toJson()),
          'updateTime': ServerValue.timestamp,
        });
      } on PlatformException catch (e) {
        _log.e(e);
      }
    }
  }

  /// Sets up page storage and also reuses its items, if it had any
  void _setupPageStorage(BuildContext context) {
    _storage = RefreshStorage.write<_FirebaseRealtimeChatPageStorage<T>>(
      context: context,
      identifier: 'realtime_chat_${chatId}_$senderId',
      builder: () => _FirebaseRealtimeChatPageStorage<T>(),
    );

    // Participant list provided manually.
    if (_participants != null) _storage.participants = _participants;

    // First reuse pending items
    if (pendingItems.isNotEmpty) {
      subscribedItems.addAll(pendingItems);
      pendingItems.clear();
    }

    // When rebuilding the list, move all subscribed items to paginated items
    if (subscribedItems.isNotEmpty) {
      paginatedItems.insertAll(
        0,
        subscribedItems.reversed.where((message) => message.createTime != null).toList(growable: false)
          ..sort((a, b) => b.createTime.compareTo(a.createTime)),
      );

      subscribedItems.clear();
    }

    if (paginatedItems.isNotEmpty) {
      _log.d('Reused ${paginatedItems.length} from page storage');

      // Sort only subscribed items. Paginated items are sorted as they come in.
      // I had some last minunte bugs up there, so put the sort here, for now
      // paginatedItems.sort((a, b) => b.createTime.compareTo(a.createTime));

      var index = 0;
      for (final message in paginatedItems) {
        _log.v('[$index] timestamp: ${message.createTime}');
        index += 1;
      }

      // Assert order is correct, by making sure document timestamps
      // are ordered newest to oldest
      assert((() {
        if (paginatedItems.length <= 1) {
          return true; // Not enough items
        }
        var timestamp = paginatedItems.first.createTime;
        for (final message in paginatedItems.skip(1)) {
          if (message.createTime > timestamp) {
            return false; // Next timestamp is later than current message
          }
          timestamp = message.createTime;
        }
        return true;
      })());
    }
  }

  void initialize({
    @required BuildContext context,
    @required String senderId,
    @required String chatId,
  }) {
    assert(!_disposed);
    assert(isNotEmpty(senderId));
    assert(isNotEmpty(chatId));
    assert(FirebaseRealtimeChatMirrorStorage.instance.initialized);

    this.senderId = senderId;
    this.chatId = chatId;
    _setupPageStorage(context);

    _log.wtf('Initializing with user: $senderId, chat $chatId');
    scrollController.addListener(_handleScroll);
    _startListening();
  }

  Future _startListening() async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;

    // First page will always attempt to fetch from offline.
    // If offline storage has items, use their newest timestamp
    // to fetch any missed messages.
    if (paginatedItems.isEmpty) await fetchPage(1, now);
    if (_disposed) return;

    // Try to reacquire subscription timestamp, if offline pagination returned results.
    final timestamp = _subscriptionTimestamp ?? now;
    subscriptionTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    _startSubscription(timestamp: timestamp);
    if (paginatedItems.isEmpty) await fetchPage(1, timestamp);
    if (!_disposed) await _startParticipating();
  }

  void dispose() {
    assert(!_disposed);
    _disposed = true;
    scrollController.removeListener(_handleScroll);
    _onDisconnectReaction?.cancel();
    _disposeSubscription();
    _participantsSubscription?.cancel();

    // Send last presence, indicating the user is offline.
    reportPresence(writing: false, online: false);
  }

  void handleAppLifecycleStatus(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _startSubscription(timestamp: _subscriptionTimestamp ?? DateTime.now().toUtc().millisecondsSinceEpoch);
        _startParticipating();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _disposeSubscription();
        reportPresence(writing: false, online: false);
        _onDisconnectReaction?.cancel();
        _onDisconnectReaction = null;
        _participantsSubscription?.cancel();
        _participantsSubscription = null;
        break;
    }
  }
}
