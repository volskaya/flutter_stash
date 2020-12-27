import 'dart:async';

import 'package:flutter/material.dart';
import 'package:direct_select/src/base.dart';
import 'package:direct_select/src/widget.dart';
import 'package:direct_select/src/overlay.dart';

class DirectSelectDrag extends DirectSelectBase {
  const DirectSelectDrag({
    @required Widget child,
    @required IndexedWidgetBuilder itemBuilder,
    @required int itemCount,
    ValueChanged<int> onSelectedItemChanged,
    double itemExtent,
    double itemMagnification,
    int selectedIndex,
    DirectSelectMode mode,
    Color backgroundColor,
    HitTestBehavior hitTestBehavior,
    bool allowScrollEnd,
    List<Widget> overlayChildren,
    bool ignoreInput,
    Key key,
  }) : super(
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
          key: key,
        );

  @override
  DirectSelectDragState createState() => DirectSelectDragState();
}

class DirectSelectDragState extends DirectSelectBaseState<DirectSelectDrag> {
  OverlayEntry _overlayEntry;
  GlobalKey<MySelectionOverlayState> _keyOverlay;

  @override
  Future<int> createOverlay() async {
    if (mounted) {
      OverlayState overlayState = Overlay.of(context);
      if (overlayState != null) {
        assert(completer == null);
        completer = Completer<int>();
        _overlayEntry = OverlayEntry(builder: (_) => overlayWidget(_keyOverlay));
        overlayState.insert(_overlayEntry);
        return completer.future;
      }
    }
    return null;
  }

  @override
  Future<void> removeOverlay() async {
    final currentState = _keyOverlay.currentState;
    if (currentState != null) {
      currentState.reverse(_overlayEntry);
    }
    final index = mounted ? notifySelectedItem() : null;
    completer?.complete(index);
    completer = null;
  }

  @override
  void initState() {
    _keyOverlay = GlobalKey();
    super.initState();
  }
}
