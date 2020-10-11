// ignore_for_file:avoid_classes_with_only_static_members

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:refresh_storage/src/refresh_builder.dart';

class _RefreshStorageItem<T> {
  _RefreshStorageItem({
    @required this.data,
    @required ValueChanged<T> dispose,
  })  : _dispose = dispose,
        isDisposable = dispose != null;

  // final String identifier;
  final T data;
  final ValueChanged<T> _dispose;
  final bool isDisposable;

  bool _isDisposed = false;

  /// [WillPopCallback] compatible dispose
  void dispose([dynamic _]) {
    if (!_isDisposed) {
      _isDisposed = true;
      _dispose?.call(data);
    }
  }
}

/// [RefreshStorage] abstracts [PageStorage], allowing to dispose data manually and
/// being aware of refreshes.
class RefreshStorage {
  /// Route -> Identifier -> Refresh count
  static final _disposedRefreshes = <ModalRoute, Map<String, int>>{};

  /// Write and get a value from [PageStorage]. Data are built with `builder`
  /// and are built only once.
  ///
  /// This function is intended to be called from [StatefulWidget.didChangeDependencies].
  /// Write only once and store the reference in your state!
  ///
  /// [RefreshStorage] will call dispose when a new refresh is used with the
  /// same identifier or when the route pops.
  static T write<T>({
    @required BuildContext context,
    @required String identifier,
    @required T Function() builder,
    ValueChanged<T> dispose,
    int refreshes,
    PageStorageBucket storage,
    ModalRoute route,
  }) {
    final _refreshes = refreshes ?? RefreshController.of(context)?.refreshes ?? 0;
    final targetStorage = storage ?? PageStorage.of(context);
    final targetRoute = route ?? ModalRoute.of(context);
    final id = '$_refreshes-$identifier';

    var item = targetStorage.readState(context, identifier: id) as _RefreshStorageItem<T>;
    _disposedRefreshes[targetRoute] ??= <String, int>{};
    _disposedRefreshes[targetRoute][identifier] ??= 0;

    if (item == null) {
      item = _RefreshStorageItem<T>(data: builder(), dispose: dispose);
      if (item.isDisposable) targetRoute.popped.then(item.dispose);
      targetStorage.writeState(context, item, identifier: id);
    }

    assert(_disposedRefreshes.containsKey(targetRoute) && _disposedRefreshes[targetRoute][identifier] != null);

    // Dispose storages of the previous refresh number
    WidgetsBinding.instance.addPostFrameCallback((_) {
      while (_disposedRefreshes[targetRoute][identifier] < _refreshes) {
        final oldRefresh = _disposedRefreshes[targetRoute][identifier];
        final oldId = '$oldRefresh-$identifier';
        final oldItem = targetStorage.readState(context, identifier: oldId) as _RefreshStorageItem<T>;
        _disposedRefreshes[targetRoute][identifier] += 1;
        targetStorage.writeState(context, null, identifier: oldId);
        if (oldItem?.isDisposable == true) oldItem.dispose();
      }

      assert((() {
        for (var i = 0; i < (_refreshes - 1); i++) {
          final id = '$i-$identifier';
          final item = targetStorage.readState(context, identifier: id) as _RefreshStorageItem<T>;

          // This storage was supposed to be deleted already
          if (item != null) return false;
        }

        return true;
      })(), 'Page storage contains undisposed refresh data');
    });

    return item.data;
  }
}
