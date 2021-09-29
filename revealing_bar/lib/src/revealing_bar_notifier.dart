import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revealing_bar/src/revealing_bar_notification.dart';
import 'package:revealing_bar/src/revealing_bar_pod.dart';

/// Listens to [ScrollNotification]s and pushes updates to nearest [RevealingBarController].
class RevealingBarNotifier extends ConsumerWidget {
  /// Creates [RevealingBarNotifier].
  const RevealingBarNotifier({
    Key? key,
    required this.child,
    this.local = 0,
    this.remote,
  })  : assert(local >= 0),
        assert(remote == null || remote > local),
        super(key: key);

  /// A global toggle to disable [RevealingBarNotifier]s from sending messages.
  @visibleForTesting static bool disable = false;

  /// Closest scroll controller index.
  final int local;

  /// Remote scroll controller index, in case of a nested scroll view.
  final int? remote;

  /// Child scrollable widget.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (disable) return child;

    final route = ModalRoute.of(context);
    final pod = ref.watch(RevealingBarPod.provider.notifier);

    return NotificationListener<ScrollNotification>(
      child: child,
      onNotification: (notification) {
        // Ignore notifications from animating out routes.
        if (route?.isCurrent != true || disable) return false;

        RevealingBarNotification? update;

        if (notification.depth == local) {
          update = RevealingBarNotification(
            localOffset: notification.metrics.pixels,
            maxExtent: notification.metrics.maxScrollExtent,
          );
        } else if (notification.depth == remote) {
          update = RevealingBarNotification(
            remoteOffset: notification.metrics.pixels,
            maxExtent: notification.metrics.maxScrollExtent,
          );
        }

        if (update != null) pod.push(update);
        return false;
      },
    );
  }
}
