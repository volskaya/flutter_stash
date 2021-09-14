import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_realtime_chat/src/realtime_chat_impl.dart';
import 'package:firebase_realtime_chat/src/realtime_chat_mirror_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loader_coordinator/loader_coordinator.dart';
import 'package:log/log.dart';
import 'package:mobx/mobx.dart';
import 'package:quiver/strings.dart';
import 'package:refresh_storage/refresh_storage.dart';
import 'package:sembast/sembast.dart';

part 'realtime_chat_pod.freezed.dart';
part 'realtime_chat_pod.g.dart';

/// [RealtimeChatPod]'s message model's factory.
typedef RealtimeChatMessageBuilder<T extends RealtimeChatMessageImpl> = T Function(Map value);

/// [RealtimeChatPod]'s participant model's factory.
typedef RealtimeChatParticipantBuilder<T extends RealtimeChatParticipantImpl> = T Function();

/// Event callback of [RealtimeChatPod].
typedef RealtimeChatEventCallback<T extends RealtimeChatMessageImpl, D extends RealtimeChatParticipantImpl> = void
    Function(RealtimeChatPod<T, D> state);

class RealtimeChatProps<T extends RealtimeChatMessageImpl, D extends RealtimeChatParticipantImpl> {
  RealtimeChatProps({
    required this.room,
    required this.sender,
    required this.collection,
    required this.messageBuilder,
    required this.participantBuilder,
    this.itemsPerPage = 20,
    this.participants = const <String>{},
    this.onInitState,
    this.onFirstPagePaginated,
    this.delayedFuture,
    this.delay = Duration.zero,
    this.firebaseDatabase,
  }) : bucket = 'realtime_chat_pod_$room';

  /// The bucket used for this chat.
  final String bucket;

  /// Chat room ID in the database.
  final String room;

  /// ID of the current auth user.
  final String sender;

  /// Realtime database list this chat will target.
  final DatabaseReference collection;

  /// Message model builder with optional json.
  final RealtimeChatMessageBuilder<T> messageBuilder;

  /// Participant model builder.
  final RealtimeChatParticipantBuilder<D> participantBuilder;

  /// Number of item to paginate per page. Subscribed items will still fetch as much as possible.
  final int itemsPerPage;

  /// If the participant IDs are defined manually, there won't be any subscription observing
  /// user IDs in the database.
  final Set<String> participants;

  /// Called when the state is initialized.
  final VoidCallback? onInitState;

  /// Called after the first page has paginated.
  final RealtimeChatEventCallback<T, D>? onFirstPagePaginated;

  /// A future to await before updating the state with initial items.
  final Future Function()? delayedFuture;

  /// The delay to await before updating the state with initial items.
  final Duration delay;

  /// Firebase database to use with chat. This must be provided in cases, when
  /// the project's RTDB is not located in the default US region.
  ///
  /// When it's not in the default US region, the [FirebaseDatabase.instance] won't
  /// automatically read the url from google-services file.
  final FirebaseDatabase? firebaseDatabase;

  // Prop equality is tied only to the bucket.
  @override
  bool operator ==(dynamic other) => identical(other, this) || (other is RealtimeChatProps && other.bucket == bucket);

  @override
  int get hashCode => runtimeType.hashCode ^ bucket.hashCode;
}

@freezed
class RealtimeChatValue<T extends RealtimeChatMessageImpl, D extends RealtimeChatParticipantImpl>
    with _$RealtimeChatValue<T, D>
    implements RefreshStorageItem {
  const factory RealtimeChatValue({
    required List<T> paginated,
    required List<T> subscribed,
    required List<T> pending,
    required DateTime createTime,
    @Default(false) bool ended,
    @Default(0) int page,
  }) = _RealtimeChatPodValue;

  const RealtimeChatValue._();

  @override
  void dispose([dynamic _]) {}

  RealtimeChatValue<T, D> clean() => copyWith(
        paginated: paginated..insertAll(0, pending.reversed.followedBy(subscribed.reversed)),
        pending: <T>[],
        subscribed: <T>[],
      );
}

class RealtimeChatPod<T extends RealtimeChatMessageImpl, D extends RealtimeChatParticipantImpl>
    extends _RealtimeChatPod<T, D> with _$RealtimeChatPod<T, D> {
  RealtimeChatPod(
    ProviderRefBase ref, {
    required int refresh,
    required RealtimeChatProps<T, D> props,
    RealtimeChatValue<T, D>? initialValue,
  }) : super(
          ref,
          refresh: refresh,
          props: props,
          initialValue: initialValue,
        );

  static ProviderFamily<RealtimeChatPod<T, D>, RealtimeChatProps<T, D>>
      getProviderFamily<T extends RealtimeChatMessageImpl, D extends RealtimeChatParticipantImpl>() => Provider.family(
            (ref, props) {
              final refresh = ref.read(RefreshCounterPod.provider);
              final storage = ref.read(RefreshStoragePod.provider);
              final storageEntry = storage.getItem(props.bucket);
              final previousState = storageEntry?.item as RealtimeChatValue<T, D>?;
              final usePreviousState = storageEntry != null && refresh == storageEntry.refresh;
              final collection = RealtimeChatPod<T, D>(
                ref,
                props: props,
                refresh: refresh,
                initialValue: usePreviousState ? previousState : null,
              );

              void listener() {
                final value = RealtimeChatValue(
                  paginated: collection.paginated,
                  subscribed: collection.subscribed,
                  pending: collection.pending,
                  createTime: collection.createTime,
                  ended: collection.ended,
                  page: collection.page,
                );

                storage.add(props.bucket, value, refresh);
              }

              collection.addListener(listener);
              ref.onDispose(() => collection.removeListener(listener));

              return collection;
            },
            name: 'FirestoreCollection',
          );
}

abstract class _RealtimeChatPod<T extends RealtimeChatMessageImpl, D extends RealtimeChatParticipantImpl>
    extends ChangeNotifier
    with AnimationLocalListenersMixin, AnimationLazyListenerMixin, WidgetsBindingObserver, Store {
  _RealtimeChatPod(
    this.ref, {
    required this.refresh,
    required this.props,
    RealtimeChatValue<T, D>? initialValue,
  })  : ended = initialValue?.ended ?? false,
        page = initialValue?.page ?? 0,
        createTime = initialValue?.createTime ?? DateTime.now(),
        paginated = initialValue != null
            ? [
                ...initialValue.pending.reversed,
                ...initialValue.subscribed.reversed,
                ...initialValue.paginated,
              ]
            : <T>[] {
    chatReference = props.collection.child(props.room);
    participantsCollection = chatReference.child('participants');
    participantListCollection = chatReference.child('whitelist');
    messageCollection = chatReference.child('messages');

    // Manually defining participants should avoid listening to the database.
    if (props.participants.isNotEmpty) participants = props.participants;
  }

  static final _log = Log.named('RealtimeChatPod');

  final ProviderRefBase ref;
  final int refresh;
  final RealtimeChatProps<T, D> props;
  final DateTime createTime;

  late final DatabaseReference chatReference;
  late final DatabaseReference participantsCollection;
  late final DatabaseReference participantListCollection;
  late final DatabaseReference messageCollection;

  final scrollController = ScrollController();
  final _seenItems = <String>{}; // Seen document IDs to filter redundant items.

  @o List<T> paginated = <T>[];
  @o List<T> subscribed = <T>[];
  @o List<T> pending = <T>[];
  @o Set<String> participants = const <String>{};
  @o bool ended = false;
  @o int page = 0;

  FirebaseDatabase get database => props.firebaseDatabase ?? FirebaseDatabase.instance;
  StreamSubscription<Event>? _onAddedSubscription;
  StreamSubscription<Event>? _onDisconnectSubscription;
  StreamSubscription<Event>? _participantsSubscription;
  bool _fetchingPage = false;
  bool get _isSubscribed => _onAddedSubscription != null;
  D? _lastPresence;

  RealtimeChatMirrorStorage? mirrorStorage; // TODO: Reuse from storage value.
  DateTime pageTimestamp = DateTime.now();
  int get length => subscribed.length + paginated.length;

  bool get _isScrolled {
    assert(scrollController.hasClients);
    return scrollController.offset > 0;
  }

  /// Uses cursor only from the nearest online confirmed document.
  /// Pagination timestamps don't care about the online confirmation.
  int? get _paginationTimestamp => paginated.reversed.firstWhereOrNull((item) => item.createTime != null)?.createTime;

  /// Uses cursor only from the nearest online confirmed document.
  int? get _subscriptionTimestamp => pending.reversed
      .followedBy(subscribed.reversed)
      .followedBy(paginated)
      .firstWhereOrNull((item) => item.isServerTimestamp && item.createTime != null)
      ?.createTime;

  /// Start calling paginators with all items on the last page.
  /// Make sure the redundant calls are dropped though.
  bool shouldPaginate(int paginatedItemIndex) => paginatedItemIndex > (paginated.length - props.itemsPerPage);

  /// Get the paginator callback for a paginated documents widget, according to its index within a list.
  VoidCallback? getPaginator(int paginatedItemIndex) =>
      shouldPaginate(paginatedItemIndex) ? () => fetchPage(page + 1) : null;

  /// Get an item by its N index across both `subscribedItems` & `paginatedItems`.
  T getItem(int index) => index > (subscribed.length - 1) ? paginated[index - subscribed.length] : subscribed[index];

  Future fetchPage(int page, [int? timestamp]) async {
    assert(mirrorStorage != null);

    // This method is called by lists, that use this chat class.
    // The pagination, without `timestamp`, can only be called, when
    // pagination already holds results, and when thats true,
    // `_paginationTimestamp` will be available too.
    // assert(paginatedItems.isNotEmpty || timestamp != null);

    if (_fetchingPage || page <= this.page || ended) return;
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
  @action
  Future _paginate([int? timestamp]) async {
    assert(mirrorStorage != null);

    final isFirstPage = page == 0;
    final oldestTimestamp = _paginationTimestamp ?? timestamp;
    _log.v('Paginating page ${page + 1}, startingAt: ${oldestTimestamp ?? "First item"}');

    // Prefer offline over online.
    RealtimeChatMessageSource usedSource;
    var messages = <T>[];
    var items = const <String, dynamic>{};

    // Initially try to paginate from the offline storage.
    //
    // A mirror storage is initialized per each chat room, before the pagination starts,
    // so this should be ready.
    final offlineSnapshots = await mirrorStorage?.find(
      messageCollection.path,
      oldestTimestamp != null
          ? Finder(
              filter: Filter.lessThan('createTime', oldestTimestamp),
              sortOrders: [SortOrder('createTime', false)],
              limit: props.itemsPerPage,
            )
          : Finder(
              sortOrders: [SortOrder('createTime', false)],
              limit: props.itemsPerPage,
            ),
    );

    if (offlineSnapshots?.isNotEmpty == true) {
      usedSource = RealtimeChatMessageSource.mirrorStorage;
      _log.wtf('Got ${offlineSnapshots!.length} items from offline storage');

      // If `offlineSnapshots` are not empty, map them to items.
      items = HashMap<String, dynamic>.fromEntries(
        offlineSnapshots.map((record) => MapEntry<String, dynamic>(record.key, record.value)),
      );
    } else {
      // If offline storage have no items, fall back to realtime db.
      usedSource = RealtimeChatMessageSource.realtimeDatabase;
      var query = messageCollection.orderByChild('createTime').limitToLast(props.itemsPerPage);
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
        final message = props.messageBuilder(entry.value as Map)
          ..reference = messageCollection.child(entry.key)
          ..snapshot = snapshot
          ..list = RealtimeChatMessageList.paginated
          ..source = usedSource;

        if (message.source == RealtimeChatMessageSource.realtimeDatabase) message.updateMirror();
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
      case RealtimeChatMessageSource.realtimeDatabase:
        if (messages.length < props.itemsPerPage) {
          _log.d('Collection end reached');
          ended = true;
        }
        break;
      default:
      // Do nothing.
    }
    if (!mounted) {
      return;
    } else if (isFirstPage && mounted) {
      final now = DateTime.now();
      final awaitDelay = props.delay > Duration.zero && now.isBefore(createTime.add(props.delay));
      final awaitDelayedFuture = props.delayedFuture != null;

      try {
        await Future.wait([
          if (awaitDelayedFuture) props.delayedFuture!(),
          if (awaitDelay) Future<void>.delayed(now.difference(createTime).abs()),
        ]);
      } catch (_) {}

      if (!mounted) return;
    }

    paginated = paginated..addAll(messages);
    page += 1;
    pageTimestamp = DateTime.now();
    notifyListeners();

    if (isFirstPage && mounted && props.onFirstPagePaginated != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (mounted) props.onFirstPagePaginated?.call(this as RealtimeChatPod<T, D>);
      });
    }
  }

  void _startSubscription({int? timestamp}) {
    assert(!_isSubscribed);
    assert(timestamp != null || paginated.isEmpty, 'Paginated items are not empty, use a timestamp from it');

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

        final list = _isScrolled ? RealtimeChatMessageList.pending : RealtimeChatMessageList.subscribed;
        final message = props.messageBuilder(child.snapshot.value as Map)
          ..reference = messageCollection.child(child.snapshot.key!)
          ..snapshot = child.snapshot
          ..list = list
          ..updateMirror();

        // When the list is scrolled, new items are pushed to pending items.
        _seenItems.add(child.snapshot.key!);
        if (_isScrolled) {
          pending = pending..add(message);
        } else {
          subscribed = subscribed..add(message);
        }
        notifyListeners();
      },
    );
  }

  Future _disposeSubscription() async {
    final cancelFuture = _onAddedSubscription?.cancel();
    _onAddedSubscription = null;
    await cancelFuture;
  }

  /// When device resumes from sleep or reconnects to the network,
  /// you're expected to redo `_startParticipating`.
  Future _startParticipating() async {
    assert(mounted);

    // NOTE: At the moment, rules enforce having an existing presence, to be allowed to read message documents.
    await reportPresence(online: true);

    // Don't subscribe to the participant ID list, if the IDs were passed manually.
    if (participants.isEmpty) {
      _participantsSubscription?.cancel();
      _participantsSubscription = participantListCollection.onValue.listen(
        (event) {
          if (!mounted) return;
          participants = Set<String>.from((event.snapshot.value as Map?)?.keys ?? const <String>[]);
          notifyListeners();
        },
      );
    } else {
      assert(setEquals(participants, props.participants));
    }
  }

  void _handleScroll() {
    assert(scrollController.hasClients);
    if (!_isScrolled) movePendingItemsToSubscribedItems();
  }

  @action
  void movePendingItemsToSubscribedItems() {
    if (pending.isNotEmpty) {
      subscribed = subscribed..addAll(pending);
      pending = pending..clear();
    }
  }

  Future reportPresence({bool online = true, bool writing = false}) async {
    final sendersParticipantRef = participantsCollection.child(props.sender);

    // If reporting presence, add an `onDisconnect` reaction, to clean
    // this up, if the database loses connection with the client.
    if (_onDisconnectSubscription == null) {
      _log.v('Registering an `onDisconnect` reaction, to reset senders participant data');
      _onDisconnectSubscription = database.reference().child('.info/connected').onValue.listen(
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

    final presence = props.participantBuilder()
      ..online = online
      ..writing = writing;
    if (_lastPresence?.online != presence.online || _lastPresence?.writing != presence.writing) {
      _lastPresence = presence;

      try {
        await sendersParticipantRef.update(presence.toJson().cast<String, dynamic>());
      } on PlatformException catch (e, t) {
        _log.e('Failed to to report presence for ${sendersParticipantRef.path} ', e, t);
      }
    }
  }

  Future _handleInitialMount() async {
    assert(mounted);
    assert(isNotEmpty(props.room));
    assert(isNotEmpty(props.sender));

    scrollController.addListener(_handleScroll);
    await _startListening();
  }

  Future _initializeMirror() async {
    // First prepare the mirror storage for offline documents.
    final mirrorStorage = await RealtimeChatMirrorStorage.initialize(chatReference);
    if (mounted) {
      this.mirrorStorage = mirrorStorage;
    } else {
      await mirrorStorage.dispose();
    }
  }

  Future _startListening() async {
    await _initializeMirror();
    if (!mounted) return;

    // First page will always attempt to fetch from offline.
    // If offline storage has items, use their newest timestamp
    // to fetch any missed messages.
    //
    // Make sure this initial pagination doesn't fail on network outage or
    // the subscription could put the whole cache in an inconsistent state,
    // if it subs to newer messages and leave a gap between oldest subbed
    // message and the newest paginated.
    if (paginated.isEmpty) await fetchPage(1);
    if (!mounted) return;

    _startSubscription(timestamp: _subscriptionTimestamp);
    WidgetsBinding.instance!.addObserver(this);
    await _startParticipating();
  }

  bool mounted = false;

  @override
  void didStartListening() {
    mounted = true;
    _handleInitialMount();
  }

  @override
  void didStopListening() {
    dispose();

    WidgetsBinding.instance!.removeObserver(this);
    mounted = false;
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    _disposeSubscription();
    _participantsSubscription?.cancel();
    mirrorStorage?.dispose();
    mirrorStorage = null;

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
        _onDisconnectSubscription?.cancel();
        _onDisconnectSubscription = null;
        _participantsSubscription?.cancel();
        _participantsSubscription = null;
        break;
    }
  }
}
