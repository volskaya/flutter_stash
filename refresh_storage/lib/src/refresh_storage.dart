// ignore_for_file:avoid_classes_with_only_static_members

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refresh_storage/src/refresh_builder.dart';
import 'package:refresh_storage/src/refresh_storage_entry.dart';

/// Implementation of [RefreshStorage] items.
abstract class RefreshStorageItem {
  bool _isDisposed = false;

  /// Called when the [RefreshStorage] is being destroyed and its cached values with it.
  @mustCallSuper
  void dispose([dynamic _]) {
    assert(!_isDisposed);
    _isDisposed = true;
  }
}

/// [RefreshStorage] abstracts [PageStorage], allowing to dispose data manually and
/// being aware of refreshes.
///
/// This widget is intended to be wrapped around a [Page] to allow the widgets
/// within to cache and refresh their data with [RefreshBuilder].
class RefreshStorage extends StatefulWidget {
  /// Creates [RefreshStorage].
  const RefreshStorage({
    Key key,
    @required this.child,
  }) : super(key: key);

  /// The child of [RefreshStorage]. All descending widgets will cache their data in the state here.
  final Widget child;

  /// Gets the nearest [RefreshStorageState].
  static RefreshStorageState of(BuildContext context) => Provider.of<RefreshStorageState>(context, listen: false);

  /// Write and get a value from [PageStorage]. Data are built with `builder`
  /// and are built only once.
  ///
  /// This function is intended to be called from [StatefulWidget.didChangeDependencies].
  /// Write only once and store the reference in your state!
  ///
  /// [RefreshStorage] will call dispose when a new refresh is used with the
  /// same identifier or when the route pops.
  static RefreshStorageEntry<T> write<T extends RefreshStorageItem>({
    @required BuildContext context,
    @required String identifier,
    @required T Function() builder,
    int refreshes,
    RefreshStorageState storage,
    ModalRoute route,
  }) {
    final _refreshes = refreshes ?? RefreshController.of(context)?.refreshes ?? 0;
    final targetStorage = storage ?? RefreshStorage.of(context);

    assert(_refreshes >= 0);
    var item = targetStorage._cache[identifier.hashCode] as MapEntry<int, T>;

    if ((item?.key ?? -1) < _refreshes) {
      // Dispose the previous refresh.
      if (item?.value != null) WidgetsBinding.instance.addPostFrameCallback(item.value.dispose);

      // Build the new item.
      item = MapEntry(_refreshes, builder());
      targetStorage._cache[identifier.hashCode] = item;
    }

    return RefreshStorageEntry<T>(identifier, item.value);
  }

  @override
  RefreshStorageState createState() => RefreshStorageState();
}

/// Persistent state cache of [RefreshStorage] items that should be disposed along with a [Page].
class RefreshStorageState extends State<RefreshStorage> {
  /// Keyed by identifier string -> refresh count and the item.
  final _cache = HashMap<int, MapEntry<int, RefreshStorageItem>>();

  @override
  void dispose() {
    for (final item in _cache.values) item.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Provider<RefreshStorageState>.value(
        value: this,
        child: widget.child,
      );
}
