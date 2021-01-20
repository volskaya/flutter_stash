import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoaderDisposer {
  void dispose() => LoaderCoordinator.instance._removeLoader(this);
}

/// Observable store for coordinating loader indicators.
class LoaderCoordinator {
  /// Static instance of [LoaderCoordinator].
  static final instance = LoaderCoordinator();

  /// True, when there are active loaders.
  final notifier = ValueNotifier<bool>(false);
  final _loaders = HashSet<LoaderDisposer>();

  LoaderDisposer touch() {
    final disposer = LoaderDisposer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loaders.add(disposer);
      if (notifier.value != _loaders.isNotEmpty) notifier.value = _loaders.isNotEmpty;
    });
    return disposer;
  }

  void _removeLoader(LoaderDisposer disposer) => WidgetsBinding.instance.addPostFrameCallback((_) {
        _loaders.remove(disposer);
        if (notifier.value != _loaders.isNotEmpty) notifier.value = _loaders.isNotEmpty;
      });
}
