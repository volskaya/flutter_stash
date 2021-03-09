import 'dart:async';

import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/material.dart';

class PeriodicChildSwitcher extends StatefulWidget {
  const PeriodicChildSwitcher({
    Key key,
    @required this.childCount,
    @required this.childBuilder,
    this.shouldSkip,
    this.initialIndex,
    this.autoPlayInterval = const Duration(seconds: 10),
    this.autoPlay = true,
    this.fillColor = Colors.transparent,
    this.axis = Axis.horizontal,
    this.onChildChanged,
  }) : super(key: key);

  final Duration autoPlayInterval;
  final bool Function() shouldSkip;
  final int childCount;
  final int initialIndex;
  final bool autoPlay;
  final IndexedWidgetBuilder childBuilder;
  final Color fillColor;
  final Axis axis;
  final void Function(int index) onChildChanged;

  @override
  PeriodicChildSwitcherState createState() => PeriodicChildSwitcherState();
}

class PeriodicChildSwitcherState extends State<PeriodicChildSwitcher> with WidgetsBindingObserver {
  Timer _metronome;
  int _currentIndex = 0;

  int get index => _currentIndex;

  void _handleTimerTick([dynamic _, bool allowSkip = true]) {
    assert(mounted);

    final shouldSkip = allowSkip ? widget.shouldSkip?.call() == true : false;

    if (widget.autoPlay && mounted && ModalRoute.of(context).isCurrent && !shouldSkip) {
      final next = _currentIndex + 1 < widget.childCount ? _currentIndex + 1 : 0;
      if (_currentIndex != next) {
        setState(() => _currentIndex = next);
        widget.onChildChanged?.call(next);
      }
    }
  }

  void _buildMetronome() {
    assert(_metronome?.isActive != true);
    _metronome?.cancel();
    _metronome = Timer.periodic(widget.autoPlayInterval, _handleTimerTick);
  }

  @override
  void initState() {
    if (widget.initialIndex != null) _currentIndex = widget.initialIndex;
    _buildMetronome();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PeriodicChildSwitcher oldWidget) {
    if (widget.childCount < oldWidget.childCount) {
      _handleTimerTick(null, false);
    }

    if (oldWidget.autoPlay != widget.autoPlay) {
      if (widget.autoPlay) {
        _buildMetronome();
      } else {
        _metronome?.cancel();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        if (widget.autoPlay && _metronome?.isActive != true) _buildMetronome();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _metronome?.cancel();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    _metronome?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = FancySwitcherTag(
      tag: _currentIndex,
      child: widget.childBuilder(context, _currentIndex),
    );

    switch (widget.axis) {
      case Axis.horizontal:
        return FancySwitcher.horizontal(
          fillColor: widget.fillColor,
          child: child,
        );
      case Axis.vertical:
        return FancySwitcher.vertical(
          fillColor: widget.fillColor,
          child: child,
        );
    }

    throw UnimplementedError();
  }
}
