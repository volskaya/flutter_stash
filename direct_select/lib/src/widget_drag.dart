part of direct_select_plugin;

class _DirectSelectDrag extends _DirectSelectBase {
  const _DirectSelectDrag({
    Widget child,
    List<Widget> items,
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
          items: items,
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

class DirectSelectDragState extends DirectSelectBaseState<_DirectSelectDrag> {
  OverlayEntry _overlayEntry;
  GlobalKey<_MySelectionOverlayState> _keyOverlay;

  @override
  Future<int> _createOverlay() async {
    if (mounted) {
      OverlayState overlayState = Overlay.of(context);
      if (overlayState != null) {
        assert(completer == null);
        completer = Completer<int>();
        _overlayEntry = OverlayEntry(builder: (_) => _overlayWidget(_keyOverlay));
        overlayState.insert(_overlayEntry);
        return completer.future;
      }
    }
    return null;
  }

  @override
  Future<void> _removeOverlay() async {
    final currentState = _keyOverlay.currentState;
    if (currentState != null) {
      currentState.reverse(_overlayEntry);
    }
    final index = mounted ? _notifySelectedItem() : null;
    completer?.complete(index);
    completer = null;
  }

  @override
  void initState() {
    _keyOverlay = GlobalKey();
    super.initState();
  }
}
