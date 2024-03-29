import 'package:flutter/material.dart';
import 'package:direct_select/src/widget_drag.dart';

enum DirectSelectMode {
  /// The [DirectSelect] is engaged by dragging on it.
  drag,

  /// The [DirectSelect] is engaged by tapping on it.
  tap,
}

class DirectSelect extends StatelessWidget {
  const DirectSelect({
    @required this.itemBuilder,
    @required this.itemCount,
    @required this.onSelectedItemChanged,
    @required this.itemExtent,
    @required this.child,
    this.selectedIndex = 0,
    this.mode = DirectSelectMode.drag,
    this.itemMagnification = 1.15,
    this.backgroundColor = Colors.white,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.allowScrollEnd = false,
    this.overlayChildren = const <Widget>[],
    this.stateKey,
    this.ignoreInput = false,
    Key key,
  })  : assert(onSelectedItemChanged != null),
        assert(itemExtent != null),
        assert(child != null),
        assert(selectedIndex != null && selectedIndex >= 0 && selectedIndex < itemCount),
        assert(mode != null),
        assert(itemMagnification != null && itemMagnification >= 1.0),
        super(key: key);

  /// Widget child you'll tap to display the Selection List.
  final Widget child;

  /// List of Widgets you'll display after you tap the child.
  final IndexedWidgetBuilder itemBuilder;

  final int itemCount;

  /// Listener when you select any item from the Selection List.
  final ValueChanged<int> onSelectedItemChanged;

  /// Height of each Item of the Selection List.
  final double itemExtent;

  /// Amount of magnification when showing the selected item in the overlay.
  final double itemMagnification;

  /// Selected index of your selection list.
  final int selectedIndex;

  /// The preferred method to engage this widget.
  final DirectSelectMode mode;

  /// Color of the background, [Colors.white] by default.
  final Color backgroundColor;

  /// [HitTestBehavior] of the gesture detector that's gonna wrap the child.
  final HitTestBehavior hitTestBehavior;

  /// Key of either [DirectSelectTapState] / [DirectSelectDragState].
  final GlobalKey<dynamic> stateKey;

  /// Whether to close the overlay, when scroll ends.
  final bool allowScrollEnd;

  /// Overlay children above the picker.
  final List<Widget> overlayChildren;

  /// Unassign gesture handlers from the internal [GestureDetector].
  final bool ignoreInput;

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case DirectSelectMode.drag:
      case DirectSelectMode.tap:
        return DirectSelectDrag(
          key: stateKey,
          selectedIndex: selectedIndex,
          mode: mode,
          itemMagnification: itemMagnification,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
          onSelectedItemChanged: onSelectedItemChanged,
          itemExtent: itemExtent,
          backgroundColor: backgroundColor,
          child: child,
          hitTestBehavior: hitTestBehavior,
          allowScrollEnd: allowScrollEnd,
          overlayChildren: overlayChildren,
          ignoreInput: ignoreInput,
        );
    }
    throw UnimplementedError('Unknown DirectSelectMode provided: $mode');
  }
}
