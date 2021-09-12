import 'package:animations/src/inherited_animation/inherited_animation.dart';
import 'package:flutter/widgets.dart';

/// Handles the dependency logic for [InheritedAnimation].
///
/// This won't rebuild state, when [InheritedAnimation] notifies its listeners.
mixin InheritedAnimationMixin<T extends StatefulWidget> on State<T> {
  InheritedAnimation? inheritedAnimation;

  double get opacity => inheritedAnimation?.opacity ?? 1.0;
  double get scale => inheritedAnimation?.scale ?? 1.0;
  Offset get translation => inheritedAnimation?.translation ?? Offset.zero;

  @mustCallSuper
  void didChangeInheritedAnimation(InheritedAnimation? oldAnimation, InheritedAnimation? animation) {
    assert(inheritedAnimation == oldAnimation);
    inheritedAnimation = animation;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final animation = InheritedAnimation.of(context);
    if (inheritedAnimation != animation) {
      didChangeInheritedAnimation(inheritedAnimation, animation);
    }
  }

  @override
  void dispose() {
    inheritedAnimation?.removeListener(markNeedsBuild);
    super.dispose();
  }
}
