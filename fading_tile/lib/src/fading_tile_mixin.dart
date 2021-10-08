import 'package:fading_tile/src/fading_tile_coordinator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

mixin FadingTileWidget on StatefulWidget {
  /// Index of the child in the list.
  int get index;

  /// Duration of the animation.
  Duration get duration;
  VoidCallback? getPaginator(int index) {}
}

mixin FadingTileStateMixin<T extends FadingTileWidget> on State<T>, TickerProvider {
  late final FadingTileCoordinator _coordinator;

  AnimationController? fadeAnimationController; // Do not dispose this controller.
  Animation<double>? fadeAnimation;
  bool _isAnimating = false;

  void _handleAnimationStatus(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        if (!_isAnimating) {
          _isAnimating = true;
          _coordinator.registerAnimatingIndex(widget.index);
        }
        break;
      case AnimationStatus.completed:
        if (_isAnimating) {
          _isAnimating = false;
          _coordinator.unregisterAnimatingIndex(widget.index, didComplete: true);
        }
        break;
      case AnimationStatus.dismissed:
        throw UnsupportedError('The controllers are expected to move only in 1 direction');
    }
  }

  @override
  void initState() {
    super.initState();

    _coordinator = FadingTileCoordinator.of(context)..registerIndex(widget.index);
    _coordinator.requestFade(widget.index, this, fadeDuration: widget.duration)?.map(
      (v) {
        fadeAnimation = fadeAnimationController = v.controller
          ..addStatusListener(_handleAnimationStatus)
          ..forward();
      },
      delayed: (v) {
        fadeAnimation = CurveTween(curve: v.interval).animate(v.controller);
        fadeAnimationController = v.controller
          ..addStatusListener(_handleAnimationStatus)
          ..forward();
      },
      inProgress: (v) {
        fadeAnimation = fadeAnimationController = v.controller
          ..addStatusListener(_handleAnimationStatus)
          ..forward(from: v.progress);
      },
    );

    final paginator = widget.getPaginator(widget.index);
    if (paginator != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (mounted) paginator();
      });
    }
  }

  @override
  void dispose() {
    fadeAnimationController?.dispose();
    if (_isAnimating) {
      _coordinator.unregisterAnimatingIndex(widget.index);
      _isAnimating = false;
    }
    _coordinator.unregisterIndex(widget.index);

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    assert(oldWidget.index == widget.index);
    super.didUpdateWidget(oldWidget);
  }
}
