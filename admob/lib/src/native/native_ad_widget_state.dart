import 'package:flutter/material.dart';
import 'package:refresh_storage/refresh_storage.dart';

import 'controller/controller.dart';

class NativeAdWidgetStateStorage extends RefreshStorageItem {
  NativeAdWidgetStateStorage({String options = NativeAdOptions.defaultKey})
      : controller = NativeAdController.reuseOrCreate(options: options ?? NativeAdOptions.defaultKey);

  final NativeAdController controller;

  @override
  void dispose([dynamic _]) {
    controller.dispose();
    super.dispose();
  }
}

mixin NativeAdWidget on StatefulWidget {
  String get identifier;
  String get options => NativeAdOptions.defaultKey;
  NativeAdController get controller;
}

/// State that persists a [NativeAdController] within the [RefreshStorage] as well as
/// rebuilding it, when the controller is considered old on `initState` or app coming
/// into the foreground.
abstract class NativeAdWidgetState<T extends NativeAdWidget> extends State<T> {
  RefreshStorageEntry<NativeAdWidgetStateStorage> storage;
  NativeAdController get controller => widget.controller ?? storage?.value?.controller;

  NativeAdWidgetStateStorage _buildStorage() => NativeAdWidgetStateStorage(options: widget.options);

  void _createStorage(String identifier) => storage = RefreshStorage.write<NativeAdWidgetStateStorage>(
        context: context,
        identifier: identifier,
        builder: _buildStorage,
      );

  void _checkOldController() {
    assert(widget.controller == null);

    if (storage?.value?.controller?.considerThisOld() == true) {
      storage.dispose();
      RefreshStorage.destroy(context: context, identifier: widget.identifier);

      // This will build a fresh controller and fetch a new ad.
      setState(
        () => storage = RefreshStorage.write<NativeAdWidgetStateStorage>(
          context: context,
          identifier: widget.identifier,
          builder: _buildStorage,
        ),
      );
    }
  }

  @mustCallSuper
  @override
  void initState() {
    if (widget.controller == null) {
      _createStorage(widget.identifier);
      _checkOldController();
    }

    assert(controller != null);
    super.initState();
  }

  @mustCallSuper
  @override
  void didUpdateWidget(covariant T oldWidget) {
    assert(oldWidget.controller?.id == widget.controller?.id);
    assert(oldWidget.identifier == widget.identifier);
    super.didUpdateWidget(oldWidget);
  }

  @mustCallSuper
  @override
  void dispose() {
    storage?.dispose();
    super.dispose();
  }
}
