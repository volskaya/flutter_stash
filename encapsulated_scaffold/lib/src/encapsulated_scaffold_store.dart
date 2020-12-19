import 'dart:async';

import 'package:encapsulated_scaffold/src/encapsulated_notification_item.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold.dart';
import 'package:encapsulated_scaffold/src/encapsulated_sheet_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'encapsulated_scaffold_store.g.dart';

/// Callback that is called before an [EncapsulatedNotificationItem] is added to the [EncapsulatedScaffoldStore].
typedef EncapsulatedNotificationPushCallback = void Function(EncapsulatedNotificationItem notification);

/// Store of [EncapsulatedScaffold].
class EncapsulatedScaffoldStore extends _EncapsulatedScaffoldStore with _$EncapsulatedScaffoldStore {
  /// Creates [EncapsulatedScaffoldStore].
  EncapsulatedScaffoldStore({
    EncapsulatedNotificationPushCallback onPushingNotification,
  }) : super(onPushingNotification: onPushingNotification);

  /// Get the nearest [EncapsulatedScaffoldStore].
  static EncapsulatedScaffoldStore of(BuildContext context) =>
      Provider.of<EncapsulatedScaffoldStore>(context, listen: false);
}

abstract class _EncapsulatedScaffoldStore with Store {
  _EncapsulatedScaffoldStore({
    this.onPushingNotification,
  }) {
    _visibleNotificationReactionDisposer = reaction<EncapsulatedNotificationItem>(
      (_) => notification,
      _handleNotificationChange,
      fireImmediately: true,
    );
  }

  /// Callback that is called before a notification is added to the store.
  final EncapsulatedNotificationPushCallback onPushingNotification;

  /// Capsules are added and popped as the navigator routes.
  ///
  /// NOTE: .linkedHashSetFrom, to preserve order of insertion
  final capsules = ObservableSet<EncapsulatedScaffoldState>.linkedHashSetFrom([]);
  final notifications = ObservableList<EncapsulatedNotificationItem>();
  final importantNotifications = ObservableList<EncapsulatedNotificationItem>();
  final sheets = ObservableList<EncapsulatedSheetItem>();

  Timer _timer; // Active notification timeout timer.
  ReactionDisposer _visibleNotificationReactionDisposer;

  @computed
  EncapsulatedScaffoldState get capsule => capsules.isNotEmpty ? capsules.last : null;

  @computed
  EncapsulatedSheetItem get sheet => sheets.isNotEmpty ? sheets.last : null;

  @computed
  EncapsulatedNotificationItem get notification =>
      importantNotifications.isNotEmpty // Prioritize important notifications.
          ? importantNotifications.last
          : notifications.isNotEmpty
              ? notifications.last
              : null;

  ObservableList<EncapsulatedNotificationItem> _getAppropriateNotificationList(EncapsulatedNotificationItem item) =>
      item.important ? importantNotifications : notifications;

  void _handleNotificationChange(EncapsulatedNotificationItem notification) {
    // Cancel previous timeout.
    _timer?.cancel();
    _timer = null;

    // Start the timer for the current notifications timeout.
    if (notification.timeout != null && !notification.important) {
      _timer = Timer(notification.timeout * timeDilation, () {
        _timer = null;
        dismissNotification(notification);
      });
    }
  }

  /// Push an [EncapsulatedNotificationItem] to the overlay.
  ///
  /// Pass tags as [replacements] to pop existing notifications as the new one is added.
  ///
  @action
  void pushNotification(EncapsulatedNotificationItem item, [Set<String> _replacements = const <String>{}]) {
    try {
      onPushingNotification?.call(item);
    } catch (_) {}

    final replacements = [
      if (item.tag != null) item.tag,
      ..._replacements,
    ];

    if (replacements.isNotEmpty) {
      notifications.removeWhere((item) => replacements.contains(item.tag));
      importantNotifications.removeWhere((item) => replacements.contains(item.tag));
    }

    _getAppropriateNotificationList(item).add(item);
  }

  /// Remove an [EncapsulatedNotificationItem] from the overlay.
  @action
  void dismissNotification(EncapsulatedNotificationItem item) {
    final didRemove = _getAppropriateNotificationList(item).remove(item);
    if (didRemove) item.onDismissed?.call();
  }

  @action
  void pushSheet(EncapsulatedSheetItem item) {
    assert(sheets.isEmpty); // Only allow 1 sheet for the sake of better UI.
    assert(sheets.where((sheet) => sheet.tag != item.tag).isEmpty);
    sheets.add(item);
  }

  @action
  void removeSheet(EncapsulatedSheetItem item) {
    final didRemove = sheets.remove(item);
    if (didRemove) item.onDismissed?.call();
  }

  @action
  void dismissNotificationsWhere(
    bool Function(EncapsulatedNotificationItem item) conditional, {
    bool includeImportant = true,
  }) =>
      [
        ...notifications.where(conditional).toList(growable: false),
        if (includeImportant) ...importantNotifications.where(conditional).toList(growable: false),
      ].forEach(dismissNotification);

  /// Dismiss all notifications.
  /// Dismissing them like this won't call [EncapsulatedNotificationItem.onDismissed].
  @action
  void dismissAllNotifications({bool includingUndismissible = false}) {
    notifications.removeWhere((item) => item.dismissible ? true : includingUndismissible);
    importantNotifications.removeWhere((item) => item.dismissible ? true : includingUndismissible);
  }

  void dispose() {
    _visibleNotificationReactionDisposer?.call();
  }
}
