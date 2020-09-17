library delayed_progress_indicator;

import 'dart:async';

import 'package:flutter/material.dart';

/// Delays the progress indicator from becoming visible, like in some
/// Material Design concepts.
class DelayedProgressIndicator extends StatefulWidget {
  const DelayedProgressIndicator({
    Key key,
    this.delay = const Duration(seconds: 3),
    this.size = 20,
  }) : super(key: key);

  /// Duration after which the progress indicator fades in.
  final Duration delay;

  /// Square size of the indicator,
  final double size;

  @override
  _DelayedProgressIndicatorState createState() => _DelayedProgressIndicatorState();
}

class _DelayedProgressIndicatorState extends State<DelayedProgressIndicator> with SingleTickerProviderStateMixin {
  Timer _timer;
  AnimationController _controller;

  void _setVisible() {
    assert(mounted);
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: kThemeChangeDuration);
    _timer = Timer(widget.delay, _setVisible);
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: RepaintBoundary(
          child: SizedBox.fromSize(
            size: Size.square(widget.size),
            child: CircularProgressIndicator(
              valueColor: ColorTween(
                begin: Colors.transparent,
                end: Theme.of(context).accentColor,
              ).animate(_controller),
            ),
          ),
        ),
      );
}
