import 'dart:async';

/// An async memoizer that returns the value synchronously, if the future has finished.
class Memoizer<T> {
  /// Instantiate the [Memoizer] asynchronously.
  Memoizer({
    required Future<T> Function() future,
  }) : _completer = Completer<T?>() {
    _resolveFuture(future);
  }

  /// Instantiate the [Memoizer] synchronously.
  Memoizer.of(this.value)
      : _hasResolved = true,
        _completer = null;

  Future _resolveFuture(Future<T> Function() future) async {
    assert(!_invalidated);

    assert((() {
      Future.delayed(const Duration(seconds: 60), () {
        if (_completer?.isCompleted == false) throw '$hashCode completer is not complete after 60 seconds';
      });
      return true;
    })());

    try {
      final resolvedItem = await future();
      if (_invalidated) {
        assert(_completer?.isCompleted == true);
        return;
      }
      value = resolvedItem;
      _completer?.complete(resolvedItem);
    } catch (e) {
      _completer?.completeError(e);
    }

    _completer = null; // There's no need to hold on to the completer anymore.
    _hasResolved = true;
  }

  Completer<T?>? _completer;
  bool _hasResolved = false;
  bool _invalidated = false;

  /// Resolved value, if any.
  T? value;

  /// Whether the memoizer has resolved its future.
  bool get isCompleted => _completer?.isCompleted == true || value != null;

  /// Gets the future from the [Completer] or value, if the [Completer] has resolved already.
  Future<T?> get future {
    assert(!_invalidated);
    assert(_hasResolved || _completer != null);
    return _hasResolved || _completer == null ? Future<T?>.value(value) : _completer!.future;
  }

  /// Unreferences the value and resolves the future with null, if it's not resolved yet.
  void invalidate() {
    _invalidated = true;
    if (_completer?.isCompleted == false) _completer!.complete(value);
    _completer = null;
    value = null;
  }
}
