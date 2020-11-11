part of direct_select_plugin;

abstract class _DirectSelectBase extends StatefulWidget {
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

  const _DirectSelectBase({
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

  @override
  DirectSelectBaseState createState();
}

abstract class DirectSelectBaseState<T extends _DirectSelectBase> extends State<T> {
  _FixedExtentScrollController _controller;
  GlobalKey _key = GlobalKey();
  int _currentIndex;
  Completer<int> completer;

  Future<void> _createOverlay();
  Future<void> _removeOverlay();

  Future<int> open() => _createOverlay();
  Future<void> close([int index]) async {
    if (index != null) _currentIndex = index;
    await _removeOverlay();
  }

  bool _handleBackButton(bool intercepted, RouteInfo _) {
    if (intercepted || (completer?.isCompleted ?? true)) return false;
    _removeOverlay();
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
    if (completer != null) _removeOverlay();
    super.dispose();
  }

  @override
  void didUpdateWidget(_DirectSelectBase oldWidget) {
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _currentIndex = widget.selectedIndex;
      _controller.dispose();
      _controller = _FixedExtentScrollController(widget.selectedIndex);
    }
    super.didUpdateWidget(oldWidget);
  }

  int _notifySelectedItem() {
    widget.onSelectedItemChanged(_currentIndex);
    return _currentIndex;
  }

  Widget _overlayWidget([Key key]) {
    final RenderBox box = _key.currentContext.findRenderObject();
    final position = box.localToGlobal(Offset.zero);
    final mediaQuery = MediaQuery.of(context);
    final half = mediaQuery.size.height / 2;
    final result = position.dy - mediaQuery.padding.top - half;
    return _MySelectionOverlay(
      key: key,
      top: result + widget.itemExtent * widget.itemMagnification,
      backgroundColor: widget.backgroundColor,
      overlayChildren: widget.overlayChildren,
      child: _MySelectionList(
        itemExtent: widget.itemExtent,
        itemMagnification: widget.itemMagnification,
        childCount: widget.items != null ? widget.items.length : 0,
        allowScrollEnd: widget.allowScrollEnd,
        onItemChanged: (index) {
          if (index != null) {
            _currentIndex = index;
          }
        },
        onItemSelected: () {
          if (widget.mode == DirectSelectMode.tap) {
            _removeOverlay();
          }
        },
        builder: (context, index) {
          if (widget.items != null) {
            return widget.items[index];
          }
          return const SizedBox.shrink();
        },
        controller: _controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final preferTapMode = widget.mode == DirectSelectMode.tap;
    return GestureDetector(
      behavior: widget.hitTestBehavior,
      onTap: !widget.ignoreInput && preferTapMode ? _createOverlay : null,
      onVerticalDragStart: widget.ignoreInput || preferTapMode ? null : (_) => _createOverlay(),
      onVerticalDragEnd: widget.ignoreInput || preferTapMode ? null : (_) => _removeOverlay(),
      onVerticalDragUpdate: widget.ignoreInput || preferTapMode
          ? null
          : (details) =>
              _controller.hasScrollPositions ? _controller.jumpTo(_controller.offset - details.primaryDelta) : null,
      child: Container(
        key: _key,
        child: widget.child,
      ),
    );
  }
}
