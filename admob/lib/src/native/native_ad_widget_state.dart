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
  NativeAdController get controller => _storage?.value?.controller;
  NativeAdOptions get options => const NativeAdOptions();

  _Storage _buildStorage() => _Storage(options: options);

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
    _storage = RefreshStorage.write<_Storage>(
      context: context,
      identifier: identifier,
      builder: _buildStorage,
    );

    _checkOldController();
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
