import 'dart:async';

/// An async memoizer that returns the value synchronously, if the future has finished.
class Memoizer<T> {
  /// Instantiate the [Memoizer] asynchronously.
  Memoizer({required Future<T> Function() future}) {
    _resolveFuture(future);
  }

  /// Instantiate the [Memoizer] synchronously.
  Memoizer.of(this.value) : _hasResolved = true;

  Future _resolveFuture(Future<T> Function() future) async {
    try {
      _future = future();
      final value = await _future;
      if (!_invalidated) this.value = value;
    } finally {
      _hasResolved = true;
      _future = null;
    }
  }

  Future<T>? _future;
  bool _hasResolved = false;
  bool _invalidated = false;

  /// Resolved value, if any.
  T? value;

  /// Whether the memoizer has resolved its future.
  bool get isCompleted {
    assert(value == null || _hasResolved);
    return _hasResolved;
  }

  /// Gets the future from the [Completer] or value, if the [Completer] has resolved already.
  Future<T?> get future {
    assert(!_invalidated);
    assert(_hasResolved || _future != null);
    return _hasResolved || _future == null ? Future<T?>.sync(() => value) : _future!;
  }

  /// Unreferences the value and resolves the future with null, if it's not resolved yet.
  void invalidate() {
    _hasResolved = true;
    _invalidated = true;
    _future = null;
    value = null;
  }
}
