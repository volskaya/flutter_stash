import 'package:flutter/material.dart';

class PredicateScrollBehavior extends MaterialScrollBehavior {
  const PredicateScrollBehavior([
    this.notificationPredicate = defaultNotificationPredicate,
  ]);

  final bool Function(ScrollNotification notification) notificationPredicate;

  static bool defaultNotificationPredicate(ScrollNotification notification) => notification.depth == 0;

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    final theme = Theme.of(context);
    final indicator = theme.androidOverscrollIndicator ?? androidOverscrollIndicator;

    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
        switch (indicator) {
          case AndroidOverscrollIndicator.stretch:
            return StretchingOverscrollIndicator(
              axisDirection: details.direction,
              child: child,
              notificationPredicate: notificationPredicate,
            );
          case AndroidOverscrollIndicator.glow:
            continue glow;
        }
      glow:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          axisDirection: details.direction,
          color: theme.colorScheme.primary,
          child: child,
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

    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return child;
      case TargetPlatform.android:
        switch (theme.androidOverscrollIndicator ?? AndroidOverscrollIndicator.glow) {
          case AndroidOverscrollIndicator.stretch:
            return StretchingOverscrollIndicator(
              axisDirection: direction,
              child: child,
              notificationPredicate: notificationPredicate,
            );
          case AndroidOverscrollIndicator.glow:
            continue glow;
        }
      glow:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          axisDirection: direction,
          color: theme.colorScheme.primary,
          child: child,
          notificationPredicate: notificationPredicate,
        );
    }
  }
}
