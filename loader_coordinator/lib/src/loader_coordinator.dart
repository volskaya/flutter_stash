import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

/// A disposable reference counted object to track loaders in [LoaderCoordinator].
class LoaderDisposer {
  /// Removes the reference from the [LoaderCoordinator].
  void dispose() => LoaderCoordinator.instance._removeLoader(this);
}

/// Observable store for coordinating loader indicators.
class LoaderCoordinator {
  /// Static instance of [LoaderCoordinator].
  static final instance = LoaderCoordinator();

  /// True, when there are active loaders.
  final notifier = ValueNotifier<bool>(false);
  final _loaders = HashSet<LoaderDisposer>();

  Timer _timer;

  void _maybeToggleNotifier({bool instant = false}) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (instant || _timer != null) {
          _timer?.cancel();
          _timer = null;
          notifier.value = _loaders.isNotEmpty;
        }
      });

  void _scheduleNotifier() {
    if (!notifier.value) _timer ??= Timer(const Duration(seconds: 1), _maybeToggleNotifier);
  }

  /// Get a reference conuted [LoaderDisposer] and trigger the [LoaderCoordinator] notifier.
  LoaderDisposer touch({bool instant = false}) {
    final disposer = LoaderDisposer();
    _loaders.add(disposer);
    if (instant) {
      _maybeToggleNotifier(instant: instant);
    } else {
      _scheduleNotifier();
    }
    return disposer;
  }

  void _removeLoader(LoaderDisposer disposer) {
    _loaders.remove(disposer);

    if (_loaders.isEmpty) {
      _timer?.cancel();
      _timer = null;

      WidgetsBinding.instance.addPostFrameCallback(
        // Don't touch the notifier, if something got added again.
        (_) => _loaders.isEmpty ? notifier.value = false : null,
      );
    }
  }
}
