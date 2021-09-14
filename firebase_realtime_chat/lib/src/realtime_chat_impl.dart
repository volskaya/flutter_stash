import 'package:firebase_database/firebase_database.dart';

/// Source list where this [RealtimeChatMessageImpl] was first inserted.
enum RealtimeChatMessageList {
  /// Paginated item list.
  paginated,

  /// Subscribed item list.
  subscribed,

  /// Pending item list. Later moved to subscribed items, but the source won't reflect that.
  pending,
}

/// Source database from where this [RealtimeChatMessageImpl] was received.
enum RealtimeChatMessageSource {
  /// Offline mirror storage.
  mirrorStorage,

  /// Firestore realtime database.
  realtimeDatabase,
}

/// Implementation required by the [RealtimeChatPod] items.
abstract class RealtimeChatMessageImpl {
  /// Reference to the message in the database.
  late DatabaseReference reference;

  /// Snapshot that was used to build this model.
  DataSnapshot? snapshot;

  /// Source list where this [RealtimeChatMessageImpl] was first inserted.
  late RealtimeChatMessageList list;

  /// Source database from where this [RealtimeChatMessageImpl] was received.
  late RealtimeChatMessageSource source;

  /// Server timestamp of this chat message.
  int? createTime;

  /// Whether the message was confirmed online.
  late bool online;

  /// User IDs that have read this message with their read timestamp.
  ///
  /// The package uses this to look up the participant's uid key to check
  /// if the it has read the message.
  late Map reads;

  /// Json serializer of this participant.
  Map toJson();

  /// When the chat fetches an item, it's mirror storage needs to be updated as well.
  Future updateMirror();

  /// Whether to assume the timestamp is correct with the server and
  /// can be used for pagination & subscription.
  bool get isServerTimestamp;
}

/// Implementation required by the [RealtimeChatPod] participants.
abstract class RealtimeChatParticipantImpl {
  /// Whether the participant is online in the chat room.
  late bool online;

  /// Whether the participant is currently writing.
  late bool writing;

  /// Json serializer of this participant.
  Map toJson();
}
