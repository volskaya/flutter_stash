import 'package:animations/src/inherited_animation/inherited_animation_listenable.dart';
import 'package:flutter/widgets.dart';

mixin InheritedAnimationMixin<T extends StatefulWidget> on State<T> {
  InheritedAnimationListenable? inheritedAnimation;

  double get opacity => inheritedAnimation?.opacity ?? 1.0;
  double get scale => inheritedAnimation?.scale ?? 1.0;
  double get rotation => inheritedAnimation?.rotation ?? 0.0;
  Offset get translation => inheritedAnimation?.translation ?? Offset.zero;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final animation = InheritedAnimationListenable.of(context);
    if (inheritedAnimation != animation) {
      inheritedAnimation?.removeListener(markNeedsBuild);
      inheritedAnimation = animation;
      inheritedAnimation?.addListener(markNeedsBuild);
    }
  }

  @override
  void dispose() {
    inheritedAnimation?.removeListener(markNeedsBuild);
    super.dispose();
  }
}
