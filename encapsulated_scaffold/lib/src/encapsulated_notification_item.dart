import 'package:encapsulated_scaffold/src/encapsulated_notification_overlay.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';
import 'package:flutter/material.dart';

typedef EncapsulatedNotificationItemBuilder = Widget Function(
    BuildContext context, VoidCallback dismiss, Animation<double> timeoutAnimation);

/// [EncapsulatedNotificationItem] that's used for [EncapsulatedNotificationOverlay]
/// overlay entries.
class EncapsulatedNotificationItem {
  /// Creates [EncapsulatedNotificationItem].
  EncapsulatedNotificationItem({
    /// Unique notification tag, to differentiate multiple active notifications.
    String tag,
    @required this.builder,
    this.onDismissed,
    this.timeout = const Duration(seconds: 10),
    this.important = false,
    this.dismissible = true,
    this.previous,
  })  : assert(timeout == null || timeout >= const Duration(seconds: 5)),
        assert(important == false || timeout == null, 'Don\'t dim backgrounds of temporary notifications'),
        createTime = DateTime.now(),
        _tag = tag;

  final String _tag;
  EncapsulatedScaffoldStore _controller;

  /// Time when this [EncapsulatedNotificationItem] was constructed.
  final DateTime createTime;

  /// Unique notification tag, to differentiate multiple active notifications.
  String get tag => _tag ?? hashCode.toString();

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  final EncapsulatedNotificationItemBuilder builder;

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  final Duration timeout;

  /// Callback on dismiss.
  final VoidCallback onDismissed;

  /// Dim the background behind the notification and intercept pop.
  final bool important;

  /// Wether the user is allowed to manually dismiss this notification.
  final bool dismissible;

  /// Reference to the previous [EncapsulatedNotificationItem].
  final EncapsulatedNotificationItem previous;

  /// Deliver this notification to the nearest [EncapsulatedNotificationOverlayController].
  void push(BuildContext context, [Set<String> replacements = const <String>{}]) {
    _controller = EncapsulatedScaffoldStore.of<EncapsulatedScaffoldDataBase>(context);
    _controller.pushNotification(this, replacements);
  }

  /// Remove this item from the [EncapsulatedNotificationOverlayController].
  void dismiss() {
    assert(_controller != null, 'Item must be pushed, before it\'s dismissed');
    _controller?.dismissNotification(this);
  }
}
