import 'dart:async';

import 'package:encapsulated_scaffold/src/encapsulated_notification_item.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'encapsulated_scaffold_store.g.dart';

/// Store of [EncapsulatedScaffold].
class EncapsulatedScaffoldStore<T extends EncapsulatedScaffoldDataBase> extends _EncapsulatedScaffoldStore<T>
    with _$EncapsulatedScaffoldStore<T> {
  /// Get the nearest [EncapsulatedScaffoldStore].
  static EncapsulatedScaffoldStore<D> of<D extends EncapsulatedScaffoldDataBase>(BuildContext context) =>
      Provider.of<EncapsulatedScaffoldStore>(context, listen: false) as EncapsulatedScaffoldStore<D>;
}

abstract class _EncapsulatedScaffoldStore<T extends EncapsulatedScaffoldDataBase> with Store {
  /// Capsules are added and popped as the navigator routes.
  ///
  /// NOTE: .linkedHashSetFrom, to preserve order of insertion
  final capsules = ObservableSet<EncapsulatedScaffoldState<T>>.linkedHashSetFrom([]);
  final notifications = ObservableList<EncapsulatedNotificationItem>();
  final importantNotifications = ObservableList<EncapsulatedNotificationItem>();
  final _notificationTimers = <EncapsulatedNotificationItem, Timer>{};

  @computed
  EncapsulatedScaffoldState<EncapsulatedScaffoldDataBase> get capsule => capsules.isNotEmpty ? capsules.last : null;

  ObservableList<EncapsulatedNotificationItem> _getAppropriateNotificationList(EncapsulatedNotificationItem item) =>
      item.important ? importantNotifications : notifications;

  /// Push an [EncapsulatedNotificationItem] to the overlay.
  ///
  /// Pass tags as [replacements] to pop existing notifications as the new one is added.
  ///
  @action
  void pushNotification(EncapsulatedNotificationItem item, [Set<String> replacements = const <String>{}]) {
    _getAppropriateNotificationList(item).add(item);
    if (replacements.isNotEmpty) {
      notifications.removeWhere((item) => replacements.contains(item.tag));
      importantNotifications.removeWhere((item) => replacements.contains(item.tag));
    }

    if (item.timeout != null) {
      assert(!item.important);
      _notificationTimers[item]?.cancel();
      _notificationTimers[item] = Timer(item.timeout * timeDilation, () {
        _notificationTimers.remove(item);
        dismissNotification(item);
      });
    }
  }

  /// Remove an [EncapsulatedNotificationItem] from the overlay.
  @action
  void dismissNotification(EncapsulatedNotificationItem item) {
    final didRemove = _getAppropriateNotificationList(item).remove(item);
    if (didRemove) item.onDismissed?.call();
  }

  /// Dismiss all notifications.
  /// Dismissing them like this won't call [EncapsulatedNotificationItem.onDismissed].
  @action
  void dismissAllNotifications({bool includingUndismissible = false}) {
    notifications.removeWhere((item) => item.dismissible ? true : includingUndismissible);
    importantNotifications.removeWhere((item) => item.dismissible ? true : includingUndismissible);
  }
}
