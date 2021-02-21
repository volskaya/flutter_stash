import 'package:flutter/material.dart';
import 'package:refresh_storage/refresh_storage.dart';

import 'controller/controller.dart';

class _Storage extends RefreshStorageItem {
  _Storage({NativeAdOptions options})
      : controller = NativeAdController(
          options: options ?? const NativeAdOptions(),
        );

  final NativeAdController controller;

  @override
  void dispose([dynamic _]) {
    controller.dispose();
    super.dispose();
  }
}

/// State that persists a [NativeAdController] within the [RefreshStorage] as well as
/// rebuilding it, when the controller is considered old on `initState` or app coming
/// into the foreground.
abstract class NativeAdWidgetState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  RefreshStorageEntry<_Storage> _storage;
  String get identifier;
  List<String> get preloadIdentifiers => const <String>[];
  NativeAdController get controller => _storage?.value?.controller;
  NativeAdOptions get options => const NativeAdOptions();

  static void preloadControllers(
    BuildContext context,
    List<String> preloadIdentifiers, [
    NativeAdOptions options = const NativeAdOptions(),
  ]) {
    if (preloadIdentifiers.isEmpty) return;

    final createStorage = (String identifier) => RefreshStorage.write<_Storage>(
          context: context,
          identifier: identifier,
          builder: () => _Storage(options: options),
        );

    for (final identifier in preloadIdentifiers) {
      print('Preloading $identifier');
      RefreshStorageEntry<_Storage> storage = createStorage(identifier);

      // Refresh the storage, if the controller is too old.
      if (storage.value?.controller?.considerThisOld() == true) {
        storage.dispose();
        RefreshStorage.destroy(context: context, identifier: identifier);
        storage = createStorage(identifier);
      }

      assert(storage?.value?.controller?.considerThisOld() != true);
      storage.value?.controller?.load();
      storage.dispose();
    }
  }

  _Storage _buildStorage() => _Storage(options: options);

  RefreshStorageEntry<_Storage> _createStorage(String identifier) => RefreshStorage.write<_Storage>(
        context: context,
        identifier: identifier,
        builder: _buildStorage,
      );

  void _preloadControllers() {
    assert(preloadIdentifiers.where((v) => v == identifier).isEmpty); // Don't preload [identifier] itself.
    preloadControllers(context, preloadIdentifiers, options);
  }

  void _checkOldController() {
    if (_storage?.value?.controller?.considerThisOld() == true) {
      _storage.value.controller.dispose();
      RefreshStorage.destroy(context: context, identifier: identifier);

      // This will build a fresh controller and fetch a new ad.
      setState(
        () => _storage = RefreshStorage.write<_Storage>(
          context: context,
          identifier: identifier,
          builder: _buildStorage,
        ),
      );
    }
  }

  @mustCallSuper
  @override
  void initState() {
    print('Creating $identifier');
    _storage = _createStorage(identifier);
    _checkOldController();
    _preloadControllers();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @mustCallSuper
  @override
  void didUpdateWidget(covariant T oldWidget) {
    assert(identifier == identifier);
    super.didUpdateWidget(oldWidget);
  }

  @mustCallSuper
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _storage?.dispose();
    super.dispose();
  }

  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _checkOldController();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break; // Nothing to do.
    }

    super.didChangeAppLifecycleState(state);
  }
}
