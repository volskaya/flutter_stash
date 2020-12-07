import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:refresh_storage/src/refresh_indicator.dart' as my;
import 'package:refresh_storage/src/nested_refresh_indicator.dart' as my;
import 'package:refresh_storage/src/refresh_storage.dart';

class _Storage {
  int refreshes = 0;
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
  })  : _wrappedAroundNestedScrollview = false,
        super(key: key);

  /// Creates the [RefreshBuilder] with support for [NestedScrollView].
  const RefreshBuilder.nested({
    Key key,
    @required this.builder,
    @required this.bucket,
    this.enforceSafeArea = false,
  })  : _wrappedAroundNestedScrollview = true,
        super(key: key);

  /// Transform the refresh indicator under the top safe area.
  final bool enforceSafeArea;

  /// Child should contain a scrollable, which will controll the scroll
  /// indicator in [RefreshBuilder].
  final IndexedWidgetBuilder builder;

  /// Page storage identifier, where this widget will preserve its refresh
  /// counter state.
  final String bucket;

  final bool _wrappedAroundNestedScrollview;

  @override
  RefreshController createState() => RefreshController();
}

/// Provider of [RefreshController] and state of [RefreshBuilder].
class RefreshController extends State<RefreshBuilder> {
  /// Get a reference to above [RefrshController].
  /// Returns null, if there are none.
  static RefreshController of(BuildContext context) {
    try {
      return Provider.of<RefreshController>(context, listen: false);
    } catch (e) {
      return null;
    }
  }

  _Storage _storage;

  /// Number of times this container has been refreshed.
  int get refreshes => _storage?.refreshes ?? 0;

  /// Refresh the controller.
  void refresh() => setState(() => _storage.refreshes += 1);
  Future _futureRefresh() async => refresh();

  Widget _buildChild(int refreshes) => KeyedSubtree(
        key: ValueKey(refreshes),
        child: widget.builder(context, refreshes),
      );

  @override
  void initState() {
    _storage = RefreshStorage.write(
      context: context,
      identifier: widget.bucket + '_refresh_builder',
      refreshes: 0, // Never refresh this storage.
      builder: () => _Storage(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final child = Provider.value(
      value: this,
      child: FancySwitcher.vertical(
        child: _buildChild(refreshes),
      ),
    );

    final offset = widget.enforceSafeArea ? Offset(0, MediaQuery.of(context).padding.top) : Offset.zero;

    return widget._wrappedAroundNestedScrollview
        ? my.NestedRefreshIndicator(
            onRefresh: _futureRefresh,
            offset: offset,
            child: child,
          )
        : my.RefreshIndicator(
            onRefresh: _futureRefresh,
            offset: offset,
            child: child,
          );
  }
}
