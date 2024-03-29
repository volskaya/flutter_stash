// Copyright 2019 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'item_positions_listener.dart';
import 'item_positions_notifier.dart';
import 'positioned_list.dart';
import 'post_mount_callback.dart';

/// Number of screens to scroll when scrolling a long distance.
const int _screenScrollCount = 2;

/// A scrollable list of widgets similar to [ListView], except scroll control
/// and position reporting is based on index rather than pixel offset.
///
/// [ScrollablePositionedList] lays out children in the same way as [ListView].
///
/// The list can be displayed with the item at [initialScrollIndex] positioned
/// at a particular [initialAlignment], where [initialAlignment] positions the
/// leading edge of the item with [initialScrollIndex] at [initialAlignment] *
/// height of the viewport from the leading edge of the viewport.
///
/// The [itemScrollController] can be used to scroll or jump to particular items
/// in the list.  The [itemPositionNotifier] can be used to get a list of items
/// currently laid out by the list.
///
/// All other parameters are the same as specified in [ListView].
class ScrollablePositionedList extends StatefulWidget {
  /// Create a [ScrollablePositionedList] whose items are provided by
  /// [itemBuilder].
  const ScrollablePositionedList.builder({
    required this.itemCount,
    required this.itemBuilder,
    Key? key,
    this.itemScrollController,
    ItemPositionsListener? itemPositionsListener,
    this.initialScrollIndex = 0,
    this.initialAlignment = 0,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.semanticChildCount,
    this.padding,
    this.addSemanticIndexes = true,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.minCacheExtent,
    this.frontScrollController,
    this.backScrollController,
  })  : itemPositionNotifier = itemPositionsListener as ItemPositionsNotifier?,
        separatorBuilder = null,
        super(key: key);

  /// Create a [ScrollablePositionedList] whose items are provided by
  /// [itemBuilder] and separators provided by [separatorBuilder].
  const ScrollablePositionedList.separated({
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    Key? key,
    this.itemScrollController,
    ItemPositionsListener? itemPositionsListener,
    this.initialScrollIndex = 0,
    this.initialAlignment = 0,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.semanticChildCount,
    this.padding,
    this.addSemanticIndexes = true,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.minCacheExtent,
    this.frontScrollController,
    this.backScrollController,
  })  : itemPositionNotifier = itemPositionsListener as ItemPositionsNotifier?,
        super(key: key);

  /// Number of items the [itemBuilder] can produce.
  final int itemCount;

  /// Called to build children for the list with
  /// 0 <= index < itemCount.
  final IndexedWidgetBuilder itemBuilder;

  /// Called to build separators for between each item in the list.
  /// Called with 0 <= index < itemCount - 1.
  final IndexedWidgetBuilder? separatorBuilder;

  /// Controller for jumping or scrolling to an item.
  final ItemScrollController? itemScrollController;

  /// Notifier that reports the items laid out in the list after each frame.
  final ItemPositionsNotifier? itemPositionNotifier;

  /// Index of an item to initially align within the viewport.
  final int initialScrollIndex;

  /// Determines where the leading edge of the item at [initialScrollIndex]
  /// should be placed.
  final double initialAlignment;

  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Whether the view scrolls in the reading direction.
  ///
  /// Defaults to false.
  ///
  /// See [ScrollView.reverse].
  final bool reverse;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// See [ScrollView.physics].
  final ScrollPhysics physics;

  /// The number of children that will contribute semantic information.
  ///
  /// See [ScrollView.semanticChildCount] for more information.
  final int? semanticChildCount;

  /// The amount of space by which to inset the children.
  final EdgeInsets? padding;

  /// Whether to wrap each child in an [IndexedSemantics].
  ///
  /// See [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// Whether to wrap each child in an [AutomaticKeepAlive].
  ///
  /// See [SliverChildBuilderDelegate.addAutomaticKeepAlives].
  final bool addAutomaticKeepAlives;

  /// Whether to wrap each child in a [RepaintBoundary].
  ///
  /// See [SliverChildBuilderDelegate.addRepaintBoundaries].
  final bool addRepaintBoundaries;

  /// The minimum cache extent used by the underlying scroll lists.
  /// See [ScrollView.cacheExtent].
  ///
  /// Note that the [ScrollablePositionedList] uses two lists to simulate long
  /// scrolls, so using the [ScrollController.scrollTo] method may result
  /// in builds of widgets that would otherwise already be built in the
  /// cache extent.
  final double? minCacheExtent;

  final ScrollController? frontScrollController;
  final ScrollController? backScrollController;

  @override
  State<StatefulWidget> createState() => _ScrollablePositionedListState();
}

/// Controller to jump or scroll to a particular position in a
/// [ScrollablePositionedList].
class ItemScrollController {
  /// Whether any ScrollablePositionedList objects are attached this object.
  ///
  /// If `false`, then [jumpTo] and [scrollTo] must not be called.
  bool get isAttached => _scrollableListState != null;

  _ScrollablePositionedListState? _scrollableListState;

  /// Immediately, without animation, reconfigure the list so that item at
  /// [index]'s leading edge is at the given [alignment].
  void jumpTo({required int index, double alignment = 0}) {
    _scrollableListState?._jumpTo(index: index, alignment: alignment);
  }

  /// Animation the list over [duration] using the given [curve] such that the
  /// item at [index] ends up with its leading edge the given alignment.
  ///
  /// [duration] must be greater than 0; otherwise, use [jumpTo].
  Future<void>? scrollTo({
    required int index,
    double alignment = 0.0,
    required Duration duration,
    Curve curve = Curves.linear,
  }) {
    assert(_scrollableListState != null);
    return _scrollableListState?._scrollTo(
      index: index,
      alignment: alignment,
      duration: duration,
      curve: curve,
    );
  }

  void _attach(_ScrollablePositionedListState scrollableListState) {
    assert(_scrollableListState == null);
    _scrollableListState = scrollableListState;
  }

  void _detach() {
    _scrollableListState = null;
  }
}

class _ScrollablePositionedListState extends State<ScrollablePositionedList> with TickerProviderStateMixin {
  final frontItemPositionNotifier = ItemPositionsNotifier();
  final backItemPositionNotifier = ItemPositionsNotifier();
  // final frontScrollController = ScrollController(keepScrollOffset: false);
  // final backScrollController = ScrollController(keepScrollOffset: false);
  final frontOpacity = ProxyAnimation(const AlwaysStoppedAnimation<double>(1.0));

  late final ScrollController frontScrollController;
  late final ScrollController backScrollController;

  int backTarget = 0;
  double backAlignment = 0;
  late int frontTarget;
  late double frontAlignment;
  Function? cancelScrollCallback;
  Function? endScrollCallback;
  _ListDisplay listDisplay = _ListDisplay.front;
  void Function() startAnimationCallback = () {};

  @override
  void initState() {
    super.initState();

    frontScrollController = widget.frontScrollController ?? ScrollController(keepScrollOffset: false);
    backScrollController = widget.backScrollController ?? ScrollController(keepScrollOffset: false);

    ItemPosition? initialPosition = PageStorage.of(context)?.readState(context);
    frontTarget = initialPosition?.index ?? widget.initialScrollIndex;
    frontAlignment = initialPosition?.itemLeadingEdge ?? widget.initialAlignment;
    if (widget.itemCount > 0 && frontTarget > widget.itemCount - 1) {
      frontTarget = widget.itemCount - 1;
    }
    widget.itemScrollController?._attach(this);
    frontItemPositionNotifier.itemPositions.addListener(_updatePositions);
    backItemPositionNotifier.itemPositions.addListener(_updatePositions);
  }

  @override
  void deactivate() {
    widget.itemScrollController?._detach();
    super.deactivate();
  }

  @override
  void dispose() {
    frontItemPositionNotifier.itemPositions.removeListener(_updatePositions);
    backItemPositionNotifier.itemPositions.removeListener(_updatePositions);

    if (widget.frontScrollController == null) frontScrollController.dispose();
    if (widget.backScrollController == null) backScrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ScrollablePositionedList oldWidget) {
    assert((oldWidget.frontScrollController != null) == (widget.frontScrollController != null));
    assert((oldWidget.backScrollController != null) == (widget.backScrollController != null));

    if (oldWidget.itemScrollController?._scrollableListState == this) {
      oldWidget.itemScrollController?._detach();
    }
    if (widget.itemScrollController?._scrollableListState != this) {
      widget.itemScrollController?._detach();
      widget.itemScrollController?._attach(this);
    }
    if (widget.itemCount == 0) {
      setState(() {
        frontTarget = 0;
        backTarget = 0;
      });
    } else {
      if (frontTarget > widget.itemCount - 1) {
        setState(() {
          frontTarget = widget.itemCount - 1;
        });
      }
      if (backTarget > widget.itemCount - 1) {
        setState(() {
          backTarget = widget.itemCount - 1;
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => cancelScrollCallback?.call(),
        excludeFromSemantics: true,
        child: Stack(
          children: <Widget>[
            if (_showBackList)
              PostMountCallback(
                key: const ValueKey<String>('Back'),
                callback: () {
                  startAnimationCallback();
                },
                child: LayoutBuilder(
                  builder: (context, constraints) => PositionedList(
                    itemBuilder: widget.itemBuilder,
                    separatorBuilder: widget.separatorBuilder,
                    itemCount: widget.itemCount,
                    positionedIndex: backTarget,
                    controller: backScrollController,
                    itemPositionNotifier: backItemPositionNotifier,
                    scrollDirection: widget.scrollDirection,
                    reverse: widget.reverse,
                    cacheExtent: _cacheExtent(constraints),
                    alignment: backAlignment,
                    physics: widget.physics,
                    addSemanticIndexes: widget.addSemanticIndexes,
                    semanticChildCount: widget.semanticChildCount,
                    padding: widget.padding,
                    addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                    addRepaintBoundaries: widget.addRepaintBoundaries,
                  ),
                ),
              ),
            if (_showFrontList)
              PostMountCallback(
                key: const ValueKey<String>('Front'),
                callback: () {
                  startAnimationCallback();
                },
                child: AnimatedBuilder(
                  animation: frontOpacity,
                  builder: (context, child) => Opacity(
                    opacity: frontOpacity.value,
                    child: LayoutBuilder(
                      builder: (context, constraints) => PositionedList(
                        itemBuilder: widget.itemBuilder,
                        separatorBuilder: widget.separatorBuilder,
                        itemCount: widget.itemCount,
                        itemPositionNotifier: frontItemPositionNotifier,
                        positionedIndex: frontTarget,
                        controller: frontScrollController,
                        scrollDirection: widget.scrollDirection,
                        reverse: widget.reverse,
                        cacheExtent: _cacheExtent(constraints),
                        alignment: frontAlignment,
                        physics: widget.physics,
                        addSemanticIndexes: widget.addSemanticIndexes,
                        semanticChildCount: widget.semanticChildCount,
                        padding: widget.padding,
                        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                        addRepaintBoundaries: widget.addRepaintBoundaries,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );

  double _cacheExtent(BoxConstraints constraints) => widget.minCacheExtent == null
      ? constraints.maxHeight * _screenScrollCount
      : max(
          constraints.maxHeight * _screenScrollCount,
          widget.minCacheExtent!,
        );

  void _jumpTo({required int index, double? alignment}) {
    cancelScrollCallback?.call();
    if (index > widget.itemCount - 1) {
      index = widget.itemCount - 1;
    }
    if (_showFrontList) {
      frontScrollController.jumpTo(0);
      setState(() {
        frontTarget = index;
        if (alignment != null) frontAlignment = alignment;
      });
    } else {
      backScrollController.jumpTo(0);
      setState(() {
        backTarget = index;
        if (alignment != null) backAlignment = alignment;
      });
    }
  }

  Future<void> _scrollTo({
    required int index,
    double? alignment,
    required Duration duration,
    Curve curve = Curves.linear,
  }) async {
    if (index > widget.itemCount - 1) {
      index = widget.itemCount - 1;
    }
    if (cancelScrollCallback != null) {
      cancelScrollCallback!();
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _startScroll(
          index: index,
          alignment: alignment ?? 0.0,
          duration: duration,
          curve: curve,
        );
      });
    } else {
      await _startScroll(index: index, alignment: alignment ?? 0.0, duration: duration, curve: curve);
    }
  }

  Future<void> _startScroll({
    required int index,
    double? alignment,
    required Duration duration,
    Curve curve = Curves.linear,
  }) async {
    final lastTarget = _showFrontList ? frontTarget : backTarget;
    final direction = index > lastTarget ? 1 : -1;
    final startingListDisplay = listDisplay;
    final startingScrollController = _showFrontList ? frontScrollController : backScrollController;

    ItemPosition? itemPosition;

    try {
      itemPosition = (_showFrontList ? frontItemPositionNotifier : backItemPositionNotifier)
          .itemPositions
          .value
          .firstWhere((ItemPosition itemPosition) => itemPosition.index == index);
    } on StateError catch (_) {}

    if (itemPosition != null) {
      final localScrollAmount = itemPosition.itemLeadingEdge * startingScrollController.position.viewportDimension;
      await startingScrollController.animateTo(
          startingScrollController.offset +
              localScrollAmount -
              (alignment ?? 0.0) * startingScrollController.position.viewportDimension,
          duration: duration,
          curve: curve);
    } else {
      final scrollAmount = _screenScrollCount * startingScrollController.position.viewportDimension;
      final endingScrollController = _showFrontList ? backScrollController : frontScrollController;
      final startCompleter = Completer<void>();
      final endCompleter = Completer<void>();
      startAnimationCallback = () {
        SchedulerBinding.instance!.addPostFrameCallback((_) async {
          frontOpacity.parent = _opacityAnimation(startingListDisplay)
              .animate(AnimationController(vsync: this, duration: duration)..forward());
          startAnimationCallback = () {};
          endingScrollController.jumpTo(-direction *
              (_screenScrollCount * startingScrollController.position.viewportDimension -
                  (alignment ?? 0.0) * endingScrollController.position.viewportDimension));
          endCompleter.complete(endingScrollController.animateTo(
              -(alignment ?? 0.0) * endingScrollController.position.viewportDimension,
              duration: duration,
              curve: curve));
          startCompleter.complete(startingScrollController
              .animateTo(startingScrollController.offset + direction * scrollAmount, duration: duration, curve: curve));
          cancelScrollCallback = () => _cancelScroll(startingListDisplay);
        });
      };
      setState(() {
        if (_showFrontList) {
          backTarget = index;
        } else {
          frontTarget = index;
        }
        listDisplay = _ListDisplay.both;
      });
      endScrollCallback = () {
        setState(() {
          listDisplay = startingListDisplay == _ListDisplay.front ? _ListDisplay.back : _ListDisplay.front;
        });
        cancelScrollCallback = null;
        endScrollCallback = null;
      };
      return Future.wait<void>(<Future<void>>[startCompleter.future, endCompleter.future]).then((_) async {
        endScrollCallback?.call();
      });
    }
  }

  void _cancelScroll(_ListDisplay startingListDisplay) {
    frontScrollController.jumpTo(frontScrollController.offset);
    backScrollController.jumpTo(backScrollController.offset);
    if (startingListDisplay == _ListDisplay.front && frontOpacity.value >= 0.5) {
      setState(() {
        listDisplay = _ListDisplay.front;
        frontOpacity.parent = const AlwaysStoppedAnimation<double>(1.0);
      });
      cancelScrollCallback = null;
      endScrollCallback = null;
    } else if (startingListDisplay == _ListDisplay.back && frontOpacity.value <= 0.5) {
      setState(() {
        listDisplay = _ListDisplay.back;
      });
      cancelScrollCallback = null;
      endScrollCallback = null;
    } else if (startingListDisplay == _ListDisplay.back && frontOpacity.value > 0.5) {
      setState(() {
        listDisplay = _ListDisplay.front;
        frontOpacity.parent = const AlwaysStoppedAnimation<double>(1.0);
      });
      cancelScrollCallback = null;
      endScrollCallback = null;
    }
  }

  Animatable<double> _opacityAnimation(_ListDisplay startListDisplay) {
    final startOpacity = startListDisplay == _ListDisplay.front ? 1.0 : 0.0;
    final endOpacity = 1 - startOpacity;
    return TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: ConstantTween<double>(startOpacity), weight: 40),
      TweenSequenceItem<double>(tween: Tween<double>(begin: startOpacity, end: endOpacity), weight: 20),
      TweenSequenceItem<double>(tween: ConstantTween<double>(endOpacity), weight: 40),
    ]);
  }

  bool get _showBackList => listDisplay == _ListDisplay.back || listDisplay == _ListDisplay.both;

  bool get _showFrontList => listDisplay == _ListDisplay.front || listDisplay == _ListDisplay.both;

  void _updatePositions() {
    final itemPositions = _showFrontList
        ? frontItemPositionNotifier.itemPositions.value
            .where((ItemPosition position) => position.itemLeadingEdge < 1 && position.itemTrailingEdge > 0)
        : backItemPositionNotifier.itemPositions.value
            .where((ItemPosition position) => position.itemLeadingEdge < 1 && position.itemTrailingEdge > 0);
    if (itemPositions.isNotEmpty) {
      PageStorage.of(context)?.writeState(
        context,
        itemPositions.reduce((value, element) => value.itemLeadingEdge < element.itemLeadingEdge ? value : element),
      );
    }
    widget.itemPositionNotifier?.itemPositions.value = itemPositions;
  }
}

enum _ListDisplay { back, front, both }
