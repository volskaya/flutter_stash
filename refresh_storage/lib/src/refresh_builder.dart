import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refresh_storage/src/refresh_indicator.dart' as my;
import 'package:refresh_storage/src/refresh_storage.dart';

/// Page storage of [RefreshController].
class RefreshControllerStorage {
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
  final IndexedWidgetBuilder builder;

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

  RefreshControllerStorage _storage;

  /// Number of times this container has been refreshed.
  int get refreshes => _storage?.refreshes ?? 0;

  /// Refresh the controller.
  void refresh() {
    setState(() => _storage.refreshes += 1);
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
  Widget build(BuildContext context) => my.RefreshIndicator(
        onRefresh: _futureRefresh,
        offset: widget.enforceSafeArea ? Offset(0, MediaQuery.of(context).padding.top) : Offset.zero,
        notificationPredicate: widget.notificationPredicate,
        overscrollPredicate: widget.overscrollPredicate,
        child: Provider.value(
          value: this,
          child: widget.builder(context, refreshes),
        ),
      );
}
