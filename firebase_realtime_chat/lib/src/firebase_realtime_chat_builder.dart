// import 'dart:async';

// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_realtime_chat/src/firebase_realtime_chat_impl.dart';
// import 'package:flutter/material.dart';
// import 'package:log/log.dart';
// import 'package:mobx/mobx.dart';
// import 'package:quiver/strings.dart';

// typedef FirebaseRealtimeChatMessageBuilder<T extends FirebaseRealtimeChatMessageImpl> = T Function(
//     [Map<dynamic, dynamic> json]);
// typedef FirebaseRealtimeChatMessageSnapshotBuilder<T extends FirebaseRealtimeChatMessageImpl> = T Function(
//     DatabaseReference reference, DataSnapshot snapshot);
// typedef FirebaseRealtimeChatParticipantBuilder<T extends FirebaseRealtimeChatParticipantImpl> = T Function(
//     bool online, bool writing);

// class _Storage<T extends FirebaseRealtimeChatMessageImpl> {
//   bool isEndReached = false;
//   int page = 0;
//   final paginatedItems = ObservableList<T>();
//   final subscribedItems = ObservableList<T>();
//   final pendingItems = ObservableList<T>();
// }

// /// Firebase realtime chat list & ui builder, similar to FirestoreCollectionBuilder.
// class FirebaseRealtimeChatBuilder<T extends FirebaseRealtimeChatMessageImpl,
//     D extends FirebaseRealtimeChatParticipantImpl> extends StatefulWidget {
//   /// Creates [FirebaseRealtimeChat].
//   const FirebaseRealtimeChatBuilder({
//     Key key,
//     @required this.collection,
//     @required this.messageBuilder,
//     @required this.messageSnapshotBuilder,
//     @required this.participantBuilder,
//     @required this.senderId,
//     @required this.chatId,
//     this.itemsPerPage = 20,
//   }) : super(key: key);

//   /// Realtime database list this chat will target.
//   final DatabaseReference collection;

//   /// Message model builder with optional json.
//   final FirebaseRealtimeChatMessageBuilder<T> messageBuilder;

//   /// Message snapshot builder.
//   final FirebaseRealtimeChatMessageSnapshotBuilder<T> messageSnapshotBuilder;

//   /// Participant model builder.
//   final FirebaseRealtimeChatParticipantBuilder<D> participantBuilder;

//   /// Items per page.
//   final int itemsPerPage;

//   /// Usually authenticated user id.
//   final String senderId;

//   /// Chatroom ID.
//   final String chatId;

//   @override
//   _FirebaseRealtimeChatBuilderState createState() => _FirebaseRealtimeChatBuilderState();
// }

// class _FirebaseRealtimeChatBuilderState<T extends FirebaseRealtimeChatMessageImpl,
//     D extends FirebaseRealtimeChatParticipantImpl> extends State<FirebaseRealtimeChatBuilder> {
//   static final _log = Log.named('FirebaseRealtimeChatBuilder');
//   final scrollController = ScrollController();
//   final _subscribedItemKeys = <String>{};

//   _Storage<T> _storage;
//   StreamSubscription<Event> _onAddedSubscription;
//   bool get _isSubscribed => _onAddedSubscription != null;

//   int get itemsPerPage => widget.itemsPerPage;
//   int get page => _storage.page;
//   set page(int val) => _storage.page = val;
//   bool get isEndReached => _storage.isEndReached;
//   set isEndReached(bool val) => _storage.isEndReached = val;
//   DateTime pageTimestamp = DateTime.now();
//   int get length => subscribedItems.length + paginatedItems.length;

//   ObservableList<T> get paginatedItems => _storage.paginatedItems;
//   ObservableList<T> get subscribedItems => _storage.subscribedItems;
//   ObservableList<T> get pendingItems => _storage.pendingItems;

//   DatabaseReference get _chatReference => widget.collection.child(widget.chatId);
//   DatabaseReference get _participantsCollection => _chatReference.child('participants');
//   DatabaseReference get _messageCollection => _chatReference.child('messages');

//   bool _fetchingPage = false;
//   Future fetchPage(int page, [int timestamp]) async {
//     // This method is called by lists, that use this chat class.
//     // The pagination, without `timestamp`, can only be called, when
//     // pagination already holds results, and when thats true,
//     // `_paginationTimestamp` will be available too
//     assert(paginatedItems.isNotEmpty || timestamp != null);

//     if (_fetchingPage) return;
//     _fetchingPage = true;

//     if (page <= this.page || isEndReached) {
//       _log.d('Skipping redundant pagination for page: $page');
//       return;
//     }

//     try {
//       await _paginate(timestamp);
//     } catch (e) {
//       _log.e(e);
//     } finally {
//       _fetchingPage = false;
//     }

//     assert(page == this.page); // Double check page numbers
//   }

//   Future _paginate(int timestamp) async {
//     final oldestTimestamp = _paginationTimestamp ?? timestamp;
//     _log.v('Paginating page ${page + 1}, startingAt $oldestTimestamp');

//     // Prefer offline over online
//     _FirebaseRealtimeChatMessageSource usedSource;
//     var messages = <T>[];
//     var items = const <String, dynamic>{};

//     // Initially try to paginate from the offline storage
//     final offlineSnapshots = await FirebaseRealtimeChatMirrorStorage.instance.find(
//       _messageCollection.path,
//       Finder(
//         filter: Filter.lessThan('createTime', oldestTimestamp),
//         sortOrders: [SortOrder('createTime', false)],
//         limit: itemsPerPage,
//       ),
//     );

//     if (offlineSnapshots.isNotEmpty) {
//       usedSource = _FirebaseRealtimeChatMessageSource.offline;
//       _log.wtf('Got ${offlineSnapshots.length} items from offline storage');

//       // If offlineSnapshots are not empty, map them to items
//       items = Map<String, dynamic>.fromEntries(
//         offlineSnapshots.map(
//           (record) => MapEntry<String, dynamic>(record.key, record.value),
//         ),
//       );
//     } else {
//       // If offline storage have no items, fall back to realtime db
//       usedSource = _FirebaseRealtimeChatMessageSource.online;
//       final query = _messageCollection.orderByChild('createTime').limitToLast(itemsPerPage).endAt(oldestTimestamp - 1);

//       _log.wtf('No offline items, fetching from realtime db');

//       try {
//         final onlineSnapshots = await query.once();
//         if (onlineSnapshots.value != null) {
//           items = Map<String, dynamic>.from(onlineSnapshots.value as Map);
//         }
//       } catch (e) {
//         _log.e(e);
//       }
//     }

//     try {
//       messages = items
//           .map(
//             (key, dynamic value) => MapEntry(
//               key,
//               messageBuilder(value as Map)
//                 ..reference = _messageCollection.child(key)
//                 ..updateMirror(), // Updates offline storage mirror
//             ),
//           )
//           .values
//           .toList(growable: false)
//             // NOTE: Query returns the documents unordered
//             ..sort((a, b) => b.createTime.compareTo(a.createTime));
//     } catch (e) {
//       _log.e(e);
//     }

//     // Assert order is correct, by making sure document timestamps
//     // are ordered newest to oldest
//     assert((() {
//       if (messages.length <= 1) return true; // Not enough items
//       var timestamp = messages.first.createTime;
//       for (final message in messages.skip(1)) {
//         if (message.createTime > timestamp) {
//           return false; // Next timestamp is later than current message
//         }
//         timestamp = message.createTime;
//       }
//       return true;
//     })());

//     _log.d('Paginated ${messages.length} items');

//     switch (usedSource) {
//       case _FirebaseRealtimeChatMessageSource.online:
//         if (messages.length < itemsPerPage) {
//           _log.v('Collection end reached');
//           isEndReached = true;
//         }
//         break;
//       default:
//       // Do nothing
//     }

//     paginatedItems.addAll(messages);
//     page += 1;
//     pageTimestamp = DateTime.now();
//   }

//   @override
//   void didChangeDependencies() {
//     if (_storage == null) {
//       // TODO
//     }

//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
