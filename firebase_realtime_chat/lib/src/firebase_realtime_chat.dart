import 'dart:async';
import 'dart:collection';

import 'package:await_route/await_route.dart';
import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_realtime_chat/src/firebase_realtime_chat_impl.dart';
import 'package:firebase_realtime_chat/src/firebase_realtime_chat_mirror_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:loader_coordinator/loader_coordinator.dart';
import 'package:log/log.dart';
import 'package:mobx/mobx.dart';
import 'package:quiver/strings.dart';
import 'package:refresh_storage/refresh_storage.dart';
import 'package:sembast/sembast.dart';

import 'firebase_realtime_chat_builder.dart';

part 'firebase_realtime_chat.g.dart';

/// [FirebaseRealtimeChat]'s message model's factory.
typedef FirebaseRealtimeChatMessageBuilder<T extends FirebaseRealtimeChatMessageImpl> = T Function(Map value);

/// [FirebaseRealtimeChat]'s participant model's factory.
typedef FirebaseRealtimeChatParticipantBuilder<T extends FirebaseRealtimeChatParticipantImpl> = T Function();

class _FirebaseRealtimeChatPageStorage<T extends FirebaseRealtimeChatMessageImpl> = __FirebaseRealtimeChatPageStorage<T>
    with _$_FirebaseRealtimeChatPageStorage<T>;

abstract class __FirebaseRealtimeChatPageStorage<T extends FirebaseRealtimeChatMessageImpl> extends RefreshStorageItem
    with Store {
  final _seenItems = <String>{};

  @o IList<T> paginatedItems = IList<T>();
  @o IList<T> subscribedItems = IList<T>();
  @o IList<T> pendingItems = IList<T>();
  @o bool isEndReached = false;
  @o Set<String> participants = const <String>{};

  FirebaseRealtimeChatMirrorStorage? mirrorStorage;
  int page = 0;

  @override
  void dispose([dynamic _]) {
    super.dispose(_);
    mirrorStorage?.dispose();
    mirrorStorage = null;
  }
}

/// Firebase realtime chat list & ui builder, similar to FirestoreCollectionBuilder.
class FirebaseRealtimeChat<T extends FirebaseRealtimeChatMessageImpl,
    D extends FirebaseRealtimeChatParticipantImpl> = _FirebaseRealtimeChat<T, D> with _$FirebaseRealtimeChat<T, D>;

abstract class _FirebaseRealtimeChat<T extends FirebaseRealtimeChatMessageImpl,
    D extends FirebaseRealtimeChatParticipantImpl> with Store {
  _FirebaseRealtimeChat({
    required this.collection,
    required this.messageBuilder,
    required this.participantBuilder,
    this.itemsPerPage = 20,
    this.onFirstPagePaginated,
    this.awaitRoute = false,
    Set<String>? participants,
    FirebaseDatabase? firebaseDatabase,
  })  : _participants = participants,
        firebaseDatabase = firebaseDatabase ?? FirebaseDatabase.instance;

  /// Realtime database list this chat will target.
  final DatabaseReference collection;

  /// Message model builder with optional json.
  final FirebaseRealtimeChatMessageBuilder<T> messageBuilder;

  /// Participant model builder.
  final FirebaseRealtimeChatParticipantBuilder<D> participantBuilder;

  /// Number of item to paginate per page. Subscribed items will still fetch as much as possible.
  final int itemsPerPage;

  /// Called after the first page has paginated.
  final FirebaseRealtimeChatEventCallback<T, D>? onFirstPagePaginated;

  /// Whether to await route before updating state with first page's items.
  ///
  /// NOTE: The items will still start being fetched when the widget first mounts, only
  /// the o state will be delayed. This is usually used to avoid yank mid route
  /// change animations.
  final bool awaitRoute;

  /// Firebase database to use with chat. This must be provided in cases, when
  /// the project's RTDB is not located in the default US region.
  ///
  /// When it's not in the default US region, the [FirebaseDatabase.instance] won't
  /// automatically read the url from google-services file.
  final FirebaseDatabase firebaseDatabase;

  /// If the participant IDs are defined manually, there won't be any subscription observing
  /// user IDs in the database.
  final Set<String>? _participants;
  Set<String> get participants => _storage.value?.participants ?? const <String>{};

  static final _log = Log.named('FirebaseRealtimeChat');

  DatabaseReference get chatReference => collection.child(chatId);
  DatabaseReference get participantsCollection => chatReference.child('participants');
  DatabaseReference get participantListCollection => chatReference.child('whitelist');
  DatabaseReference get messageCollection => chatReference.child('messages');

  // Assigned in `initialize`.
  late final String senderId;
  late final String chatId;

  late final RefreshStorageEntry<_FirebaseRealtimeChatPageStorage<T>> _storage;
  D? _lastPresence;
  StreamSubscription<Event>? _onAddedSubscription;
  StreamSubscription<Event>? _onDisconnectReaction;
  StreamSubscription<Event>? _participantsSubscription;

  final scrollController = ScrollController();
  Set<String> get _seenItems => _storage.value?._seenItems ?? const <String>{};
  IList<T> get paginatedItems => _storage.value?.paginatedItems ?? IList<T>();
  IList<T> get subscribedItems => _storage.value?.subscribedItems ?? IList<T>();
  IList<T> get pendingItems => _storage.value?.pendingItems ?? IList<T>();
  set paginatedItems(IList<T> val) => _storage.value?.paginatedItems = val;
  set subscribedItems(IList<T> val) => _storage.value?.subscribedItems = val;
  set pendingItems(IList<T> val) => _storage.value?.pendingItems = val;
  bool _fetchingPage = false;

  bool get _isSubscribed => _onAddedSubscription != null;
  int get page => _storage.value?.page ?? 0;
  set page(int val) => _storage.value?.page = val;
  bool get isEndReached => _storage.value?.isEndReached ?? false;
  set isEndReached(bool val) => _storage.value?.isEndReached = val;
  DateTime pageTimestamp = DateTime.now();
  bool _disposed = false;
  int get length => subscribedItems.length + paginatedItems.length;
  DisposableBuildContext? disposableBuildContext;

  bool get _isScrolled {
    assert(scrollController.hasClients);
    return scrollController.offset > 0;
  }

  /// Uses cursor only from the nearest online confirmed document.
  /// Pagination timestamps don't care about the online confirmation.
  int? get _paginationTimestamp =>
      paginatedItems.reversed.firstWhereOrNull((item) => item.createTime != null)?.createTime;

  /// Uses cursor only from the nearest online confirmed document.
  int? get _subscriptionTimestamp => pendingItems.reversed
      .followedBy(subscribedItems.reversed)
      .followedBy(paginatedItems)
      .firstWhereOrNull((item) => item.isServerTimestamp && item.createTime != null)
      ?.createTime;

  /// Start calling paginators with all items on the last page.
  /// Make sure the redundant calls are dropped though.
  bool shouldPaginate(int paginatedItemIndex) => paginatedItemIndex > (paginatedItems.length - itemsPerPage);

  /// Get the paginator callback for a paginated documents widget, according to its index within a list.
  VoidCallback? getPaginator(int paginatedItemIndex) =>
      shouldPaginate(paginatedItemIndex) ? () => fetchPage(page + 1) : null;

  /// Get an item by its N index across both `subscribedItems` & `paginatedItems`.
  T getItem(int index) =>
      index > (subscribedItems.length - 1) ? paginatedItems[index - subscribedItems.length] : subscribedItems[index];

  Future fetchPage(int page, [int? timestamp]) async {
    assert(_storage.value?.mirrorStorage != null);

    // This method is called by lists, that use this chat class.
    // The pagination, without `timestamp`, can only be called, when
    // pagination already holds results, and when thats true,
    // `_paginationTimestamp` will be available too.
    // assert(paginatedItems.isNotEmpty || timestamp != null);

    if (_fetchingPage || page <= this.page || isEndReached) return;
    _fetchingPage = true;
    final loader = LoaderCoordinator.instance.touch();

    try {
      await _paginate(timestamp);
    } catch (e, t) {
      _log.e('Failed to paginate ${chatReference.path} page ${page + 1}', e, t);
    } finally {
      _fetchingPage = false;
      loader.dispose();
    }

    assert(page == this.page); // Double check page numbers.
  }

  /// NOTE: `_paginationTimestamp` will have priority over `timestamp`.
  Future _paginate([int? timestamp]) async {
    assert(_storage.value?.mirrorStorage != null);

    final isFirstPage = page == 0;
    final oldestTimestamp = _paginationTimestamp ?? timestamp;
    _log.v('Paginating page ${page + 1}, startingAt: ${oldestTimestamp ?? "First item"}');

    // Prefer offline over online.
    FirebaseRealtimeChatMessageSource usedSource;
    var messages = <T>[];
    var items = const <String, dynamic>{};

    // Initially try to paginate from the offline storage.
    //
    // A mirror storage is initialized per each chat room, before the pagination starts,
    // so this should be ready.
    final offlineSnapshots = await _storage.value?.mirrorStorage?.find(
      messageCollection.path,
      oldestTimestamp != null
          ? Finder(
              filter: Filter.lessThan('createTime', oldestTimestamp),
              sortOrders: [SortOrder('createTime', false)],
              limit: itemsPerPage,
            )
          : Finder(
              sortOrders: [SortOrder('createTime', false)],
              limit: itemsPerPage,
            ),
    );

    if (offlineSnapshots?.isNotEmpty == true) {
      usedSource = FirebaseRealtimeChatMessageSource.mirrorStorage;
      _log.wtf('Got ${offlineSnapshots!.length} items from offline storage');

      // If offlineSnapshots are not empty, map them to items.
      items = HashMap<String, dynamic>.fromEntries(
        offlineSnapshots.map(
          (record) => MapEntry<String, dynamic>(record.key, record.value),
        ),
      );
    } else {
      // If offline storage have no items, fall back to realtime db.
      usedSource = FirebaseRealtimeChatMessageSource.realtimeDatabase;
      var query = messageCollection.orderByChild('createTime').limitToLast(itemsPerPage);
      if (oldestTimestamp != null) query = query.endAt(oldestTimestamp - 1);
      _log.wtf('No offline items, fetching from realtime db');

      try {
        final onlineSnapshots = await query.once();
        if (onlineSnapshots.value != null) {
          items = HashMap<String, dynamic>.from(onlineSnapshots.value as Map);
        }
      } catch (e, t) {
        _log.e('Failed to query online snapshots of ${chatReference.path} page ${page + 1}', e, t);
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
        ..sort((a, b) => b.createTime!.compareTo(a.createTime!)); // NOTE: Firebase DB returns the documents unordered.
    } catch (e, t) {
      _log.e('Failed to build models of paginated messages for ${chatReference.path} page ${page + 1}', e, t);
    }

    // Assert order is correct, by making sure document timestamps
    // are ordered newest to oldest.
    assert((() {
      if (messages.length <= 1) return true; // Not enough items.
      var timestamp = messages.first.createTime;
      for (final message in messages.skip(1)) {
        if (message.createTime! > timestamp!) return false; // Next timestamp is later than current message.
        timestamp = message.createTime;
      }
      return true;
    })());

    _log.d('Paginated ${messages.length} items');

    switch (usedSource) {
      case FirebaseRealtimeChatMessageSource.realtimeDatabase:
        if (messages.length < itemsPerPage) {
          _log.d('Collection end reached');
          isEndReached = true;
        }
        break;
      default:
      // Do nothing.
    }

    try {
      if (isFirstPage && awaitRoute && disposableBuildContext?.context != null) {
        await AwaitRoute.of(disposableBuildContext!.context!);
        if (_disposed) return;
      }
    } finally {
      paginatedItems = paginatedItems.addAll(messages);
      page += 1;
      pageTimestamp = DateTime.now();

      if (isFirstPage && !_disposed && onFirstPagePaginated != null) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          if (!_disposed) onFirstPagePaginated?.call(this as FirebaseRealtimeChat<T, D>);
        });
      }
    }
  }

  void _startSubscription({int? timestamp}) {
    assert(!_isSubscribed);
    assert(timestamp != null || paginatedItems.isEmpty, 'Paginated items are not empty, use a timestamp from it');

    var query = messageCollection.orderByChild('createTime');

    // If timestamp exists.
    if (timestamp != null) {
      _log.d('Subscribing with a timestamp @ $timestamp');
      query = query.startAt(timestamp + 1, key: 'createTime');
    } else {
      _log.d('Subscribing with no timestamp');
    }

    _onAddedSubscription = query.onChildAdded.listen(
      (child) {
        // This shouldn't normally happen.
        if (_seenItems.contains(child.snapshot.key)) {
          _log.d('${child.snapshot.key} has already been added, skipping…');
          return;
        }

        if (child.snapshot.key == null) return;

        _log.d('New subscribed message $child');

        final list = _isScrolled ? FirebaseRealtimeChatMessageList.pending : FirebaseRealtimeChatMessageList.subscribed;
        final message = messageBuilder(child.snapshot.value as Map)
          ..reference = messageCollection.child(child.snapshot.key!)
          ..snapshot = child.snapshot
          ..list = list
          ..updateMirror();

        // When the list is scrolled, new items are pushed to pending items.
        _seenItems.add(child.snapshot.key!);
        if (_isScrolled) {
          pendingItems = pendingItems.add(message);
        } else {
          subscribedItems = subscribedItems.add(message);
        }
      },
    );
  }

  Future _disposeSubscription() async {
    _onAddedSubscription?.cancel();
    _onAddedSubscription = null;
  }

  /// When device resumes from sleep or reconnects to the network,
  /// you're expected to redo `_startParticipating`.
  Future _startParticipating() async {
    assert(!_disposed);

    // NOTE: At the moment, rules enforce having an existing presence, to be allowed to read message documents.
    await reportPresence(online: true);

    // Don't subscribe to the participant ID list, if the IDs were passed manually.
    if (_participants == null) {
      _participantsSubscription?.cancel();
      _participantsSubscription = participantListCollection.onValue.listen((event) =>
          _storage.value?.participants = Set<String>.from((event.snapshot.value as Map?)?.keys ?? const <String>[]));
    } else {
      assert(_storage.value?.participants == _participants);
    }
  }

  void _handleScroll() {
    assert(scrollController.hasClients);
    if (!_isScrolled) movePendingItemsToSubscribedItems();
  }

  @action
  void movePendingItemsToSubscribedItems() {
    if (pendingItems.isNotEmpty) {
      subscribedItems = subscribedItems.addAll(pendingItems);
      pendingItems = pendingItems.clear();
    }
  }

  Future reportPresence({bool online = true, bool writing = false}) async {
    final sendersParticipantRef = participantsCollection.child(senderId);

    // If reporting presence, add an `onDisconnect` reaction, to clean
    // this up, if the database loses connection with the client.
    if (_onDisconnectReaction == null) {
      _log.v('Registering an `onDisconnect` reaction, to reset senders participant data');
      _onDisconnectReaction = firebaseDatabase.reference().child('.info/connected').onValue.listen(
        (event) async {
          if (event.snapshot.value != true) return; // Not connected.

          try {
            // Auto notify of user being in the chat.
            await sendersParticipantRef.update(<String, dynamic>{'online': true, 'writing': false});
          } on PlatformException catch (e, t) {
            _log.e('Failed to notify ${sendersParticipantRef.path} of being online', e, t);
          }

          try {
            // Register a database disconnect event, for when the user loses connection.
            await sendersParticipantRef.onDisconnect().update(<String, dynamic>{'online': false, 'writing': false});
          } on PlatformException catch (e, t) {
            _log.e('Failed to add a disconnect callback for ${sendersParticipantRef.path} ', e, t);
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
        await sendersParticipantRef.update(<String, dynamic>{
          ...HashMap<String, dynamic>.from(presence.toJson()),
        });
      } on PlatformException catch (e, t) {
        _log.e('Failed to to report presence for ${sendersParticipantRef.path} ', e, t);
      }
    }
  }

  /// Sets up page storage and also reuses its items, if it had any.
  @action
  void _setupPageStorage(BuildContext context) {
    _storage = RefreshStorage.write<_FirebaseRealtimeChatPageStorage<T>>(
      context: context,
      identifier: 'realtime_chat_${chatId}_$senderId',
      builder: () => _FirebaseRealtimeChatPageStorage<T>(),
    );

    // Participant list provided manually.
    if (_participants != null) _storage.value?.participants = _participants!;

    if (pendingItems.isNotEmpty || subscribedItems.isNotEmpty) {
      paginatedItems = paginatedItems.insertAll(0, pendingItems.reversed.followedBy(subscribedItems.reversed));
      subscribedItems = subscribedItems.clear();
      pendingItems = pendingItems.clear();
    }

    if (paginatedItems.isNotEmpty) {
      _log.v('Reused ${paginatedItems.length} ${messageCollection.path} messages from page storage');

      // Assert order is correct, by making sure document timestamps
      // are ordered newest to oldest.
      assert((() {
        if (paginatedItems.length <= 1) return true; // Not enough items.
        var timestamp = paginatedItems.first.createTime;
        for (final message in paginatedItems.skip(1)) {
          if (message.createTime! > timestamp!) return false; // Next timestamp is later than current message.
          timestamp = message.createTime;
        }
        return true;
      })());
    }
  }

  void initialize({
    required DisposableBuildContext context,
    required String senderId,
    required String chatId,
  }) {
    assert(!_disposed);
    assert(isNotEmpty(senderId));
    assert(isNotEmpty(chatId));
    assert(context.context != null);

    this.senderId = senderId;
    this.chatId = chatId;
    disposableBuildContext = context;
    _setupPageStorage(disposableBuildContext!.context!);

    _log.v('Initializing ${chatReference.path} with user: $senderId, chat $chatId');
    scrollController.addListener(_handleScroll);
    _startListening();
  }

  Future _initializeMirror() async {
    // First prepare the mirror storage for offline documents.
    final mirrorStorage = await FirebaseRealtimeChatMirrorStorage.initialize(chatReference);
    if (!_disposed) {
      _storage.value?.mirrorStorage = mirrorStorage;
    } else {
      await mirrorStorage.dispose();
    }
  }

  Future _startListening() async {
    await _initializeMirror();
    if (_disposed) return;

    // First page will always attempt to fetch from offline.
    // If offline storage has items, use their newest timestamp
    // to fetch any missed messages.
    //
    // Make sure this initial pagination doesn't fail on network outage or
    // the subscription could put the whole cache in an inconsistent state,
    // if it subs to newer messages and leave a gap between oldest subbed
    // message and the newest paginated.
    if (paginatedItems.isEmpty) await fetchPage(1);
    if (_disposed) return;

    _startSubscription(timestamp: _subscriptionTimestamp);
    await _startParticipating();
  }

  void dispose() {
    assert(!_disposed);
    _disposed = true;
    scrollController.removeListener(_handleScroll);
    _onDisconnectReaction?.cancel();
    _disposeSubscription();
    _participantsSubscription?.cancel();
    _storage.dispose();
    disposableBuildContext = null;

    // Send last presence, indicating the user is offline.
    reportPresence(writing: false, online: false);
  }

  bool? _lifecycleToggled;
  void handleAppLifecycleStatus(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        if (_lifecycleToggled == true) break;
        _lifecycleToggled = true;
        if (!_isSubscribed) _startSubscription(timestamp: _subscriptionTimestamp);
        _startParticipating();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (_lifecycleToggled == false) break;
        _lifecycleToggled = false;
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
