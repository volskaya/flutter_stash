import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/src/bottom_sheet.dart';
import 'package:modal_bottom_sheet/src/utils/modal_scroll_controller.dart';

const Duration _bottomSheetDuration = Duration(milliseconds: 400);

typedef ModalBottomSheetStateCallback<T> = void Function(_SheetState<T> state);

class ModalBottomSheetRoute<T> extends PopupRoute<T> {
  ModalBottomSheetRoute({
    required this.expanded,
    required this.builder,
    this.closeProgressThreshold,
    this.containerBuilder,
    this.scrollController,
    this.barrierLabel,
    this.modalBarrierCurve,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    this.bounce = false,
    this.animationCurve,
    this.duration,
    this.onInitialized,
    this.onDisposed,
    this.onClosing,
    this.shouldClose,
    RouteSettings? settings,
  }) : super(settings: settings);

  final double? closeProgressThreshold;
  final ModalBottomSheetContainerBuilder? containerBuilder;
  final WidgetBuilder builder;
  final bool expanded;
  final bool bounce;
  final Color? modalBarrierColor;
  final Curve? modalBarrierCurve;
  final bool isDismissible;
  final bool enableDrag;
  final ScrollController? scrollController;
  final Duration? duration;
  final Curve? animationCurve;
  final ModalBottomSheetStateCallback<T>? onInitialized;
  final ModalBottomSheetStateCallback<T>? onDisposed;
  final VoidCallback? onClosing;
  final Future<bool> Function()? shouldClose;
  @override final String? barrierLabel;

  AnimationController? _animationController;

  @override
  Duration get transitionDuration => duration ?? _bottomSheetDuration;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  Color get barrierColor => modalBarrierColor ?? Colors.black54;

  @override
  Curve get barrierCurve => modalBarrierCurve ?? Curves.ease;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    return _animationController = ModalBottomSheet.createAnimationController(navigator!.overlay!, duration: duration);
  }

  bool get _hasScopedWillPopCallback => hasScopedWillPopCallback;

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) => nextRoute is ModalBottomSheetRoute;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) =>
      previousRoute is ModalBottomSheetRoute || previousRoute is PageRoute;

  /// Shows a modal material design bottom sheet.
  static Future<T?> push<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    required ModalBottomSheetContainerBuilder containerBuilder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    Curve? barrierCurve,
    bool bounce = false,
    bool expand = false,
    Curve? animationCurve,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Duration? duration,
    ModalBottomSheetStateCallback<T>? onInitialized,
    ModalBottomSheetStateCallback<T>? onDisposed,
  }) {
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));

    final hasMaterialLocalizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) != null;
    final barrierLabel = hasMaterialLocalizations ? MaterialLocalizations.of(context).modalBarrierDismissLabel : '';

    return Navigator.of(context, rootNavigator: useRootNavigator).push(
      ModalBottomSheetRoute<T>(
        builder: builder,
        bounce: bounce,
        containerBuilder: containerBuilder,
        expanded: expand,
        barrierLabel: barrierLabel,
        isDismissible: isDismissible,
        modalBarrierColor: barrierColor,
        modalBarrierCurve: barrierCurve,
        enableDrag: enableDrag,
        animationCurve: animationCurve,
        duration: duration,
        onInitialized: onInitialized,
        onDisposed: onDisposed,
      ),
    );
  }

  Widget getPreviousRouteTransition(
    BuildContext context,
    Animation<double> secondAnimation,
    Widget child,
  ) =>
      child;

  /// By definition, the bottom sheet is aligned to the bottom of the page
  /// and isn't exposed to the top padding of the MediaQuery.
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      MediaQuery.removePadding(
        context: context,
        child: ScrollConfiguration(
          behavior: const _NoChromeScrollBehavior(),
          child: _Sheet<T>(
            closeProgressThreshold: closeProgressThreshold,
            route: this,
            expanded: expanded,
            bounce: bounce,
            enableDrag: enableDrag,
            animationCurve: animationCurve,
            onInitialized: onInitialized,
            onDisposed: onDisposed,
            onClosing: onClosing,
            shouldClose: shouldClose,
          ),
        ),
      );
}

/// Sheet / body, what ever.
class _Sheet<T> extends StatefulWidget {
  const _Sheet({
    Key? key,
    required this.route,
    this.closeProgressThreshold,
    this.bounce = false,
    this.expanded = false,
    this.enableDrag = true,
    this.animationCurve,
    this.onInitialized,
    this.onDisposed,
    this.onClosing,
    this.shouldClose,
  }) : super(key: key);

  final ModalBottomSheetRoute<T> route;
  final double? closeProgressThreshold;
  final bool expanded;
  final bool bounce;
  final bool enableDrag;
  final Curve? animationCurve;
  final ModalBottomSheetStateCallback<T>? onInitialized;
  final ModalBottomSheetStateCallback<T>? onDisposed;
  final VoidCallback? onClosing;
  final Future<bool> Function()? shouldClose;

  @override
  _SheetState<T> createState() => _SheetState<T>();
}

class _SheetState<T> extends State<_Sheet<T>> {
  ScrollController? _scrollController;

  String _getRouteLabel() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return '';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Localizations.of(context, MaterialLocalizations) != null
            ? MaterialLocalizations.of(context).dialogLabel
            : const DefaultMaterialLocalizations().dialogLabel;
    }
  }

  @override
  void initState() {
    widget.onInitialized?.call(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final scrollController = _scrollController = PrimaryScrollController.of(context) ?? ScrollController();
    if (_scrollController != scrollController) {
      _scrollController?.dispose();
      _scrollController = scrollController;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    widget.onDisposed?.call(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    return ModalScrollController(
      controller: _scrollController!,
      child: Semantics(
        scopesRoute: true,
        namesRoute: true,
        label: _getRouteLabel(),
        explicitChildNodes: true,
        child: ModalBottomSheet(
          expanded: widget.route.expanded,
          containerBuilder: widget.route.containerBuilder,
          animationController: widget.route._animationController,
          child: widget.route.builder(context),
          enableDrag: widget.enableDrag,
          bounce: widget.bounce,
          scrollController: _scrollController!,
          animationCurve: widget.animationCurve,
          onClosing: widget.onClosing ?? (() => widget.route.isCurrent ? Navigator.of(context).pop() : null),
          shouldClose: widget.shouldClose ??
              (widget.route._hasScopedWillPopCallback
                  ? () async => await widget.route.willPop() != RoutePopDisposition.doNotPop
                  : null),
        ),
      ),
    );
  }
}

class _NoChromeScrollBehavior extends ScrollBehavior {
  const _NoChromeScrollBehavior();
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) => child;
}
