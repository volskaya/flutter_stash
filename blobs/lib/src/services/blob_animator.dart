import 'package:flutter/material.dart';

class BlobAnimator {
  BlobAnimator({
    required this.pathPoints,
    required this.animationController,
    required this.onChanged,
    Curve curve = Curves.elasticOut,
  }) {
    final animation = CurvedAnimation(parent: animationController, curve: curve);

    for (int i = 0; i < pathPoints.length; i += 1) {
      tweens.insert(i, <Tween<double>>[]);
      anims.insert(i, <Animation<double>>[]);

      tweens[i].add(Tween<double>(begin: 0.0, end: 0.0));
      anims[i].add(tweens[i][0].animate(animation));

      tweens[i].add(Tween<double>(begin: 0.0, end: 0.0));
      anims[i].add(tweens[i][1].animate(animation));
    }

    animationController.addListener(_handleChange);
    morphTo(pathPoints);
  }

  final ValueChanged<List<Offset>> onChanged;
  final AnimationController animationController;
  final List<Offset> pathPoints;

  final tweens = <List<Tween<double>>>[];
  final anims = <List<Animation<double>>>[];

  void _handleChange() {
    final transitionPoints = List<Offset>.generate(
      anims.length,
      (i) => Offset(anims[i][0].value, anims[i][1].value),
    );

    onChanged(transitionPoints);
  }

  void morphTo(List<Offset> newPathPoints) {
    assert(tweens.length == newPathPoints.length);

    for (var i = 0; i < tweens.length; i += 1) {
      final tween = tweens[i];

      tween[0].begin = tween[0].end;
      tween[0].end = newPathPoints[i].dx + 5;

      tween[1].begin = tween[1].end;
      tween[1].end = newPathPoints[i].dy + 5;
    }

    animationController.reset();
    animationController.forward();
  }

  @mustCallSuper
  void dispose() {
    animationController.removeListener(_handleChange);
  }
}
