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
    @required this.itemBuilder,
    @required this.itemCount,
    @required this.child,
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

  final Widget child;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final ValueChanged<int> onSelectedItemChanged;
  final double itemExtent;
  final double itemMagnification;
  final int selectedIndex;
  final DirectSelectMode mode;
  final Color backgroundColor;
  final HitTestBehavior hitTestBehavior;
  final bool allowScrollEnd;
  final List<Widget> overlayChildren;
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
    final mediaQuery = MediaQuery.of(context);
    final box = _key.currentContext.findRenderObject() as RenderBox;
    final offset = box?.localToGlobal(Offset.zero) ?? Offset.zero;
    final anchor = Rect.fromCenter(
      center: (offset & box.size).center,
      width: mediaQuery.size.width,
      height: widget.itemExtent * widget.itemMagnification,
    );

    return MySelectionOverlay(
      key: key,
      anchor: anchor,
      backgroundColor: widget.backgroundColor,
      overlayChildren: widget.overlayChildren,
      child: MySelectionList(
        controller: _controller,
        itemExtent: widget.itemExtent,
        itemMagnification: widget.itemMagnification,
        childCount: widget.itemCount,
        allowScrollEnd: widget.allowScrollEnd,
        onItemSelected: () => widget.mode == DirectSelectMode.tap ? removeOverlay() : null,
        builder: widget.itemBuilder,
        onItemChanged: (index) => _currentIndex = index ?? _currentIndex,
        anchor: anchor,
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
