import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:refresh_storage/src/refresh_counter_pod.dart';
import 'package:refresh_storage/src/refresh_indicator.dart' as my;

/// Child builder of [RefreshBuilder].
typedef RefreshChildBuilder = Widget Function(BuildContext context, String? bucket, int refresh);

/// [Notification] that's dispatched when the [RefreshBuilder] refreshes.
class RefreshControllerNotication extends Notification {
  /// Creates [RefreshStorageNotification].
  RefreshControllerNotication(this.refresh);

  /// At which refresh is the builder at, when the notification was dispatched.
  final int refresh;
}

/// Refresh indicator & provider of [RefreshController], which holds
/// the counter of refreshes.
///
/// Wrap this around scrollables, to add a pull to refresh behavior to the
/// scroll view.
class RefreshBuilder extends ConsumerWidget {
  /// Creates the [RefreshBuilder] without the support for [NestedScrollView].
  const RefreshBuilder({
    Key? key,
    required this.builder,
    required this.bucket,
    this.enforceSafeArea = false,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.overscrollPredicate = defaultOverscrollIndicatorNotificationPredicate,
  }) : super(key: key);

  /// Transform the refresh indicator under the top safe area.
  final bool enforceSafeArea;

  /// Child should contain a scrollable, which will controll the scroll
  /// indicator in [RefreshBuilder].
  final RefreshChildBuilder builder;

  /// Page storage identifier, where this widget will preserve its refresh
  /// counter state.
  final String bucket;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final ScrollNotificationPredicate notificationPredicate;

  /// A check that specifies whether a [OverscrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`. Set it to something
  /// else for more complicated layouts.
  final OverscrollIndicatorNotificationPredicate overscrollPredicate;

  @override
  Widget build(BuildContext context, WidgetRef ref) => my.RefreshIndicator(
        offset: enforceSafeArea ? Offset(0, MediaQuery.of(context).padding.top) : Offset.zero,
        notificationPredicate: notificationPredicate,
        overscrollPredicate: overscrollPredicate,
        child: _Builder(bucket: bucket, builder: builder),
        onRefresh: () async {
          final newRefreshes = ref.read(RefreshCounterPod.provider.notifier).refresh();
          RefreshControllerNotication(newRefreshes).dispatch(context);
        },
      );
}

class _Builder extends ConsumerWidget {
  const _Builder({
    Key? key,
    required this.bucket,
    required this.builder,
  }) : super(key: key);

  final String bucket;
  final RefreshChildBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final refreshes = ref.watch(RefreshCounterPod.provider); // Keep the state live.
    // print('Refreshes in the actual builder: $refreshes');

    // ref.listen(RefreshCounterPod.provider, (_) {
    //   print('Refreshes in the listener: $refreshes');
    // });

    return builder(context, bucket, ref.watch(RefreshCounterPod.provider));
  }
}
