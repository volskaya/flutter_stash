import 'package:flutter/material.dart';
import 'package:refresh_storage/refresh_storage.dart';

import 'controller/controller.dart';

class NativeAdWidgetStateStorage extends RefreshStorageItem {
  NativeAdWidgetStateStorage({NativeAdOptions options})
      : controller = NativeAdController.firstReusable(options: options ?? const NativeAdOptions()) ??
            NativeAdController(options: options ?? const NativeAdOptions());

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
  RefreshStorageEntry<NativeAdWidgetStateStorage> storage;
  String get identifier;
  String _oldIdentifier;
  NativeAdController get controller => storage?.value?.controller;
  NativeAdOptions get options => const NativeAdOptions();

  NativeAdWidgetStateStorage _buildStorage() => NativeAdWidgetStateStorage(options: options);

  void _createStorage(String identifier) => storage = RefreshStorage.write<NativeAdWidgetStateStorage>(
        context: context,
        identifier: identifier,
        builder: _buildStorage,
      );

  void _checkOldController() {
    if (storage?.value?.controller?.considerThisOld() == true) {
      storage.dispose();
      RefreshStorage.destroy(context: context, identifier: identifier);

      // This will build a fresh controller and fetch a new ad.
      setState(
        () => storage = RefreshStorage.write<NativeAdWidgetStateStorage>(
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
    _createStorage(identifier);
    _checkOldController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @mustCallSuper
  @override
  void didUpdateWidget(covariant T oldWidget) {
    assert((() {
      final hasChanged = _oldIdentifier != null && _oldIdentifier != identifier;
      _oldIdentifier = identifier;
      return !hasChanged;
    })(), 'NativeAdWidgetState.identifier must not change troughout the lifecycle of the state');
    super.didUpdateWidget(oldWidget);
  }

  @mustCallSuper
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    storage?.dispose();
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
