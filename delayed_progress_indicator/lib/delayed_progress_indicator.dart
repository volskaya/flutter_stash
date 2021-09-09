library delayed_progress_indicator;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Delays the progress indicator from becoming visible, like in some
/// Material Design concepts.
class DelayedProgressIndicator extends StatefulWidget {
  const DelayedProgressIndicator({
    Key? key,
    this.delay = const Duration(seconds: 1),
    this.size = 16.0,
    this.center = true,
    this.color,
    this.optimizeOut = true,
    this.toggled = true,
    this.strokeWidth = 4.0,
  }) : super(key: key);

  /// Duration after which the progress indicator fades in.
  final Duration delay;

  /// Square size of the indicator.
  final double size;

  /// Color of the indicator.
  final Color? color;

  /// Wrap the indicator in a [Center] widget.
  final bool center;

  /// While the delay hasn't kicked in yet replaces the [CircularProgressIndicator]
  /// with a [SizedBox], because the animation is still repainting, even though the
  /// circle has an invisible color.
  final bool optimizeOut;

  /// Whether the indicator should be in a toggled state.
  final bool toggled;

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  @override
  _DelayedProgressIndicatorState createState() => _DelayedProgressIndicatorState();
}

class _DelayedProgressIndicatorState extends State<DelayedProgressIndicator>
    with SingleTickerProviderStateMixin<DelayedProgressIndicator> {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  bool _isDelayAwaited = false;

  void _handleTweenChange() {
    final color = widget.color ?? Theme.of(context).indicatorColor;
    _colorAnimation = ColorTween(begin: color.withOpacity(0), end: color).animate(_controller);
  }

  void _handleVisibilityChange() {
    if (!_isDelayAwaited || !mounted) {
      return; // Something changed while `_scheduleVisible` is still awaiting the delay.
    } else if (widget.toggled && !_controller.isCompleted) {
      _controller.forward();
    } else if (!widget.toggled && !_controller.isDismissed) {
      _controller.reverse();
    }
  }

  Future _scheduleVisible() async {
    assert(widget.delay > Duration.zero);
    await Future.delayed(widget.delay * timeDilation);

    if (mounted) {
      _isDelayAwaited = true;
      _handleVisibilityChange();
      markNeedsBuild();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));

    if (widget.delay > Duration.zero) {
      _scheduleVisible();
    } else {
      _isDelayAwaited = true;
      _controller.value = widget.toggled ? 1.0 : 0.0;
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DelayedProgressIndicator oldWidget) {
    assert(oldWidget.delay == widget.delay, 'The delay is not expected to change');
    if (oldWidget.toggled != widget.toggled) _handleVisibilityChange();
    if (oldWidget.color != widget.color) _handleTweenChange();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _handleTweenChange();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox.fromSize(
      size: Size.square(widget.size),
      child: widget.optimizeOut && !_isDelayAwaited
          ? null
          : RepaintBoundary(
              child: CircularProgressIndicator(
                valueColor: _colorAnimation,
                strokeWidth: widget.strokeWidth,
              ),
            ),
    );

    return widget.center ? Center(child: indicator) : indicator;
  }
}
