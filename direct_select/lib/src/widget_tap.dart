import 'dart:async';

import 'package:flutter/material.dart';
import 'package:direct_select/src/base.dart';
import 'package:direct_select/src/widget.dart';

class _DirectSelectTap extends DirectSelectBase {
  const _DirectSelectTap({
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
          overlayChildren: overlayChildren,
          ignoreInput: ignoreInput,
          allowScrollEnd: allowScrollEnd,
          key: key,
        );

  @override
  DirectSelectTapState createState() => DirectSelectTapState();
}

class DirectSelectTapState extends DirectSelectBaseState<_DirectSelectTap> {
  bool _dialogShowing;

  @override
  Future<int> createOverlay() async {
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
            final index = notifySelectedItem();
            completer?.complete(index);
            completer = null;
            return true;
          },
          child: overlayWidget(),
        ),
      );
      return completer.future;
    }
    return null;
  }

  @override
  Future<void> removeOverlay() async {
    if (mounted) {
      final navigator = Navigator.of(context);
      if (_dialogShowing && navigator != null) {
        if (!await navigator.maybePop()) {
          notifySelectedItem();
        }
      } else {
        final index = notifySelectedItem();
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
