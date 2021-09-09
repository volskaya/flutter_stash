import 'package:animations/src/inherited_opacity/inherited_opacity.dart';
import 'package:flutter/material.dart';

class InheritedOpacityBuilder extends StatefulWidget {
  const InheritedOpacityBuilder({
    Key? key,
    required this.builder,
    this.child,
    this.debug = false,
  }) : super(key: key);

  final Widget Function(BuildContext context, double opacity, Widget? child) builder;
  final Widget? child;
  final bool debug;

  @override
  _InheritedOpacityBuilderState createState() => _InheritedOpacityBuilderState();
}

class _InheritedOpacityBuilderState extends State<InheritedOpacityBuilder>
    with InheritedOpacityMixin<InheritedOpacityBuilder> {
  @override
  bool get debug => widget.debug;

  @override
  Widget build(BuildContext context) => widget.builder(context, opacity, widget.child);
}

mixin InheritedOpacityMixin<T extends StatefulWidget> on State<T> {
  InheritedOpacityAnimation? inheritedOpacityAnimation;

  double get opacity => inheritedOpacityAnimation?.value ?? 1.0;
  bool get debug => false;

  @override
  void markNeedsBuild() {
    super.markNeedsBuild();
    if (debug) print(inheritedOpacityAnimation);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final animation = InheritedOpacityAnimation.of(context);
    if (inheritedOpacityAnimation != animation) {
      inheritedOpacityAnimation?.removeListener(markNeedsBuild);
      inheritedOpacityAnimation = animation;
      inheritedOpacityAnimation?.addListener(markNeedsBuild);
    }
  }

  @override
  void dispose() {
    inheritedOpacityAnimation?.removeListener(markNeedsBuild);
    super.dispose();
  }
}
