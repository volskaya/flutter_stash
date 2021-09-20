import 'package:encapsule/src/encapsule_notification_overlay.dart';
import 'package:encapsule/src/encapsule_store.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';

part 'encapsule_sheet.freezed.dart';

/// [EncapsuleSheet] body builder.
typedef EncapsuleSheetBuilder = Widget Function(BuildContext context, VoidCallback dismiss);

/// [EncapsuleSheet] body's container builder, that can optionally
/// animate with the route animation.
///
/// Route animation moves forward or in reverse as the sheet is dismissed/brought back up.
typedef EncapsuleSheetContainerBuilder = Widget
    Function(BuildContext context, Animation<double> routeAnimation, Widget sheetWidget);

/// [EncapsuleSheet]s aren't build the [EncapsuleScaffoldOverlay], instead
/// a reaction is supposed to be implemented in the apps navigator, that will build
/// the sheet from observing [EncapsuleScaffoldStore]. This is sort of a convenience
/// class for my own apps.
@freezed
class EncapsuleSheet with _$EncapsuleSheet {
  /// Creates [EncapsuleSheet].
  factory EncapsuleSheet({
    /// Tag to differentiate multiple active notifications.
    String? tag,

    /// Sheet body builder.
    required EncapsuleSheetBuilder builder,

    /// Sheet body's container builder.
    EncapsuleSheetContainerBuilder? containerBuilder,

    /// Callback on dismiss.
    VoidCallback? onDismissed,

    /// Wether the user is allowed to manually dismiss this notification.
    @Default(true) bool dismissible,
  }) = _EncapsuleSheet;

  EncapsuleSheet._();

  /// Get nearest [EncapsuleSheet] through the [BuildContext].
  static EncapsuleSheet of(BuildContext context) {
    try {
      return Provider.of<EncapsuleSheet>(context, listen: false);
    } catch (e) {
      print('No EncapsuleSheetProps found in the build context.'
          'Built widget is not a descendant of an EncapsuleScaffoldOverlay notification?');
      rethrow;
    }
  }

  /// Deliver this notification to the nearest [EncapsuleNotificationOverlayController].
  void push() => EncapsuleStore.instance.pushSheet(this);

  /// Remove this item from the [EncapsuleNotificationOverlayController].
  void dismiss() {
    assert(EncapsuleStore.instance.sheets.contains(this), 'Dismiss was called before push');
    EncapsuleStore.instance.removeSheet(this);
  }
}
