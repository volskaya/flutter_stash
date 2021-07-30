import 'package:carousel_slider/src/periodic_child_switcher_builder.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/material.dart';

class PeriodicChildSwitcher extends StatelessWidget {
  const PeriodicChildSwitcher({
    Key? key,
    required this.childCount,
    required this.childBuilder,
    this.shouldSkip,
    this.initialIndex,
    this.autoPlayInterval = const Duration(seconds: 10),
    this.autoPlay = true,
    this.fillColor = Colors.transparent,
    this.axis = Axis.horizontal,
    this.onChildChanged,
    this.builderKey,
  }) : super(key: key);

  final Duration autoPlayInterval;
  final bool Function()? shouldSkip;
  final int childCount;
  final int? initialIndex;
  final bool autoPlay;
  final IndexedWidgetBuilder childBuilder;
  final Color fillColor;
  final Axis axis;
  final void Function(int index)? onChildChanged;
  final Key? builderKey;

  @override
  Widget build(BuildContext context) => PeriodicChildSwitcherBuilder(
        key: builderKey,
        childCount: childCount,
        shouldSkip: shouldSkip,
        autoPlay: autoPlay,
        autoPlayInterval: autoPlayInterval,
        onChildChanged: onChildChanged,
        builder: (_, i) {
          final child = FancySwitcherTag(
            tag: i,
            child: childBuilder(context, i),
          );

          switch (axis) {
            case Axis.horizontal:
              return FancySwitcher.horizontal(fillColor: fillColor, child: child);
            case Axis.vertical:
              return FancySwitcher.vertical(fillColor: fillColor, child: child);
          }
        },
      );
}
