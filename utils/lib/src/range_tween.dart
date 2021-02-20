import 'package:flutter/material.dart';

/// Allows to tween over a to b, while skipping a range inbetween.
class RangeTween<T extends num> extends Tween<double> {
  RangeTween({
    @required Offset begin,
    @required Offset end,
  })  : assert(begin.dy > begin.dx),
        assert(end.dx > begin.dy),
        assert(end.dy > begin.dx),
        sequence = _buildSequence(begin, end),
        super(begin: begin.dx, end: end.dy);

  final TweenSequence<double> sequence;

  static TweenSequence<double> _buildSequence(Offset begin, Offset end) => TweenSequence<double>(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: begin.dx, end: begin.dy),
            weight: begin.dy - begin.dx,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: end.dx, end: end.dy),
            weight: end.dy - end.dx,
          ),
        ],
      );

  @override
  double lerp(double t) {
    assert(begin != null);
    assert(end != null);

    return sequence.transform(t);
  }
}
