import 'package:fading_tile/src/fading_tile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

mixin FadingTileWidget on StatefulWidget {
  int get index;
  VoidCallback? getPaginator(int index) {}
}

mixin FadingTileStateMixin<T extends FadingTileWidget> on State<T> {
  AnimationController? fadeAnimationController; // Do not dispose this controller.
  VoidCallback? _onIndexUnregister;

  void _handleUnregisterCallback() {
    _onIndexUnregister?.call();
    _onIndexUnregister = null;
  }

  void _handleIndexChange() {
    _handleUnregisterCallback();

    final controller = FadingTileController.of(context);
    fadeAnimationController = controller.getController(widget.index);
    controller.registerIndex(widget.index);
    _onIndexUnregister = () => controller.unregisterIndex(widget.index);
  }

  @override
  void initState() {
    super.initState();
    _handleIndexChange();
    SchedulerBinding.instance!.scheduleTask(() => widget.getPaginator(widget.index)?.call(), Priority.touch);
  }

  @override
  void dispose() {
    _handleUnregisterCallback();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    if (oldWidget.index != widget.index) _handleIndexChange();
    super.didUpdateWidget(oldWidget);
  }
}
