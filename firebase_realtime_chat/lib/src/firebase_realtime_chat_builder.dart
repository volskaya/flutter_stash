import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_realtime_chat/src/firebase_realtime_chat.dart';
import 'package:firebase_realtime_chat/src/firebase_realtime_chat_impl.dart';
import 'package:flutter/material.dart';

/// [FirebaseRealtimeChatBuilder] child widget's builder.
typedef FirebaseRealtimeChatBuilderCallback<T extends FirebaseRealtimeChatMessageImpl,
        D extends FirebaseRealtimeChatParticipantImpl>
    = Widget Function(BuildContext context, FirebaseRealtimeChat<T, D> chat);

/// Event callback of [FirebaseRealtimeChatBuilder].
typedef FirebaseRealtimeChatEventCallback<T extends FirebaseRealtimeChatMessageImpl,
        D extends FirebaseRealtimeChatParticipantImpl>
    = void Function(FirebaseRealtimeChat<T, D> chat);

/// Widget version of [FirebaseRealtimeChat].
class FirebaseRealtimeChatBuilder<T extends FirebaseRealtimeChatMessageImpl,
    D extends FirebaseRealtimeChatParticipantImpl> extends StatefulWidget {
  /// Creates [FirebaseRealtimeChatBuilder].
  const FirebaseRealtimeChatBuilder({
    Key? key,
    required this.room,
    required this.sender,
    required this.builder,
    required this.messageBuilder,
    required this.participantBuilder,
    this.itemsPerPage = 20,
    this.participants,
    this.onInitState,
    this.onFirstPagePaginated,
    this.awaitRoute = false,
  }) : super(key: key);

  /// Chat room ID in the database.
  final String room;

  /// ID of the current auth user.
  final String sender;

  /// Builder of the chat widget.
  final FirebaseRealtimeChatBuilderCallback<T, D> builder;

  /// Messages per pagination.
  final int itemsPerPage;

  /// Plain message model builder. Passed json could be null.
  final FirebaseRealtimeChatMessageBuilder<T> messageBuilder;

  /// Participant model builder.
  final FirebaseRealtimeChatParticipantBuilder<D> participantBuilder;

  /// If the participant IDs are defined manually, there won't be any subscription observing
  /// participant IDs in the database.
  final Set<String>? participants;

  /// Called when the state is initialized.
  final VoidCallback? onInitState;

  /// Called after the first page has paginated.
  final FirebaseRealtimeChatEventCallback<T, D>? onFirstPagePaginated;

  /// Whether to await route before updating state with first page's items.
  ///
  /// NOTE: The items will still start being fetched when the widget first mounts, only
  /// the observable state will be delayed. This is usually used to avoid yank mid route
  /// change animations.
  final bool awaitRoute;

  @override
  _FirebaseRealtimeChatBuilderState<T, D> createState() => _FirebaseRealtimeChatBuilderState<T, D>();
}

class _FirebaseRealtimeChatBuilderState<T extends FirebaseRealtimeChatMessageImpl,
        D extends FirebaseRealtimeChatParticipantImpl> extends State<FirebaseRealtimeChatBuilder<T, D>>
    with WidgetsBindingObserver {
  late final DisposableBuildContext _disposableBuildContext;
  late final FirebaseRealtimeChat<T, D> _chat;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    _disposableBuildContext = DisposableBuildContext(this);
    _chat = FirebaseRealtimeChat<T, D>(
      collection: FirebaseDatabase.instance.reference().child('chats'),
      messageBuilder: widget.messageBuilder,
      participantBuilder: widget.participantBuilder,
      participants: widget.participants,
      itemsPerPage: widget.itemsPerPage,
      onFirstPagePaginated: widget.onFirstPagePaginated,
      awaitRoute: widget.awaitRoute,
    )
      ..initialize(
        context: _disposableBuildContext,
        senderId: widget.sender,
        chatId: widget.room,
      )
      ..reportPresence();

    try {
      widget.onInitState?.call();
    } finally {
      super.initState();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _disposableBuildContext.dispose();
    _chat.handleAppLifecycleStatus(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _chat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _chat);
}
