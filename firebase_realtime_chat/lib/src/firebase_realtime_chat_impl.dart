import 'package:firebase_database/firebase_database.dart';

/// Implementation required by the [FirebaseFirebaseRealtimeChat] items.
abstract class FirebaseRealtimeChatMessageImpl {
  /// Reference to the message in the database.
  DatabaseReference reference;

  /// Server timestamp of this chat message.
  int createTime;

  /// Whether the message was confirmed online.
  bool online;

  /// User IDs that have read this message.
  List<String> readBy;

  /// Json serializer of this participant.
  Map<String, dynamic> toJson();

  /// When the chat fetches an item, it's mirror storage needs to be updated as well.
  Future updateMirror();
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
  Map<String, dynamic> toJson();
}