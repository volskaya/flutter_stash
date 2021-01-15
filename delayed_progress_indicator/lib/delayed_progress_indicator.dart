library delayed_progress_indicator;

import 'dart:async';

import 'package:flutter/material.dart';

/// Delays the progress indicator from becoming visible, like in some
/// Material Design concepts.
class DelayedProgressIndicator extends StatefulWidget {
  const DelayedProgressIndicator({
    Key? key,
    this.delay = const Duration(seconds: 3),
    this.size = 16,
    this.center = true,
    this.color,
  }) : super(key: key);

  /// Duration after which the progress indicator fades in.
  final Duration delay;

  /// Square size of the indicator.
  final double size;

  /// Color of the indicator.
  final Color? color;

  /// Wrap the indicator in a [Center] widget.
  final bool center;

  @override
  _DelayedProgressIndicatorState createState() => _DelayedProgressIndicatorState();
}

class _DelayedProgressIndicatorState extends State<DelayedProgressIndicator>
    with SingleTickerProviderStateMixin<DelayedProgressIndicator> {
  late final Timer _timer;
  late final AnimationController _controller;

  void _setVisible() {
    assert(mounted);
    _controller.forward();
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: kThemeChangeDuration);
    _timer = Timer(widget.delay, _setVisible);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).indicatorColor;
    final indicator = RepaintBoundary(
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: CircularProgressIndicator(
          valueColor: ColorTween(begin: color.withOpacity(0), end: color).animate(_controller),
        ),
      ),
    );
    return widget.center ? Center(child: indicator) : indicator;
  }
}
