import 'package:encapsulated_scaffold/src/encapsulated_notification_overlay.dart';
import 'package:flutter/material.dart';

typedef EncapsulatedNotificationItemBuilder = Widget Function(
    BuildContext context, VoidCallback dismiss, Animation<double> timeoutAnimation);

/// [EncapsulatedNotificationItem] that's used for [EncapsulatedNotificationOverlay]
/// overlay entries.
class EncapsulatedNotificationItem {
  /// Creates [EncapsulatedNotificationItem].
  EncapsulatedNotificationItem({
    String tag,
    this.timeout = const Duration(seconds: 10),
    this.onDismissed,
    @required this.builder,
  })  : assert(timeout == null || timeout >= const Duration(seconds: 5)),
        createTime = DateTime.now(),
        tag = tag ?? _getTag();

  static var _notificationCounter = 0;
  static String _getTag() {
    _notificationCounter += 1;
    return _notificationCounter.toString();
  }

  /// Time when this [EncapsulatedNotificationItem] was constructed.
  final DateTime createTime;

  /// Unique notification tag, to differentiate multiple active notifications.
  final String tag;

  /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
  final EncapsulatedNotificationItemBuilder builder;

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  final Duration timeout;

  /// Callback on dismiss.
  final VoidCallback onDismissed;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is EncapsulatedNotificationItem && other.tag == tag;
  }

  @override
  int get hashCode => tag.hashCode;

  /// Deliver this notification to the nearest [EncapsulatedNotificationOverlayController].
  void push(BuildContext context) => EncapsulatedNotificationOverlayController.of(context).pushItem(this);
}
