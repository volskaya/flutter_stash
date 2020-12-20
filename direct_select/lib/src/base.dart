import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:direct_select/src/widget.dart';
import 'package:direct_select/src/overlay.dart';

class _FixedExtentScrollController extends FixedExtentScrollController {
  _FixedExtentScrollController(int initialItem) : super(initialItem: initialItem);

  /// Allow us to access the protected getter [ScrollController.positions].
  bool get hasScrollPositions => positions.isNotEmpty;
}

abstract class DirectSelectBase extends StatefulWidget {
  const DirectSelectBase({
    this.child,
    this.items,
    this.onSelectedItemChanged,
    this.itemExtent,
    this.itemMagnification,
    this.selectedIndex,
    this.mode,
    this.backgroundColor,
    this.hitTestBehavior,
    this.allowScrollEnd,
    this.overlayChildren,
    this.ignoreInput,
    Key key,
  }) : super(key: key);

  /// See: [DirectSelect.child]
  final Widget child;

  /// See: [DirectSelect.items]
  final List<Widget> items;

  /// See: [DirectSelect.onSelectedItemChanged]
  final ValueChanged<int> onSelectedItemChanged;

  /// See: [DirectSelect.itemExtent]
  final double itemExtent;

  /// See: [DirectSelect.itemMagnification]
  final double itemMagnification;

  /// See: [DirectSelect.selectedIndex]
  final int selectedIndex;

  /// See: [DirectSelect.mode]
  final DirectSelectMode mode;

  /// See: [DirectSelect.backgroundColor]
  final Color backgroundColor;

  /// See: [DirectSelect.hitTestBehavior]
  final HitTestBehavior hitTestBehavior;

  /// See: [DirectSelect.allowScrollEnd].
  final bool allowScrollEnd;

  /// See: [DirectSelect.overlayChildren].
  final List<Widget> overlayChildren;

  /// See: [DirectSelect.ignoreInput].
  final bool ignoreInput;

  @override
  DirectSelectBaseState createState();
}

abstract class DirectSelectBaseState<T extends DirectSelectBase> extends State<T> {
  _FixedExtentScrollController _controller;
  GlobalKey _key = GlobalKey();
  int _currentIndex;
  Completer<int> completer;

  Future<void> createOverlay();
  Future<void> removeOverlay();

  Future<int> open() => createOverlay();
  Future<void> close([int index]) async {
    if (index != null) _currentIndex = index;
    await removeOverlay();
  }

  bool _handleBackButton(bool intercepted, RouteInfo _) {
    if (intercepted || (completer?.isCompleted ?? true)) return false;
    removeOverlay();
    return true;
  }

  @override
  void initState() {
    _currentIndex = widget.selectedIndex;
    _controller = _FixedExtentScrollController(widget.selectedIndex);
    BackButtonInterceptor.add(_handleBackButton);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_handleBackButton);
    _controller.dispose();
    if (completer != null) removeOverlay();
    super.dispose();
  }

  @override
  void didUpdateWidget(DirectSelectBase oldWidget) {
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _currentIndex = widget.selectedIndex;
      _controller.dispose();
      _controller = _FixedExtentScrollController(widget.selectedIndex);
    }
    super.didUpdateWidget(oldWidget);
  }

  int notifySelectedItem() {
    widget.onSelectedItemChanged(_currentIndex);
    return _currentIndex;
  }

  Widget overlayWidget([Key key]) {
    final box = _key.currentContext.findRenderObject() as RenderBox;
    final position = box.localToGlobal(Offset.zero);
    final mediaQuery = MediaQuery.of(context);
    final half = mediaQuery.size.height / 2;
    final result = position.dy - mediaQuery.padding.top - half;

    return MySelectionOverlay(
      key: key,
      top: result + widget.itemExtent * widget.itemMagnification,
      backgroundColor: widget.backgroundColor,
      overlayChildren: widget.overlayChildren,
      child: MySelectionList(
        controller: _controller,
        itemExtent: widget.itemExtent,
        itemMagnification: widget.itemMagnification,
        childCount: widget.items != null ? widget.items.length : 0,
        allowScrollEnd: widget.allowScrollEnd,
        onItemSelected: () => widget.mode == DirectSelectMode.tap ? removeOverlay() : null,
        builder: (_, index) => widget.items != null ? widget.items[index] : const SizedBox.shrink(),
        onItemChanged: (index) => _currentIndex = index ?? _currentIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final preferTapMode = widget.mode == DirectSelectMode.tap;
    return GestureDetector(
      child: KeyedSubtree(key: _key, child: widget.child),
      behavior: widget.hitTestBehavior,
      onTap: !widget.ignoreInput && preferTapMode ? createOverlay : null,
      onVerticalDragStart: widget.ignoreInput || preferTapMode ? null : (_) => createOverlay(),
      onVerticalDragEnd: widget.ignoreInput || preferTapMode ? null : (_) => removeOverlay(),
      onVerticalDragUpdate: widget.ignoreInput || preferTapMode
          ? null
          : (details) =>
              _controller.hasScrollPositions ? _controller.jumpTo(_controller.offset - details.primaryDelta) : null,
    );
  }
}
