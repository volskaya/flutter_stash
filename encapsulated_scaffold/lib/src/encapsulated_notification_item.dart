import 'package:encapsulated_scaffold/src/encapsulated_notification_overlay.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'encapsulated_notification_item.freezed.dart';

/// [EncapsulatedNotificationItem] body builder.
typedef EncapsulatedNotificationItemBuilder = Widget Function(
  BuildContext overlayContext,
  VoidCallback dismiss,
  Animation<double>? timeoutAnimation,
);

/// Props provided to descending notifications.
@freezed
class EncapsulatedNotificationProps with _$EncapsulatedNotificationProps {
  /// Creates [EncapsulatedNotificationProps].
  const factory EncapsulatedNotificationProps({
    /// Callable to dismiss the notification.
    required VoidCallback dismiss,

    /// Progress animation of the notifications dismiss timeout.
    /// Is null when the notification is built without a timeout.
    Animation<double>? dismissAnimation,

    /// Reference to the [EncapsulatedNotificationItem] these props belong to.
    required EncapsulatedNotificationItem reference,
  }) = _EncapsulatedNotificationProps;
  // const EncapsulatedNotificationProps(this.dismiss, this.dismissAnimation, this.reference);

  /// Get [EncapsulatedNotificationProps] provided through the [BuildContext].
  static EncapsulatedNotificationProps of(BuildContext context) {
    try {
      return Provider.of<EncapsulatedNotificationProps>(context, listen: false);
    } catch (e) {
      print('No EncapsulatedNotificationProps found in the build context.'
          'Built widget is not a descendant of an EncapsulatedScaffoldOverlay notification?');
      rethrow;
    }
  }
}

/// [EncapsulatedNotificationItem] that's used for [EncapsulatedNotificationOverlay]
/// overlay entries.
@freezed
class EncapsulatedNotificationItem with _$EncapsulatedNotificationItem {
  /// Creates [EncapsulatedNotificationItem].
  @Assert('timeout == null || timeout >= const Duration(seconds: 5)') @Assert('important == false || timeout == null')
  factory EncapsulatedNotificationItem({
    /// Tag to differentiate multiple active notifications.
    String? tag,

    /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
    required EncapsulatedNotificationItemBuilder builder,

    /// Fade out time of the notification. Set null to keep the item on screen
    /// till user interaction.
    @Default(Duration(seconds: 5)) Duration? timeout,

    /// Callback on dismiss.
    VoidCallback? onDismissed,

    /// Dim the background behind the notification and intercept pop.
    @Default(false) bool important,

    /// Wether the user is allowed to manually dismiss this notification.
    @Default(true) bool dismissible,

    /// Reference to the previous [EncapsulatedNotificationItem].
    EncapsulatedNotificationItem? previous,
  }) = _EncapsulatedNotificationItem;

  EncapsulatedNotificationItem._();
  EncapsulatedScaffoldStore? _store;

  EncapsulatedScaffoldStore? get store => _store;
  set store(EncapsulatedScaffoldStore? value) {
    assert(value == null || _store == null);
    _store = value;
  }

  /// Deliver this notification to the nearest [EncapsulatedNotificationOverlayController].
  void push(BuildContext context, [Set<String> replacements = const <String>{}]) {
    assert(_store == null);
    try {
      _store = EncapsulatedScaffoldStore.of(context)..pushNotification(this, replacements);
    } catch (_) {
      _store = null;
      rethrow;
    }
  }

  /// Remove this item from the [EncapsulatedNotificationOverlayController].
  void dismiss() {
    assert(_store != null, 'Dismiss was called before push');
    _store?.dismissNotification(this);
  }
}
