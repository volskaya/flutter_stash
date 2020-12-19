import 'package:encapsulated_scaffold/src/encapsulated_notification_overlay.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'encapsulated_sheet_item.freezed.dart';

/// [EncapsulatedNotificationItem] body builder.
typedef EncapsulatedSheetItemBuilder = Widget Function(BuildContext context, VoidCallback dismiss);

/// [EncapsulatedNotificationItem] body's container builder, that can optionally
/// animate with the route animation.
///
/// Route animation moves forward or in reverse as the sheet is dismissed/brought back up.
typedef EncapsulatedSheetItemContainerBuilder = Widget Function(
    BuildContext context, Animation<double> routeAnimation, Widget sheetWidget);

/// Dyamic button builder of [EncapsulatedSheetItem].
typedef EncapsulatedSheetButtonBuilder<T> = List<T> Function(BuildContext context);

/// [EncapsulatedSheetItem]s aren't build the [EncapsulatedScaffoldOverlay], instead
/// a reaction is supposed to be implemented in the apps navigator, that will build
/// the sheet from observing [EncapsulatedScaffoldStore]. This is sort of a convenience
/// class for my own apps.
@freezed
abstract class EncapsulatedSheetItem<T> implements _$EncapsulatedSheetItem<T> {
  /// Creates [EncapsulatedSheetItem].
  factory EncapsulatedSheetItem({
    /// Tag to differentiate multiple active notifications.
    String tag,

    /// Sheet body builder.
    @required EncapsulatedSheetItemBuilder builder,

    /// Sheet body's container builder.
    EncapsulatedSheetItemContainerBuilder containerBuilder,

    /// List of buttons.
    EncapsulatedSheetButtonBuilder<T> buttons,

    /// Callback on dismiss.
    VoidCallback onDismissed,

    /// Wether the user is allowed to manually dismiss this notification.
    @Default(true) bool dismissible,
  }) = _EncapsulatedSheetItem<T>;

  EncapsulatedSheetItem._();
  EncapsulatedScaffoldStore _store;

  /// Get nearest [EncapsulatedSheetItem] through the [BuildContext].
  static EncapsulatedSheetItem of(BuildContext context) {
    try {
      return Provider.of<EncapsulatedSheetItem>(context, listen: false);
    } catch (e) {
      print('No EncapsulatedSheetProps found in the build context.'
          'Built widget is not a descendant of an EncapsulatedScaffoldOverlay notification?');
      rethrow;
    }
  }

  /// Deliver this notification to the nearest [EncapsulatedNotificationOverlayController].
  void push(BuildContext context) {
    try {
      _store = EncapsulatedScaffoldStore.of(context);
      _store.pushSheet(this);
    } catch (_) {
      _store = null;
      rethrow;
    }
  }

  /// Remove this item from the [EncapsulatedNotificationOverlayController].
  void dismiss() {
    assert(_store != null, 'Dismiss was called before push');
    _store?.removeSheet(this);
  }
}
