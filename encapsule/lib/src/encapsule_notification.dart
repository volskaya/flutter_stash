import 'package:encapsule/src/encapsule_notification_overlay.dart';
import 'package:encapsule/src/encapsule_store.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';

part 'encapsule_notification.freezed.dart';

/// [EncapsuleNotification] body builder.
typedef EncapsuleNotificationBuilder = Widget Function(
  BuildContext overlayContext,
  VoidCallback dismiss,
  Animation<double>? timeoutAnimation,
);

/// Props provided to descending notifications.
@freezed
class EncapsuleNotificationProps with _$EncapsuleNotificationProps {
  /// Creates [EncapsuleNotificationProps].
  const factory EncapsuleNotificationProps({
    /// Callable to dismiss the notification.
    required VoidCallback dismiss,

    /// Progress animation of the notifications dismiss timeout.
    /// Is null when the notification is built without a timeout.
    Animation<double>? dismissAnimation,

    /// Reference to the [EncapsuleNotification] these props belong to.
    required EncapsuleNotification reference,
  }) = _EncapsuleNotificationProps;
  // const EncapsuleNotificationProps(this.dismiss, this.dismissAnimation, this.reference);

  /// Get [EncapsuleNotificationProps] provided through the [BuildContext].
  static EncapsuleNotificationProps of(BuildContext context) {
    try {
      return Provider.of<EncapsuleNotificationProps>(context, listen: false);
    } catch (e) {
      print('No EncapsuleNotificationProps found in the build context.'
          'Built widget is not a descendant of an EncapsuleScaffoldOverlay notification?');
      rethrow;
    }
  }
}

/// [EncapsuleNotification] that's used for [EncapsuleNotificationOverlay] overlay entries.
@freezed
class EncapsuleNotification with _$EncapsuleNotification {
  /// Creates [EncapsuleNotification].
  @Assert('timeout == null || timeout >= const Duration(seconds: 5)') @Assert('important == false || timeout == null')
  factory EncapsuleNotification({
    /// Tag to differentiate multiple active notifications.
    String? tag,

    /// Notification widget builder. If [timeout] is null, [timeoutAnimation] will be passed as null as well.
    required EncapsuleNotificationBuilder builder,

    /// Fade out time of the notification. Set null to keep the item on screen
    /// till user interaction.
    @Default(Duration(seconds: 5)) Duration? timeout,

    /// Callback on dismiss.
    VoidCallback? onDismissed,

    /// Dim the background behind the notification and intercept pop.
    @Default(false) bool important,

    /// Wether the user is allowed to manually dismiss this notification.
    @Default(true) bool dismissible,

    /// Reference to the previous [EncapsuleNotification].
    EncapsuleNotification? previous,
  }) = _EncapsuleNotification;

  EncapsuleNotification._();

  /// Deliver this notification to the nearest [EncapsuleNotificationOverlayController].
  void push([Set<String> replacements = const <String>{}]) =>
      EncapsuleStore.instance.pushNotification(this, replacements);

  /// Remove this item from the [EncapsuleNotificationOverlayController].
  void dismiss() {
    assert(EncapsuleStore.instance.notifications.contains(this), 'Dismiss was called before push');
    EncapsuleStore.instance.dismissNotification(this);
  }
}
