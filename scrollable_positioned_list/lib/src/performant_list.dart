// Copyright 2019 The Fuchsia Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'positioned_list.dart';

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
class PerformantList extends StatefulWidget {
  /// Create a [PerformantList] whose items are provided by
  /// [itemBuilder].
  const PerformantList.builder({
    required this.itemCount,
    required this.itemBuilder,
    Key? key,
    this.controller,
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
  })  : separatorBuilder = null,
        super(key: key);

  /// Create a [PerformantList] whose items are provided by
  /// [itemBuilder] and separators provided by [separatorBuilder].
  const PerformantList.separated({
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    Key? key,
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
    this.controller,
  }) : super(key: key);

  /// Number of items the [itemBuilder] can produce.
  final int itemCount;

  /// Called to build children for the list with
  /// 0 <= index < itemCount.
  final IndexedWidgetBuilder itemBuilder;

  /// Called to build separators for between each item in the list.
  /// Called with 0 <= index < itemCount - 1.
  final IndexedWidgetBuilder? separatorBuilder;

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
  /// Note that the [PerformantList] uses two lists to simulate long
  /// scrolls, so using the [ScrollController.scrollTo] method may result
  /// in builds of widgets that would otherwise already be built in the
  /// cache extent.
  final double? minCacheExtent;

  final ScrollController? controller;

  @override
  State<StatefulWidget> createState() => _PerformantListState();
}

class _PerformantListState extends State<PerformantList> with TickerProviderStateMixin {
  late final ScrollController controller;
  int backTarget = 0;
  double backAlignment = 0;
  void Function() startAnimationCallback = () {};

  double _cacheExtent(BoxConstraints constraints) => widget.minCacheExtent == null
      ? constraints.maxHeight * _screenScrollCount
      : max(
          constraints.maxHeight * _screenScrollCount,
          widget.minCacheExtent!,
        );

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? ScrollController();
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PerformantList oldWidget) {
    assert((oldWidget.controller != null) == (widget.controller != null));

    if (widget.itemCount == 0) {
      backTarget = 0;
    } else {
      if (backTarget > widget.itemCount - 1) {
        backTarget = widget.itemCount - 1;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => PositionedList(
          controller: controller,
          itemBuilder: widget.itemBuilder,
          separatorBuilder: widget.separatorBuilder,
          itemCount: widget.itemCount,
          positionedIndex: backTarget,
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
      );
}
