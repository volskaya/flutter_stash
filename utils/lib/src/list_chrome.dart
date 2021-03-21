import 'package:flutter/material.dart';

class PredicateScrollBehavior extends MaterialScrollBehavior {
  const PredicateScrollBehavior([this.notificationPredicate = defaultNotificationPredicate]);

  final bool Function(ScrollNotification notification) notificationPredicate;

  static bool defaultNotificationPredicate(ScrollNotification notification) => notification.depth == 0;

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          axisDirection: details.direction,
          color: Theme.of(context).accentColor,
          notificationPredicate: notificationPredicate,
        );
    }
  }
}

class MaterialGlowingOverscrollIndicator extends StatelessWidget {
  const MaterialGlowingOverscrollIndicator({
    Key? key,
    required this.direction,
    required this.child,
    this.notificationPredicate = defaultNotificationPredicate,
  }) : super(key: key);

  final AxisDirection direction;
  final Widget child;
  final bool Function(ScrollNotification notification) notificationPredicate;

  static bool defaultNotificationPredicate(ScrollNotification x) => x.depth == 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          axisDirection: direction,
          color: theme.accentColor,
          notificationPredicate: notificationPredicate,
        );
    }
  }
}
