import 'dart:async';

import 'package:encapsule/src/encapsule.dart';
import 'package:encapsule/src/encapsule_notification.dart';
import 'package:encapsule/src/encapsule_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'encapsule_store.g.dart';

/// Callback that is called before an [EncapsuleNotification] is added to the [EncapsuleStore].
typedef EncapsuleNotificationPushCallback = void Function(EncapsuleNotification notification);

/// Store of [EncapsuleScaffold].
class EncapsuleStore extends _EncapsuleScaffoldStore with _$EncapsuleStore {
  /// Creates [EncapsuleStore].
  EncapsuleStore._();

  static final instance = EncapsuleStore._();

  /// Attempts to find the overlay that's used to build [EncapsuleScaffoldOverlay],
  /// if the [EncapsuleStore.overlayKey] is used, else lookup regular root overlay.
  static OverlayState? overlayOf(BuildContext context) =>
      EncapsuleStore.instance.overlayKey.currentState ?? Overlay.of(context, rootOverlay: true);
}

abstract class _EncapsuleScaffoldStore with Store {
  _EncapsuleScaffoldStore() {
    _visibleNotificationReactionDisposer = reaction<EncapsuleNotification?>(
      (_) => notification,
      _handleNotificationChange,
      fireImmediately: true,
    );
  }

  final overlayKey = GlobalKey<OverlayState>();
  final _observers = ObserverList<EncapsuleStoreObserver>();

  void addObserver(EncapsuleStoreObserver value) => _observers.add(value);
  bool removeObserver(EncapsuleStoreObserver value) => _observers.remove(value);

  /// Capsules are added and popped as the navigator routes.
  ///
  /// NOTE: .linkedHashSetFrom, to preserve order of insertion
  final capsules = ObservableSet<EncapsuleElementValue>.linkedHashSetFrom([]);
  final notifications = ObservableList<EncapsuleNotification>();
  final importantNotifications = ObservableList<EncapsuleNotification>();
  final sheets = ObservableList<EncapsuleSheet>();

  Timer? _timer; // Active notification's timeout timer.
  ReactionDisposer? _visibleNotificationReactionDisposer;

  @c EncapsuleElementValue? get capsule => capsules.isNotEmpty ? capsules.last : null;
  @c EncapsuleSheet? get sheet => sheets.isNotEmpty ? sheets.last : null;
  @c EncapsuleNotification? get notification => importantNotifications.isNotEmpty // Prioritize important notifications.
      ? importantNotifications.last
      : notifications.isNotEmpty && sheet == null // Hide while there's a registered sheet.
          ? notifications.last
          : null;

  ObservableList<EncapsuleNotification> _getAppropriateNotificationList(EncapsuleNotification item) =>
      item.important ? importantNotifications : notifications;

  void _handleNotificationChange(EncapsuleNotification? notification) {
    // Cancel previous timeout.
    _timer?.cancel();
    _timer = null;

    // Start the timer for the current notifications timeout.
    if (notification?.timeout != null && !notification!.important) {
      _timer = Timer(notification.timeout! * timeDilation, () {
        _timer = null;
        dismissNotification(notification);
      });
    }
  }

  /// Push an [EncapsuleNotification] to the overlay.
  ///
  /// Pass tags as [replacements] to pop existing notifications as the new one is added.
  ///
  @action
  void pushNotification(EncapsuleNotification item, [Set<String> _replacements = const <String>{}]) {
    assert(!notifications.contains(item));

    for (final observer in _observers) {
      try {
        observer.didPushEncapsuleNotification(item);
      } catch (_) {}
    }

    final replacements = [
      if (item.tag != null) item.tag!,
      ..._replacements,
    ];

    if (replacements.isNotEmpty) {
      notifications.removeWhere((item) => replacements.contains(item.tag));
      importantNotifications.removeWhere((item) => replacements.contains(item.tag));
    }

    _getAppropriateNotificationList(item).add(item);
  }

  /// Remove an [EncapsuleNotification] from the overlay.
  @action
  void dismissNotification(EncapsuleNotification item) {
    final didRemove = _getAppropriateNotificationList(item).remove(item);
    if (didRemove) item.onDismissed?.call();
  }

  @action
  void pushSheet(EncapsuleSheet item) {
    assert(!sheets.contains(item));
    assert(sheets.where((sheet) => sheet.tag != item.tag).isEmpty);

    sheets.add(item);
  }

  @action
  void removeSheet(EncapsuleSheet item) {
    final didRemove = sheets.remove(item);
    if (didRemove) item.onDismissed?.call();
  }

  @action
  void dismissNotificationsWhere(
    bool Function(EncapsuleNotification item) conditional, {
    bool includeImportant = true,
  }) =>
      [
        ...notifications.where(conditional).toList(growable: false),
        if (includeImportant) ...importantNotifications.where(conditional).toList(growable: false),
      ].forEach(dismissNotification);

  /// Dismiss all notifications.
  /// Dismissing them like this won't call [EncapsuleNotification.onDismissed].
  @action
  void dismissAllNotifications({bool includingUndismissible = false}) {
    notifications.removeWhere((item) => item.dismissible ? true : includingUndismissible);
    importantNotifications.removeWhere((item) => item.dismissible ? true : includingUndismissible);
  }

  void dispose() {
    _visibleNotificationReactionDisposer?.call();
  }

  /// Closes all sheets.
  bool closeSheets() {
    final closeSheets = EncapsuleStore.instance.sheets.isNotEmpty;
    EncapsuleStore.instance.sheets.clear();
    return closeSheets;
  }
}

mixin EncapsuleStoreObserver {
  void didPushEncapsuleNotification(EncapsuleNotification notification);
}
