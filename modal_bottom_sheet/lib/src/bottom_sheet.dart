// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:boxy/boxy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/src/utils/bottom_sheet_suspended_curve.dart';
import 'package:modal_bottom_sheet/src/utils/scroll_to_top_status_bar.dart';

const Duration kMediumMotionDuration = Duration(milliseconds: 250);
const Curve _modalBottomSheetCurve = decelerateEasing;
const double _minFlingVelocity = 500.0;
const double _closeProgressThreshold = 0.6;
const double _willPopThreshold = 0.8;

typedef ModalBottomSheetContainerBuilder = Widget Function(
    BuildContext context, Animation<double> animation, Widget child);

/// A custom bottom sheet.
///
/// The [ModalBottomSheet] widget itself is rarely used directly. Instead, prefer to
/// create a modal bottom sheet with [showMaterialModalBottomSheet].
///
/// See also:
///
///  * [showMaterialModalBottomSheet] which can be used to display a modal bottom
///    sheet with Material appareance.
///  * [showCupertinoModalBottomSheet] which can be used to display a modal bottom
///    sheet with Cupertino appareance.
class ModalBottomSheet extends StatefulWidget {
  /// Creates a bottom sheet.
  const ModalBottomSheet({
    Key? key,
    required this.child,
    required this.animationController,
    required this.onClosing,
    required this.scrollController,
    this.closeProgressThreshold,
    this.animationCurve,
    this.enableDrag = true,
    this.containerBuilder,
    this.bounce = true,
    this.shouldClose,
    this.expanded = false,
  }) : super(key: key);

  /// The closeProgressThreshold parameter
  /// specifies when the bottom sheet will be dismissed when user drags it.
  final double? closeProgressThreshold;

  /// The animation controller that controls the bottom sheet's entrance and
  /// exit animations.
  ///
  /// The BottomSheet widget will manipulate the position of this animation, it
  /// is not just a passive observer.
  final AnimationController? animationController;

  /// The curve used by the animation showing and dismissing the bottom sheet.
  ///
  /// If no curve is provided it falls back to `decelerateEasing`.
  final Curve? animationCurve;

  /// Allows the bottom sheet to  go beyond the top bound of the content,
  /// but then bounce the content back to the edge of
  /// the top bound.
  final bool bounce;

  /// Force the widget to fill the maximum size of the viewport
  /// or if false it will fit to the content of the widget
  final bool? expanded;

  /// The container builder of the sheet.
  final ModalBottomSheetContainerBuilder? containerBuilder;

  /// Called when the bottom sheet begins to close.
  ///
  /// A bottom sheet might be prevented from closing (e.g., by user
  /// interaction) even after this callback is called. For this reason, this
  /// callback might be call multiple times for a given bottom sheet.
  final Function()? onClosing;

  /// If shouldClose is null is ignored.
  /// If returns true => The dialog closes
  /// If returns false => The dialog cancels close
  /// Notice that if shouldClose is not null, the dialog will go back to the
  /// previous position until the function is solved
  final Future<bool> Function()? shouldClose;

  /// A widget for the contents of the sheet.
  final Widget child;

  /// If true, the bottom sheet can be dragged up and down and dismissed by
  /// swiping downwards.
  ///
  /// Default is true.
  final bool enableDrag;

  /// Scroll controller passed down to the sheet.
  final ScrollController scrollController;

  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();

  /// Creates an [AnimationController] suitable for a
  /// [ModalBottomSheet.animationController].
  ///
  /// This API available as a convenience for a Material compliant bottom sheet
  /// animation. If alternative animation durations are required, a different
  /// animation controller could be provided.
  static AnimationController createAnimationController(TickerProvider vsync, {Duration? duration}) =>
      AnimationController(
        duration: duration ?? kMediumMotionDuration,
        debugLabel: 'BottomSheet',
        vsync: vsync,
      );
}

class _ModalBottomSheetState extends State<ModalBottomSheet> with TickerProviderStateMixin {
  final _childKey = GlobalKey(debugLabel: 'BottomSheet child');

  // As we cannot access the dragGesture detector of the scroll view
  // we can not know the DragDownDetails and therefore the end velocity.
  // VelocityTracker it is used to calculate the end velocity of the scroll
  // when user is trying to close the modal by dragging.
  VelocityTracker? _velocityTracker;
  DateTime? _startTime;
  ScrollController get _scrollController => widget.scrollController;
  AnimationController? _bounceDragController;
  ParametricCurve<double> get _defaultCurve => widget.animationCurve ?? _modalBottomSheetCurve;
  ParametricCurve<double> animationCurve = Curves.linear;

  double? get _childHeight {
    final renderBox = _childKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size.height;
  }

  bool get _dismissUnderway => widget.animationController?.status == AnimationStatus.reverse;

  // Detect if user is dragging.
  // Used on NotificationListener to detect if ScrollNotifications are
  // before or after the user stop dragging
  bool isDragging = false;

  bool get hasReachedWillPopThreshold =>
      widget.animationController != null && widget.animationController!.value < _willPopThreshold;

  bool get hasReachedCloseThreshold =>
      widget.animationController != null &&
      widget.animationController!.value < (widget.closeProgressThreshold ?? _closeProgressThreshold);

  void _close() {
    animationCurve = BottomSheetSuspendedCurve(
      widget.animationController?.value ?? 0.0,
      curve: accelerateEasing,
    );

    isDragging = false;
    widget.onClosing?.call();
  }

  void _cancelClose() {
    widget.animationController?.animateTo(1, curve: standardEasing, duration: kMediumMotionDuration);
    _bounceDragController?.reverse();
  }

  bool _isCheckingShouldClose = false;

  FutureOr<bool?> shouldClose() async {
    if (_isCheckingShouldClose) return false;
    if (widget.shouldClose == null) return null;
    _isCheckingShouldClose = true;
    final result = await widget.shouldClose?.call();
    _isCheckingShouldClose = false;
    return result;
  }

  void _handleDragUpdate(double primaryDelta) async {
    animationCurve = Curves.linear;
    assert(widget.enableDrag, 'Dragging is disabled');

    if (_dismissUnderway) return;
    isDragging = true;

    final progress = primaryDelta / (_childHeight ?? primaryDelta);

    if (widget.shouldClose != null && hasReachedWillPopThreshold) {
      _cancelClose();
      final canClose = await shouldClose();
      if (canClose == true) {
        _close();
        return;
      } else {
        _cancelClose();
      }
    }

    // Bounce top.
    if (_bounceDragController != null) {
      final bounce = widget.bounce == true;
      final shouldBounce = _bounceDragController!.value > 0;
      final isBouncing = (widget.animationController!.value - progress) > 1;
      if (bounce && (shouldBounce || isBouncing)) {
        _bounceDragController!.value -= progress * 10;
        return;
      }
    }

    widget.animationController?.value -= progress;
  }

  Future _handleDragEnd(double velocity) async {
    assert(widget.enableDrag, 'Dragging is disabled');

    if (_dismissUnderway || !isDragging) return;
    isDragging = false;
    // ignore: unawaited_futures
    _bounceDragController?.reverse();

    bool canClose = true;
    if (widget.shouldClose != null && hasReachedWillPopThreshold) {
      _cancelClose();
      canClose = await shouldClose() ?? false;
    }

    if (canClose) {
      // If speed is bigger than _minFlingVelocity try to close it.
      if (velocity > _minFlingVelocity) {
        _close();
      } else if (hasReachedCloseThreshold) {
        _close();
      } else {
        _cancelClose();
      }
    } else {
      _cancelClose();
    }
  }

  void _handleScrollUpdate(ScrollNotification notification) {
    if (!_scrollController.hasClients) return; // Check if scrollController is used.
    // Check if there is more than 1 attached ScrollController e.g. swiping page in PageView.
    // ignore: invalid_use_of_protected_member
    if (_scrollController.positions.length > 1) return;
    if (notification.context == null || _scrollController != Scrollable.of(notification.context!)?.widget.controller) {
      return;
    }

    final scrollPosition = _scrollController.position;
    if (scrollPosition.axis == Axis.horizontal) return;

    final isScrollReversed = scrollPosition.axisDirection == AxisDirection.down;
    final offset = isScrollReversed ? scrollPosition.pixels : scrollPosition.maxScrollExtent - scrollPosition.pixels;

    if (offset <= 0) {
      // Clamping Scroll Physics end with a ScrollEndNotification with a DragEndDetail class
      // while Bouncing Scroll Physics or other physics that Overflow don't return a drag end info.

      // We use the velocity from DragEndDetail in case it is available.
      if (notification is ScrollEndNotification && notification.dragDetails?.primaryVelocity != null) {
        _handleDragEnd(notification.dragDetails!.primaryVelocity!);
        _velocityTracker = null;
        _startTime = null;
        return;
      }

      // Otherwise the calculate the velocity with a VelocityTracker.
      if (_velocityTracker == null) {
        // ignore: deprecated_member_use
        // _velocityTracker = VelocityTracker();
        _startTime = DateTime.now();
      }
      DragUpdateDetails? dragDetails;
      if (notification is ScrollUpdateNotification) {
        dragDetails = notification.dragDetails;
      }
      if (notification is OverscrollNotification) {
        dragDetails = notification.dragDetails;
      }
      if (dragDetails != null) {
        if (_startTime != null && _velocityTracker != null) {
          final duration = _startTime!.difference(DateTime.now());
          _velocityTracker!.addPosition(duration, Offset(0, offset));
        }
        _handleDragUpdate(dragDetails.delta.dy);
      } else if (isDragging && _velocityTracker != null) {
        final velocity = _velocityTracker!.getVelocity().pixelsPerSecond.dy;
        _velocityTracker = null;
        _startTime = null;
        _handleDragEnd(velocity);
      }
    }
  }

  @override
  void initState() {
    animationCurve = _defaultCurve;
    _bounceDragController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    super.initState(); // TODO: Check if we can remove the scroll controller.
  }

  @override
  void dispose() {
    _bounceDragController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final animation = widget.animationController ?? const AlwaysStoppedAnimation(1.0);
    final child = widget.containerBuilder?.call(context, animation, widget.child) ?? widget.child;

    return ScrollToTopStatusBarHandler(
      scrollController: _scrollController,
      child: GestureDetector(
        onVerticalDragUpdate: (details) => _handleDragUpdate(details.delta.dy),
        onVerticalDragEnd: (details) => _handleDragEnd(details.primaryVelocity ?? 0.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            _handleScrollUpdate(notification);
            return false;
          },
          child: AnimatedBuilder(
            animation: animation,
            child: RepaintBoundary(key: _childKey, child: child),
            builder: (context, child) {
              final animationValue = animationCurve.transform(
                mediaQuery.accessibleNavigation ? 1.0 : (animation.value),
              );

              return CustomBoxy(
                children: [LayoutId(id: #contents, child: child!)],
                delegate: _ModalBottomSheetBox(
                  topInset: mediaQuery.padding.top,
                  value: animationValue,
                  statusBarColor: theme.colorScheme.background,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ModalBottomSheetBox extends BoxyDelegate {
  _ModalBottomSheetBox({
    this.topInset = 0.0,
    this.value = 1.0,
    this.statusBarColor = Colors.yellow,
  });

  final double topInset;
  final double value;
  final Color statusBarColor;

  @override
  Size layout() {
    final content = getChild(#contents)!;
    final contentConstraints = constraints.copyWith(minHeight: 0.0, maxHeight: (constraints.maxHeight - topInset));
    final contentSize = content.layout(contentConstraints);
    content.position(Offset(0.0, constraints.maxHeight - contentSize.height * value));

    final t = 1.0 - ((content.rect.top - topInset) / kToolbarHeight).clamp(0.0, 1.0);

    if (t > 0.0) {
      inflate(ColoredBox(color: statusBarColor.withOpacity(t)), id: #topBar);
      final topBarConstraints = constraints.copyWith(maxHeight: topInset, minHeight: topInset);
      final topBar = getChild(#topBar)!;
      topBar.layout(topBarConstraints);
      topBar.position(Offset.zero);
    }

    return constraints.biggest;
  }

  @override
  bool shouldRelayout(_ModalBottomSheetBox oldDelegate) =>
      oldDelegate.topInset != topInset || oldDelegate.value != value;
}

// Checks the device input type as per the OS installed in it
// Mobile platforms will be default to `touch` while desktop will do to `mouse`
// Used with VelocityTracker
// https://github.com/flutter/flutter/pull/64267#issuecomment-694196304
PointerDeviceKind defaultPointerDeviceKind(BuildContext context) {
  switch (Theme.of(context).platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.android:
      return PointerDeviceKind.touch;
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return PointerDeviceKind.mouse;
    case TargetPlatform.fuchsia:
      return PointerDeviceKind.unknown;
  }
}
