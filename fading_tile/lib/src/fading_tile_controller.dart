import 'package:fading_tile/src/fading_tile_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refresh_storage/refresh_storage.dart';

class FadingTileController extends StatefulWidget {
  const FadingTileController({
    Key? key,
    required this.child,
    this.staggerDuration = const Duration(milliseconds: 30),
    this.bucket,
    this.expectedItemCount,
    this.startFrom,
  }) : super(key: key);

  final Widget child;
  final Duration staggerDuration;
  final String? bucket;
  final int? expectedItemCount;
  final int? startFrom;

  static FadingTileCoordinator of(BuildContext context) => Provider.of<FadingTileCoordinator>(context, listen: false);

  @override
  _FadingTileControllerState createState() => _FadingTileControllerState();
}

class _FadingTileControllerState extends State<FadingTileController> {
  late final RefreshStorageEntry<FadingTileCoordinator> _storage;

  FadingTileCoordinator _createCoordinator() => FadingTileCoordinator(
        staggerDuration: widget.staggerDuration,
      );

  @override
  void initState() {
    final identifier = 'fading_tile_controller_${widget.bucket}';
    _storage = widget.bucket != null
        ? RefreshStorage.write(
            identifier: identifier,
            context: context,
            builder: _createCoordinator,
          )
        : RefreshStorageEntry(
            identifier,
            _createCoordinator(),
          );

    if (widget.startFrom != null) {
      _storage.value!.bumpMaxIndex(widget.startFrom!);
    }

    super.initState();
  }

  @override
  void dispose() {
    _storage.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FadingTileController oldWidget) {
    assert((oldWidget.expectedItemCount != null) == (widget.expectedItemCount != null));

    if (widget.expectedItemCount != null && oldWidget.expectedItemCount != widget.expectedItemCount) {
      // Do it in a postframe to allow widgets to build.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _storage.value?.bumpExpectedItemCount(widget.expectedItemCount!);
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => Provider<FadingTileCoordinator>.value(
        value: _storage.value!,
        child: widget.child,
      );
}
