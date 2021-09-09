/// Implementation of [RefreshStorage] items.
abstract class RefreshStorageItem {
  /// Called when the [RefreshStorage] is being destroyed and its cached values with it.
  void dispose([dynamic _]) {}
}

/// Basic extension of [RefreshStorageItem].
class BasicRefreshStorageItem<T> extends RefreshStorageItem {
  /// Creates [BasicRefreshStorageItem].
  BasicRefreshStorageItem(this.value);

  /// Value of [BasicRefreshStorageItem].
  final T value;
}
