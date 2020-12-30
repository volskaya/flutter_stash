import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/material.dart';
import 'package:refresh_storage/src/refresh_builder.dart';

/// Wrapper around [RefreshBuilder] & provider of [RefreshController], which holds
/// the counter of refreshes.
///
/// Wrap this around scrollables, to add a pull to refresh behavior to the
/// scroll view.
class RefreshContainer extends StatelessWidget {
  /// Creates the [RefreshContainer] without the support for [NestedScrollView].
  const RefreshContainer({
    Key key,
    @required this.child,
    @required this.bucket,
    this.enforceSafeArea = false,
    this.fillColor = Colors.transparent,
    this.duration = const Duration(milliseconds: 300),
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.overscrollPredicate = defaultOverscrollIndicatorNotificationPredicate,
    this.controllerKey,
  }) : super(key: key);

  /// Transform the refresh indicator under the top safe area.
  final bool enforceSafeArea;

  /// Child should contain a scrollable, which will controll the scroll
  /// indicator in [RefreshContainer].
  // final Widget child;
  final Widget child;

  /// Page storage identifier, where this widget will preserve its refresh
  /// counter state.
  final String bucket;

  /// Switcher's background color.
  final Color fillColor;

  /// Switcher's animation duration.
  final Duration duration;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  /// Passes this key to the [RefreshBuilder], that this [RefreshContainer] wraps.
  final GlobalKey<RefreshController> controllerKey;

  /// A check that specifies whether a [OverscrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final OverscrollIndicatorNotificationPredicate overscrollPredicate;

  @override
  Widget build(BuildContext context) => RefreshBuilder(
        key: controllerKey,
        enforceSafeArea: enforceSafeArea,
        bucket: bucket,
        notificationPredicate: notificationPredicate,
        overscrollPredicate: overscrollPredicate,
        builder: (_, refresh) => FancySwitcher.vertical(
          fillColor: fillColor,
          duration: duration,
          child: FancySwitcherTag(
            tag: -refresh, // Have the switcher animate in reverse.
            child: child,
          ),
        ),
      );
}
