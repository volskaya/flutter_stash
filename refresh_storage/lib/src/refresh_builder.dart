import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refresh_storage/src/refresh_indicator.dart' as my;
import 'package:refresh_storage/src/refresh_storage.dart';
import 'package:refresh_storage/src/refresh_storage_entry.dart';

/// Child builder of [RefreshBuilder].
typedef RefreshChildBuilder = Widget Function(BuildContext context, String bucket, int refresh);

/// Page storage of [RefreshController].
class RefreshControllerStorage extends RefreshStorageItem {
  /// Which refresh is the [RefreshController] set at.
  int refreshes = 0;
}

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
class RefreshBuilder extends StatefulWidget {
  /// Creates the [RefreshBuilder] without the support for [NestedScrollView].
  const RefreshBuilder({
    Key key,
    @required this.builder,
    @required this.bucket,
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
  RefreshController createState() => RefreshController();
}

/// Provider of [RefreshController] and state of [RefreshBuilder].
class RefreshController extends State<RefreshBuilder> {
  /// [RefreshContrtoller] appends this to bucket strings to avoid collisions.
  static const storageIdentifierPostfix = '_refresh_builder';

  /// Get a reference to above [RefrshController].
  /// Returns null, if there are none.
  static RefreshController of(BuildContext context) {
    try {
      return Provider.of<RefreshController>(context, listen: false);
    } catch (e) {
      return null;
    }
  }

  RefreshStorageEntry<RefreshControllerStorage> _storage;
  int _bucketChanges = 0; // Incremented every time the widget's bucket changes.

  /// Number of times this container has been refreshed.
  int get refreshes => (_storage?.value?.refreshes ?? 0) + _bucketChanges;

  /// Refresh the controller.
  void refresh() {
    if (_storage?.value != null) setState(() => _storage.value.refreshes += 1);
    RefreshControllerNotication(refreshes).dispatch(context);
  }

  Future _futureRefresh() async => refresh();

  @override
  void initState() {
    _storage = RefreshStorage.write(
      context: context,
      identifier: widget.bucket + RefreshController.storageIdentifierPostfix,
      refreshes: 0, // Never refresh this storage.
      builder: () => RefreshControllerStorage(),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RefreshBuilder oldWidget) {
    if (oldWidget.bucket != widget.bucket) {
      _storage?.dispose();
      _bucketChanges += 1;
      _storage = RefreshStorage.write(
        context: context,
        identifier: widget.bucket + RefreshController.storageIdentifierPostfix,
        refreshes: 0, // Never refresh this storage.
        builder: () => RefreshControllerStorage(),
      );

      // Get the storage early, in case the state is unmounted, and
      // destroy the old refresh storage item.
      final storage = RefreshStorage.of(context);
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => RefreshStorage.destroy(
          context: context,
          identifier: oldWidget.bucket + RefreshController.storageIdentifierPostfix,
          storage: storage,
        ),
      );
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _storage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => my.RefreshIndicator(
        onRefresh: _futureRefresh,
        offset: widget.enforceSafeArea ? Offset(0, MediaQuery.of(context).padding.top) : Offset.zero,
        notificationPredicate: widget.notificationPredicate,
        overscrollPredicate: widget.overscrollPredicate,
        child: Provider.value(
          value: this,
          child: widget.builder(context, widget.bucket, refreshes),
        ),
      );
}
