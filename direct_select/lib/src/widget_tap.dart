part of direct_select_plugin;

class _DirectSelectTap extends _DirectSelectBase {
  const _DirectSelectTap({
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
          overlayChildren: overlayChildren,
          ignoreInput: ignoreInput,
          key: key,
        );

  @override
  DirectSelectTapState createState() => DirectSelectTapState();
}

class DirectSelectTapState extends DirectSelectBaseState<_DirectSelectTap> {
  bool _dialogShowing;

  @override
  Future<int> _createOverlay() async {
    if (mounted) {
      assert(completer == null);
      _dialogShowing = true;
      completer = Completer<int>();
      showGeneralDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: null, // this ensures that the barrier would be transparent.
        transitionDuration: const Duration(milliseconds: 230),
        transitionBuilder: (buildContext, animation, secondaryAnimation, child) => FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        ),
        pageBuilder: (context, animation, secondaryAnimation) => WillPopScope(
          onWillPop: () async {
            _dialogShowing = false;
            final index = _notifySelectedItem();
            completer?.complete(index);
            completer = null;
            return true;
          },
          child: _overlayWidget(),
        ),
      );
      return completer.future;
    }
    return null;
  }

  @override
  Future<void> _removeOverlay() async {
    if (mounted) {
      final navigator = Navigator.of(context);
      if (_dialogShowing && navigator != null) {
        if (!await navigator.maybePop()) {
          _notifySelectedItem();
        }
      } else {
        final index = _notifySelectedItem();
        completer?.complete(index);
        completer = null;
      }
      _dialogShowing = false;
    } else {
      completer?.complete(null);
      completer = null;
    }
  }

  @override
  void initState() {
    _dialogShowing = false;
    super.initState();
  }
}
