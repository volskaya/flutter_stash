import 'package:flutter/material.dart';

/// Every client is returned their own [RefreshStorageEntry]. This helps properly
/// unreference the cached value, to avoid memory leaks.
class RefreshStorageEntry<T> {
  /// Creates [RefreshStorageEntry].
  RefreshStorageEntry(this.identifier, this._value);

  /// [RefreshStorage] identifier that built this [RefreshStorageEntry].
  final String identifier;
  bool _disposed = false;

  /// The data, in [RefreshStorage], referenced by this [RefreshStorageEntry].
  T _value;

  /// The data, in [RefreshStorage], referenced by this [RefreshStorageEntry].
  T get value {
    assert(!_disposed, 'RefreshStorageEntry $identifier accessed after behing disposed');
    return _value;
  }

  /// Call the dispose after you're done using this [RefreshStorageEntry].
  @mustCallSuper
  void dispose() {
    assert(!_disposed);
    _disposed = true;
    _value = null;
  }
}
