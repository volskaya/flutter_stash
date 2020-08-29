import 'package:encapsulated_scaffold/src/encapsulated_notification_overlay.dart';
import 'package:flutter/material.dart';

/// [EncapsulatedNotificationItem] that's used for [EncapsulatedNotificationOverlay]
/// overlay entries.
class EncapsulatedNotificationItem {
  /// Creates [EncapsulatedNotificationItem].
  EncapsulatedNotificationItem({
    String tag,
    @required this.content,
    this.icon,
    this.title,
    this.buttons = const <Widget>[],
    this.timeout = const Duration(seconds: 10),
    this.backgroundColor,
    this.textColor,
    this.onDismissed,
  })  : assert(timeout == null || timeout >= const Duration(seconds: 5)),
        tag = tag ?? _getTag();

  static var _notificationCounter = 0;
  static String _getTag() {
    _notificationCounter += 1;
    return _notificationCounter.toString();
  }

  /// Unique notification tag, to differentiate multiple active notifications.
  final String tag;

  /// Notifications body content.
  final Widget content;

  /// Notification icon, on the left of [title].
  final Widget icon;

  /// Notification title.
  final Widget title;

  /// Button bar children at the bottom of the notification.
  final List<Widget> buttons;

  /// Fade out time of the notification. Set null to keep the item on screen
  /// till user interaction.
  final Duration timeout;

  /// Background color of the overlay entry.
  final Color backgroundColor;

  /// Notification text color.
  final Color textColor;

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
  void push(BuildContext context) =>
      EncapsulatedNotificationOverlayController.of(context).pushItem(this);
}
