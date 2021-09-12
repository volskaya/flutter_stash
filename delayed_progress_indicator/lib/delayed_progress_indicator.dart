library delayed_progress_indicator;

import 'dart:async';
import 'dart:math' as math;

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Delays the progress indicator from becoming visible, like in some
/// Material Design concepts.
class DelayedProgressIndicator extends ImplicitlyAnimatedWidget {
  const DelayedProgressIndicator({
    Key? key,
    this.delay = const Duration(seconds: 1),
    this.size = 16.0,
    this.center = true,
    this.color,
    this.optimizeOut = true,
    this.toggled = true,
    this.strokeWidth = 4.0,
    this.opacity = 1.0,
  }) : super(
          key: key,
          duration: const Duration(milliseconds: 250),
          curve: standardEasing,
        );

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

  /// Opacity to apply to the indicator's color.
  final double opacity;

  @override
  _DelayedProgressIndicatorState createState() => _DelayedProgressIndicatorState();
}

class _DelayedProgressIndicatorState extends ImplicitlyAnimatedWidgetState<DelayedProgressIndicator>
    with TickerProviderStateMixin {
  late Listenable _listenable;
  late AnimationController _spinController;
  late AnimationController _toggleController;

  Animation<Color?>? _colorAnimation;
  Tween<Color?>? _colorTween;
  bool _isDelayAwaited = false;
  double get _opacity => math.min(_toggleController.value, widget.opacity);

  @override
  void forEachTween(TweenVisitor<Object?> visitor) {
    _colorTween = visitor(_colorTween, widget.color, (v) => ColorTween(begin: v as Color?)) as ColorTween;
  }

  @override
  void didUpdateTweens() {
    if (_colorTween != null) _colorAnimation = animation.drive(_colorTween!);
    super.didUpdateTweens();
  }

  /// This handler should be attached to [controller] and [_toggleController].
  void _handleSpinToggle() {
    // Don't spin while the indicator is invisible.
    final shouldSpin = _isDelayAwaited && _toggleController.value != 0.0 && _opacity > 0.0;

    if (shouldSpin && !_spinController.isAnimating) {
      _spinController.repeat();
    } else if (!shouldSpin && _spinController.isAnimating) {
      _spinController.stop();
    }
  }

  void _handleVisibilityChange() {
    if (!_isDelayAwaited || !mounted) {
      return; // Something changed while `_scheduleVisible` is still awaiting the delay.
    } else if (widget.toggled && !_toggleController.isCompleted) {
      _toggleController.forward();
    } else if (!widget.toggled && !_toggleController.isDismissed) {
      _toggleController.reverse();
    }

    _handleSpinToggle();
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
    // Duration is copied from Flutter ProgressIndicator's `_kIndeterminateCircularDuration`.
    _spinController = AnimationController(duration: const Duration(milliseconds: 1333 * 2222), vsync: this);
    _toggleController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    _listenable = Listenable.merge([_spinController, _toggleController, controller])..addListener(_handleSpinToggle);

    if (widget.delay > Duration.zero) {
      _scheduleVisible();
    } else {
      _isDelayAwaited = true;
      _toggleController.value = widget.toggled ? 1.0 : 0.0;
    }

    _handleSpinToggle();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DelayedProgressIndicator oldWidget) {
    assert(oldWidget.delay == widget.delay, 'The delay is not expected to change');
    assert((oldWidget.color != null) == (widget.color != null));

    if (oldWidget.toggled != widget.toggled) _handleVisibilityChange();
    if (oldWidget.opacity != widget.opacity) _handleSpinToggle();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _listenable.removeListener(_handleSpinToggle);
    _spinController.dispose();
    _toggleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox.fromSize(
      size: Size.square(widget.size),
      child: widget.optimizeOut && !_isDelayAwaited
          ? null
          : RepaintBoundary(
              child: AnimatedBuilder(
                animation: _listenable,
                builder: (context, __) => CircularProgressIndicator(
                  value: _spinController.value,
                  color: (_colorAnimation?.value ?? Theme.of(context).indicatorColor).withRelativeOpacity(_opacity),
                  strokeWidth: widget.strokeWidth,
                  willChange: _spinController.isAnimating,
                ),
              ),
            ),
    );

    return widget.center ? Center(child: indicator) : indicator;
  }
}
