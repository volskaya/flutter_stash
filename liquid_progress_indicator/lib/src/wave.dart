import 'dart:math' as math;

import 'package:flutter/material.dart';

class Wave extends StatefulWidget {
  const Wave({
    Key? key,
    required this.value,
    required this.color,
    required this.direction,
    this.waveDuration = const Duration(seconds: 2),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.randomStart = true,
  }) : super(key: key);

  final bool randomStart;
  final double value;
  final Color color;
  final Axis direction;
  final Duration waveDuration;
  final Duration duration;
  final Curve curve;

  @override
  _WaveState createState() => _WaveState();
}

class _WaveState extends State<Wave> with TickerProviderStateMixin {
  static final random = math.Random();

  late final AnimationController _waveController;
  late final AnimationController _valueController;
  late final Tween<double> _valueTween;
  late final Animation<double> _animation;
  late final Listenable _listenable;

  @override
  void initState() {
    super.initState();

    // Both animations notify the same [ChangeNotifier], which reclips [_WaveClipper].
    _waveController = AnimationController(
      vsync: this,
      duration: widget.waveDuration,
      value: widget.randomStart ? random.nextDouble() : 0,
    );

    _valueController = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: 1,
    );

    _maybeToggleWaveAnimation(widget.value);
    _listenable = Listenable.merge([_waveController, _valueController]);
    _valueTween = Tween<double>(begin: 0, end: widget.value);
    _animation = _valueTween.animate(
      CurvedAnimation(
        parent: _valueController,
        curve: widget.curve,
      ),
    );
  }

  bool _isWaveToggled = false;
  bool _isWaveValueAtBounds(double value) {
    assert(value <= _waveController.upperBound && value >= _waveController.lowerBound);
    return value == _waveController.lowerBound || value == _waveController.upperBound;
  }

  /// Wave does not have any visible curve, when the [_valueController]
  /// is at bounds. This method toggles on/off the wave animation, when
  /// the value changes.
  void _maybeToggleWaveAnimation(double value) {
    final isValueAtBounds = _isWaveValueAtBounds(value);
    if (isValueAtBounds && _isWaveToggled) {
      // If value stopped at bounds, stop animating the wave.
      _waveController.stop();
      _isWaveToggled = false;
    } else if (!isValueAtBounds && !_isWaveToggled) {
      // If value is within bounds, but still stopped, resume the wave.
      _waveController.repeat();
      _isWaveToggled = true;
    }
  }

  @override
  void didUpdateWidget(Wave oldWidget) {
    if (oldWidget.value != widget.value) {
      // When the wave is not animating, but the next value will,
      // toggle the animation on start of the width tween.
      final willValueAnimate = !_isWaveValueAtBounds(widget.value);
      _maybeToggleWaveAnimation(!willValueAnimate ? _animation.value : widget.value);

      // Animate.
      _valueController.stop();
      _valueTween.begin = _animation.value;
      _valueTween.end = widget.value;
      _valueController.forward(from: 0).whenComplete(() => _maybeToggleWaveAnimation(widget.value));
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _waveController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: ClipPath(
          child: Container(color: widget.color),
          clipper: _WaveClipper(
            reclip: _listenable,
            waveAnimation: _waveController,
            valueAnimation: _animation,
            direction: widget.direction,
          ),
        ),
      );
}

class _WaveClipper extends CustomClipper<Path> {
  _WaveClipper({
    required Listenable reclip,
    required this.waveAnimation,
    required this.valueAnimation,
    required this.direction,
  }) : super(reclip: reclip);

  final Animation waveAnimation;
  final Animation valueAnimation;
  final Axis direction;

  double get waveValue => waveAnimation.value;
  double get value => valueAnimation.value;

  @override
  Path getClip(Size size) {
    // Dampen the animation around the box edges.
    final curvedValue = value > 0.5 ? 1 - value : value;
    final curve = Curves.easeOutQuart.transformInternal(curvedValue);

    switch (direction) {
      case Axis.horizontal:
        return Path()
          ..addPolygon(_generateHorizontalWavePath(size, curve), false)
          ..lineTo(0.0, size.height)
          ..lineTo(0.0, 0.0)
          ..close();
      case Axis.vertical:
        return Path()
          ..addPolygon(_generateVerticalWavePath(size, curve), false)
          ..lineTo(size.width, size.height)
          ..lineTo(0.0, size.height)
          ..close();
      default:
        throw 'Unreachable';
    }
  }

  List<Offset> _generateHorizontalWavePath(Size size, double curve) {
    if (value == 0) {
      return <Offset>[Offset(0, 0), Offset(0, size.height)];
    } else if (value == 1) {
      return <Offset>[Offset(size.width, 0), Offset(size.width, size.height)];
    }

    final waveList = List<Offset>.filled(size.height.toInt() + 4, Offset.zero, growable: false);
    for (int i = -2; i < waveList.length - 2; i++) {
      final waveHeight = size.width / 40;
      final dx = math.sin((waveValue * 360 - i) % 360 * (math.pi / 180)) * waveHeight * curve + (size.width * value);
      waveList[i + 2] = Offset(dx, i.toDouble());
    }
    return waveList;
  }

  List<Offset> _generateVerticalWavePath(Size size, double curve) {
    if (value == 0) {
      return <Offset>[Offset(0, size.height), Offset(size.width, size.height)];
    } else if (value == 1) {
      return <Offset>[Offset(0, 0), Offset(size.width, 0)];
    }

    final waveList = List<Offset>.filled(size.height.toInt() + 4, Offset.zero, growable: false);
    for (int i = -2; i < waveList.length - 2; i++) {
      final waveHeight = size.height / 40;
      final dy = math.sin((waveValue * 360 - i) % 360 * (math.pi / 180)) * waveHeight * curve +
          (size.height - (size.height * value));
      waveList[i + 2] = Offset(i.toDouble(), dy);
    }
    return waveList;
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) => waveValue != oldClipper.waveValue;
}
