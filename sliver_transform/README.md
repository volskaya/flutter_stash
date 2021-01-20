# Refresh Storage

Wrapper for Flutter's inbuilt PageStorage, supporting refreshes, dispose callbacks and overriding contexts, for when the storage should be reused in something like a picker.

Package also includes pull down to refresh widgets for wrapping lists.

All `RefreshStorage` storages, under `RefreshContainer` or `RefreshBuilder`, rebuild when calling `RefreshController.of(context).refresh()` or when triggering a `RefreshIndicator`.

## Examples

Check [Flutter Firestore](https://github.com/volskaya/flutter_firestore) for real usage.

###### Building the persistent storage within a StatefulWidget

```dart
_SomeWidgetPageStorage _storage;

@override
// Called from `didChangeDependencies` because [RefreshStorage] needs to access the [ModalRoute] safely.
//
// Dispose will be called, when the route pops and page storage is destroyed.
void didChangeDependencies() {
  super.didChangeDependencies();

  if (_storage == null) {
    _storage = RefreshStorage.write(
      context: context,
      identifier: 'unique_identifier_of_storage_per_route',
      builder: () => _SomeWidgetPageStorage(),
      dispose: (storage) => storage.item?.dispose(),
    );
  }
}
```
