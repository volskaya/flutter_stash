import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/src/utils/modal_scroll_controller.dart';

import '../modal_bottom_sheet.dart';

const Duration _bottomSheetDuration = Duration(milliseconds: 400);

typedef ModalBottomSheetStateCallback<T> = void Function(_ModalBottomSheetState<T> state);

class _ModalBottomSheet<T> extends StatefulWidget {
  const _ModalBottomSheet({
    Key key,
    this.closeProgressThreshold,
    this.route,
    this.bounce = false,
    this.expanded = false,
    this.enableDrag = true,
    this.animationCurve,
    this.onInitialized,
    this.onDisposed,
    this.onClosing,
    this.shouldClose,
  })  : assert(expanded != null),
        assert(enableDrag != null),
        super(key: key);

  final double closeProgressThreshold;
  final ModalBottomSheetRoute<T> route;
  final bool expanded;
  final bool bounce;
  final bool enableDrag;
  final Curve animationCurve;
  final ModalBottomSheetStateCallback<T> onInitialized;
  final ModalBottomSheetStateCallback<T> onDisposed;
  final VoidCallback onClosing;
  final Future<bool> Function() shouldClose;

  @override
  _ModalBottomSheetState<T> createState() => _ModalBottomSheetState<T>();
}

class _ModalBottomSheetState<T> extends State<_ModalBottomSheet<T>> {
  ScrollController _scrollController;

  String _getRouteLabel() {
    switch (Theme.of(context)?.platform ?? defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return '';
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Localizations.of(context, MaterialLocalizations) != null
            ? MaterialLocalizations.of(context).dialogLabel
            : DefaultMaterialLocalizations().dialogLabel;
    }
    return null;
  }

  @override
  void initState() {
    widget.onInitialized?.call(this);
    super.initState();
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
    final scrollController = PrimaryScrollController.of(context) ?? (_scrollController ??= ScrollController());
    return ModalScrollController(
      controller: scrollController,
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
          scrollController: scrollController,
          animationCurve: widget.animationCurve,
          onClosing: widget.onClosing ?? (() => widget.route.isCurrent ? Navigator.of(context).pop() : null),
          shouldClose: widget.shouldClose ?? (widget.route._hasScopedWillPopCallback
              ? () async => await widget.route.willPop() != RoutePopDisposition.doNotPop
              : null),
        ),
      ),
    );
  }
}

class ModalBottomSheetRoute<T> extends PopupRoute<T> {
  ModalBottomSheetRoute({
    this.closeProgressThreshold,
    this.containerBuilder,
    this.builder,
    this.scrollController,
    this.barrierLabel,
    this.modalBarrierCurve,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    @required this.expanded,
    this.bounce = false,
    this.animationCurve,
    this.duration,
    this.onInitialized,
    this.onDisposed,
    this.onClosing,
    this.shouldClose,
    RouteSettings settings,
  })  : assert(expanded != null),
        assert(isDismissible != null),
        assert(enableDrag != null),
        super(settings: settings);

  final double closeProgressThreshold;
  final WidgetWithChildBuilder containerBuilder;
  final WidgetBuilder builder;
  final bool expanded;
  final bool bounce;
  final Color modalBarrierColor;
  final Curve modalBarrierCurve;
  final bool isDismissible;
  final bool enableDrag;
  final ScrollController scrollController;
  final Duration duration;
  final Curve animationCurve;
  final ModalBottomSheetStateCallback<T> onInitialized;
  final ModalBottomSheetStateCallback<T> onDisposed;
  final VoidCallback onClosing;
  final Future<bool> Function() shouldClose;

  AnimationController _animationController;

  @override
  Duration get transitionDuration => duration ?? _bottomSheetDuration;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => modalBarrierColor ?? Colors.black54;

  @override
  Curve get barrierCurve => modalBarrierCurve ?? Curves.ease;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    return _animationController = ModalBottomSheet.createAnimationController(navigator.overlay, duration: duration);
  }

  bool get _hasScopedWillPopCallback => hasScopedWillPopCallback;

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) => nextRoute is ModalBottomSheetRoute;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) =>
      previousRoute is ModalBottomSheetRoute || previousRoute is PageRoute;

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
          child: _ModalBottomSheet<T>(
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

class _NoChromeScrollBehavior extends ScrollBehavior {
  const _NoChromeScrollBehavior();
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) => child;
}

/// Shows a modal material design bottom sheet.
Future<T> showCustomModalBottomSheet<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
  @required WidgetWithChildBuilder containerWidget,
  Color backgroundColor,
  double elevation,
  ShapeBorder shape,
  Clip clipBehavior,
  Color barrierColor,
  Curve barrierCurve,
  bool bounce = false,
  bool expand = false,
  Curve animationCurve,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Duration duration,
  ModalBottomSheetStateCallback<T> onInitialized,
  ModalBottomSheetStateCallback<T> onDisposed,
}) {
  assert(context != null);
  assert(builder != null);
  assert(containerWidget != null);
  assert(expand != null);
  assert(useRootNavigator != null);
  assert(isDismissible != null);
  assert(enableDrag != null);
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  final hasMaterialLocalizations = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) != null;
  final barrierLabel = hasMaterialLocalizations ? MaterialLocalizations.of(context).modalBarrierDismissLabel : '';

  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    ModalBottomSheetRoute<T>(
      builder: builder,
      bounce: bounce,
      containerBuilder: containerWidget,
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
