import 'dart:async';

import 'package:flutter/foundation.dart';

/// An async memoizer that returns the value synchronously, if the future has finished.
class Memoizer<T> {
  /// Instantiate the [Memoizer] asynchronously.
  Memoizer(Future<T> Function() future) {
    _resolveFuture(future);
  }

  /// Instantiate the [Memoizer] synchronously.
  Memoizer.of(this.value) : _hasResolved = true;

  Future _resolveFuture(Future<T> Function() future) async {
    assert(!_invalidated);

    try {
      final resolvedItem = await future();
      if (_invalidated) return;
      value = resolvedItem;
      _completer.complete(resolvedItem);
    } catch (e) {
      _completer.completeError(e);
    }

    _hasResolved = true;
  }

  final Completer<T?> _completer = Completer<T?>();
  bool _hasResolved = false;
  bool _invalidated = false;
  T? value;

  bool get isCompleted => _completer.isCompleted || value != null;

  /// If the value is ready, it is returned with a [SynchronousFuture].
  Future<T?> get future {
    assert(!_invalidated);
    return _hasResolved ? SynchronousFuture<T?>(value) : _completer.future;
  }

  void invalidate() {
    _invalidated = true;
    if (!_completer.isCompleted) _completer.complete();
  }
}
