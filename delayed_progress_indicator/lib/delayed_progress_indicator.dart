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
    this.size = 16,
    this.center = true,
    this.color,
    this.optimizeOut = true,
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

  @override
  _DelayedProgressIndicatorState createState() => _DelayedProgressIndicatorState();
}

class _DelayedProgressIndicatorState extends State<DelayedProgressIndicator>
    with SingleTickerProviderStateMixin<DelayedProgressIndicator> {
  Timer? _timer;
  AnimationController? _controller;
  bool _visible = false;

  void _setVisible() {
    assert(mounted);
    _controller?.forward();
    setState(() => _visible = true);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: kThemeChangeDuration);

    if (widget.delay > Duration.zero) {
      _timer = Timer(widget.delay * timeDilation, _setVisible);
    } else {
      _visible = true;
      _controller!.value = 1.0;
    }

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).indicatorColor;
    final indicator = SizedBox.fromSize(
      size: Size.square(widget.size),
      child: widget.optimizeOut && !_visible
          ? null
          : RepaintBoundary(
              child: CircularProgressIndicator(
                valueColor: ColorTween(begin: color.withOpacity(0), end: color).animate(_controller!),
              ),
            ),
    );
    return widget.center ? Center(child: indicator) : indicator;
  }
}
