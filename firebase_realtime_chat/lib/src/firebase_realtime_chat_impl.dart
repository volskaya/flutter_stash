import 'package:firebase_database/firebase_database.dart';

/// Source list where this [FirebaseRealtimeChatMessageImpl] was first inserted.
enum FirebaseRealtimeChatMessageList {
  /// Paginated item list.
  paginated,

  /// Subscribed item list.
  subscribed,

  /// Pending item list. Later moved to subscribed items, but the source won't reflect that.
  pending,
}

/// Source database from where this [FirebaseRealtimeChatMessageImpl] was received.
enum FirebaseRealtimeChatMessageSource {
  /// Offline mirror storage.
  mirrorStorage,

  /// Firestore realtime database.
  realtimeDatabase,
}

/// Implementation required by the [FirebaseFirebaseRealtimeChat] items.
abstract class FirebaseRealtimeChatMessageImpl {
  /// Reference to the message in the database.
  DatabaseReference reference;

  /// Snapshot that was used to build this model.
  DataSnapshot snapshot;

  /// Source list where this [FirebaseRealtimeChatMessageImpl] was first inserted.
  FirebaseRealtimeChatMessageList list;

  /// Source database from where this [FirebaseRealtimeChatMessageImpl] was received.
  FirebaseRealtimeChatMessageSource source;

  /// Server timestamp of this chat message.
  int createTime;

  /// Whether the message was confirmed online.
  bool online;

  /// User IDs that have read this message with their read timestamp.
  Map<String, num> reads;

  /// Json serializer of this participant.
  Map toJson();

  /// When the chat fetches an item, it's mirror storage needs to be updated as well.
  Future updateMirror();

  /// Whether to assume the timestamp is correct with the server and
  /// can be used for pagination & subscription.
  bool get isServerTimestamp;
}

/// Implementation required by the [FirebaseFirebaseRealtimeChat] participants.
abstract class FirebaseRealtimeChatParticipantImpl {
  /// Update timestamp of this model.
  int updateTime;

  /// Whether the participant is online in the chat room.
  bool online;

  /// Whether the participant is currently writing.
  bool writing;

  /// Json serializer of this participant.
  Map toJson();
}
