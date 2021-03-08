// ignore_for_file:sort_unnamed_constructors_first

import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:await_route/await_route.dart';
import 'package:fading_tile/src/size_expand_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:refresh_storage/refresh_storage.dart';
import 'package:utils/utils.dart';

enum _FadingTileType { fade, size }

class _FadingTileControllerStorage extends RefreshStorageItem {
  final finished = <int>{};
  int maxIndex = -1;
}

/// Holds and schedules [AnimationController]s of [FadingTile]s.
class FadingTileController extends StatefulWidget {
  const FadingTileController._({
    Key key,
    @required this.type,
    @required this.child,
    this.bucket,
    this.pageSize = 20,
    this.staggerDuration = const Duration(milliseconds: 20),
    this.awaitRoute = false,
    this.startFrom = 0,
    this.poolControllers = false,
    this.initialOffset,
    this.expectedItemCount,
    this.lastMountedItem,
    this.optimizeOutFades = true,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  /// Creates [FadingTileController] with no sizing animation.
  const FadingTileController({
    Key key,
    @required this.child,
    this.bucket,
    this.pageSize = 20,
    this.staggerDuration = const Duration(milliseconds: 20),
    this.awaitRoute = false,
    this.startFrom = 0,
    this.poolControllers = false,
    this.initialOffset,
    this.expectedItemCount,
    this.lastMountedItem,
    this.optimizeOutFades = true,
    this.duration = const Duration(milliseconds: 300),
  })  : type = _FadingTileType.fade,
        super(key: key);

  /// Creates [FadingTileController] with sizing animation.
  const FadingTileController.size({
    Key key,
    @required this.child,
    this.bucket,
    this.pageSize = 20,
    this.staggerDuration = const Duration(milliseconds: 20),
    this.awaitRoute = false,
    this.startFrom = 0,
    this.poolControllers = false,
    this.initialOffset,
    this.expectedItemCount,
    this.lastMountedItem,
    this.optimizeOutFades = true,
    this.duration = const Duration(milliseconds: 300),
  })  : type = _FadingTileType.size,
        super(key: key);

  /// Animation type of the fade.
  final _FadingTileType type;

  /// Page storage bucket identifier.
  final String bucket;

  /// Child widget that builds the descendant [FadeTile]s.
  final Widget child;

  /// Page size of the collection thats being paginated.
  final int pageSize;

  /// Optional expected item count to better allow the [FadingTileController]
  /// to optimize offscreen items.
  final int expectedItemCount;

  /// Getter function of the last mounted item index, within the list, to better
  /// optimize out the tiles that don't need fade anymore.
  final int Function() lastMountedItem;

  /// Delay between every next fade in animation. If set to null,
  /// every next fade will start after the previous one finishes.
  final Duration staggerDuration;

  /// [FadeTiles]s with their index lower than [startFrom] will be ignored.
  final int startFrom;

  /// When the controller is initialized, overrides the currently accounted
  /// highest child index, so all children with the index lower than the
  /// [initialOffset] don't get faded.
  final int Function() initialOffset;

  /// Whether to only start animating after the route has finished animating.
  final bool awaitRoute;

  /// Pooling controllers will await 1 frame, to allow multiple controllers
  /// to build, before seeking the earliest stopped controller and animating
  /// from that.
  final bool poolControllers;

  /// Whether to attept to optimize out fades of off-screen widgets.
  final bool optimizeOutFades;

  /// Animation duration of each fading tile.
  final Duration duration;

  /// Get a [FadingTileController] from the context.
  static _FadingTileControllerState of(BuildContext context) =>
      Provider.of<_FadingTileControllerState>(context, listen: false);

  FadingTileController copyWith({
    Widget child,
  }) =>
      FadingTileController._(
        key: key,
        type: type,
        awaitRoute: awaitRoute,
        pageSize: pageSize,
        staggerDuration: staggerDuration,
        startFrom: startFrom,
        child: child,
        bucket: bucket,
      );

  @override
  _FadingTileControllerState createState() => _FadingTileControllerState();
}

class _FadingTileControllerState extends State<FadingTileController>
    with TickerProviderStateMixin<FadingTileController> {
  static final _log = Log.named('FadingTileController');
  final _controllers = HashMap<int, AnimationController>();
  final _indexes = <int>[];

  // int get _lowestIndex => _indexes.isNotEmpty ? _indexes.first : 0;
  int get _highestIndex => _indexes.isNotEmpty ? _indexes.last : 0;

  /// While the animation is in progress, the `_handleAnimationStatus` takes care
  /// of animating controllers.
  bool _animationInProgress = false;
  int _highestRequestedIndex = -1;
  RefreshStorageEntry<_FadingTileControllerStorage> _storage;

  /// If [considerInitial], this will be the first controller, that starts animating.
  /// Rest of the controllers should either be null or sometimes dismissed.
  ///
  /// If a list receives a lot of items at once, multiple controllers could be created,
  /// but never scheduled, since the index has skipped them. If that happens, use [widget.poolControllers].
  ///
  /// Pooling controllers will await 1 frame, allowing them to finish building, then
  /// seek to the index of the earliest dismissed controller and begin animating from that.
  Future _scheduleController(int index, {bool considerInitial = false}) async {
    var targetIndex = index;

    // if (!considerInitial) await Utils.awaitPostframe();

    if (considerInitial) {
      if (widget.poolControllers) {
        // First await a frame to let the controllers build.
        await Utils.awaitPostframe();
        if (!mounted) return;

        // Seek to the earliest dismissed controller.
        for (var i = targetIndex - 1; i >= 0; i -= 1) {
          if (_controllers[i] == null) break;
          if (_controllers[i]?.isDismissed == true) targetIndex = i;
        }

        if (index != targetIndex) _log.v('Scheduling index $targetIndex in place of $index instead');
      }

      if (widget.awaitRoute && mounted) await AwaitRoute.of(context);
    }

    assert((() {
      for (var i = targetIndex - 1; i >= 0; i -= 1) if (_controllers[i]?.isDismissed == true) return false;
      return true;
    })(), 'Frozen controllers found before index: $targetIndex');

    if (!considerInitial && widget.staggerDuration != null) {
      await Future<void>.delayed(widget.staggerDuration * timeDilation); // Stagger the animation.
    } else if (widget.optimizeOutFades &&
        !considerInitial &&
        targetIndex >= _highestRequestedIndex &&
        _controllers[targetIndex]?.hasListeners == false) {
      await Utils.awaitPostframe(); // A widget might not have mounted yet and never could attach a listener.
    }

    // After the post frame, check if the same optimize conditional is still truthy.
    if (widget.optimizeOutFades &&
        !considerInitial &&
        targetIndex >= _highestRequestedIndex &&
        _controllers[targetIndex]?.hasListeners == false) {
      final optimizationSize = math.max(
        widget.expectedItemCount ?? 0,
        targetIndex + widget.pageSize,
      );

      // If this controller has no listeners yet, assume the tile has not mounted yet.
      // If that's the case, optimize out every created controller past this index.
      for (var i = targetIndex; i < optimizationSize - 1; i += 1) {
        if (_controllers[i] == null) break;
        _log.d('Optimized out fade controller of $i / ${_controllers.length - 1}');
        _controllers[i].dispose();
        _controllers[i] = null;
      }

      _highestRequestedIndex = optimizationSize - 1;
      _animationInProgress = false;
      _storage.value.maxIndex = math.max(_highestRequestedIndex, _storage.value.maxIndex);
    } else {
      mounted && _controllers.containsKey(targetIndex)
          ? _controllers[targetIndex].forward()
          : _animationInProgress = false;
    }
  }

  void _handleAnimationStatus(int index, AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.reverse:
        break; // Ignore.
      case AnimationStatus.forward:
        if (widget.staggerDuration != null) _scheduleController(index + 1);
        _animationInProgress = true;
        break;
      case AnimationStatus.completed:
        if (widget.staggerDuration == null) _scheduleController(index + 1);
        _storage.value.maxIndex = math.max(index, _storage.value.maxIndex);
        _controllers.remove(index).dispose();
        break;
    }
  }

  void _registerIndex(int index) {
    // assert(!_indexes.contains(index));

    if (_indexes.isEmpty) {
      _indexes.add(index);
    } else {
      if (index < _indexes.first) {
        _indexes.insert(0, index);
      } else if (index > _indexes.last) {
        _indexes.add(index);
      } else {
        _log.w('Failed to find a side for index: $index in $_indexes');
        // This can happen on orientation change.
        _indexes
          ..add(index)
          ..sort();
      }
    }
  }

  void _unregisterIndex(int index) {
    // assert(_indexes.contains(index));
    _indexes.remove(index);
  }

  /// If the animation has finished, the controller is disposed and this function
  /// returns null.
  AnimationController getController(int index) {
    if (index < widget.startFrom) return null;
    if (index <= _storage.value.maxIndex) return null;

    _highestRequestedIndex = index;

    // Prepare a controller for the current index and for the rest of the page.
    if (index % widget.pageSize == widget.startFrom % widget.pageSize) {
      for (var i = index; i < index + widget.pageSize; i++) {
        if (_controllers.containsKey(i)) continue;
        _controllers[i] = AnimationController(vsync: this, duration: widget.duration)
          ..addStatusListener((status) => _handleAnimationStatus(i, status));
      }

      // This begins the stagger.
      if (!_animationInProgress) {
        _animationInProgress = true;
        _scheduleController(index, considerInitial: true);
      }
    }

    return _controllers[index];
  }

  @override
  void didUpdateWidget(covariant FadingTileController oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(oldWidget.type == widget.type);

    if (widget.optimizeOutFades && (oldWidget.expectedItemCount ?? 0) < (widget.expectedItemCount ?? 0)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_highestIndex < widget.expectedItemCount && !_animationInProgress) {
          for (var i = _highestRequestedIndex + 1; i < widget.expectedItemCount; i += 1) {
            if (_controllers[i] == null) break;
            _log.d('Optimized out fade controller of $i / ${widget.expectedItemCount - 1}');
            _controllers[i].dispose();
            _controllers[i] = null;
          }

          _storage.value.maxIndex = math.max(widget.expectedItemCount - 1, _storage.value.maxIndex);
          _highestRequestedIndex = widget.expectedItemCount - 1;
        }
      });
    }
  }

  @override
  void initState() {
    final identifier = 'fading_tile_controller_${widget.bucket}';
    _storage = widget.bucket != null
        ? RefreshStorage.write(
            identifier: identifier,
            context: context,
            builder: () => _FadingTileControllerStorage(),
          )
        : RefreshStorageEntry(identifier, _FadingTileControllerStorage());

    final initialOffset = widget.initialOffset?.call();
    if (initialOffset != null) _storage.value.maxIndex = initialOffset;
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _controllers.values.where((val) => val != null)) controller.dispose();
    _storage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Provider<_FadingTileControllerState>.value(
        value: this,
        child: widget.child,
      );
}

/// Fades in and staggers list tiles.
///
/// Must be a descendant of [FadingTileController].
class FadingTile extends HookWidget {
  /// Creates [FadingTile] without size animation.
  const FadingTile({
    Key key,
    @required this.child,
    @required this.index,
    this.paginatorIndex,
    this.fade = true,
    this.paginator,
  })  : type = _FadingTileType.fade,
        alignment = null,
        axis = null,
        clipBehavior = Clip.antiAlias,
        optimizeOutChild = false,
        super(key: key);

  /// Creates [FadingTile] with size animation.
  const FadingTile.size({
    Key key,
    @required this.child,
    @required this.index,
    this.paginatorIndex,
    this.alignment = Alignment.topCenter,
    this.axis = Axis.vertical,
    this.clipBehavior = Clip.antiAlias,
    this.optimizeOutChild = false,
    this.fade = true,
    this.paginator,
  })  : type = _FadingTileType.size,
        super(key: key);

  /// Child widget to fade in.
  final Widget child;

  /// Index of the child in the list.
  final int index;

  /// Index of the child in the list.
  final int paginatorIndex;

  /// Fade in animation type.
  final _FadingTileType type;

  /// Alignment of the child in the size animation.
  final Alignment alignment;

  /// Scroll axis of the list, where this [FadingTile] is built.
  final Axis axis;

  /// The [Clip] to pass to the nested size animation.
  final Clip clipBehavior;

  /// While the animation is dismissed and [optimizeOutChild] is true, the
  /// child widget won't be built.
  final bool optimizeOutChild;

  /// Whether to use the fade animation.
  final bool fade;

  /// Callback to call when the element for this widget is mounted.
  final VoidCallback Function(int index) paginator;

  @override
  Widget build(BuildContext context) {
    // Memoize controller once per tile build.
    final animation = useMemoized(() => FadingTileController.of(context).getController(index));

    useEffect(() {
      try {
        paginator?.call(paginatorIndex ?? index)?.call();
      } catch (_) {}

      final controller = FadingTileController.of(context).._registerIndex(index);
      return () => controller._unregisterIndex(index);
    }, [index]);

    // Controller is usually not returned anymore, when the tile has faded out and it has disposed.
    // To ease off GC, don't wrap the child in animations.
    if (animation == null) return this.child;

    final child = RepaintBoundary(child: this.child);
    Widget tile;

    switch (type) {
      case _FadingTileType.fade:
        tile = fade ? _FadeTroughTransitionZoomedFadeIn(animation: animation, child: child) : child;
        break;
      case _FadingTileType.size:
        tile = _SizeInTransition(
          animation: animation,
          child: child,
          alignment: alignment,
          axis: axis,
          clip: clipBehavior != Clip.none,
          optimizeOutChild: optimizeOutChild,
          fade: fade,
        );
        break;
    }

    return tile;
  }
}

class _FadeTroughTransitionZoomedFadeIn extends StatelessWidget {
  const _FadeTroughTransitionZoomedFadeIn({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  static final CurveTween _inCurve = CurveTween(curve: const Cubic(0.0, 0.0, 0.2, 1.0));
  static final TweenSequence<double> _scaleIn = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: ConstantTween<double>(0.92), weight: 6 / 20),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0.92, end: 1.0).chain(_inCurve), weight: 14 / 20),
    ],
  );
  static final TweenSequence<double> _fadeInOpacity = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: ConstantTween<double>(0.0), weight: 6 / 20),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0, end: 1.0).chain(_inCurve), weight: 14 / 20),
    ],
  );

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _fadeInOpacity.animate(animation),
        child: ScaleTransition(
          scale: _scaleIn.animate(animation),
          child: child,
        ),
      );
}

class _SizeInTransition extends StatelessWidget {
  const _SizeInTransition({
    @required this.child,
    @required this.animation,
    this.alignment = Alignment.topCenter,
    this.axis = Axis.vertical,
    this.clip = true,
    this.optimizeOutChild = false,
    this.fade = true,
  });

  final Widget child;
  final Animation<double> animation;
  final Alignment alignment;
  final Axis axis;
  final bool clip;
  final bool optimizeOutChild;
  final bool fade;

  static final _tween = CurveTween(curve: decelerateEasing);

  @override
  Widget build(BuildContext context) => SizeExpandTransition(
        animation: animation.drive(_tween),
        alignment: alignment,
        axis: axis,
        clip: clip,
        child: !optimizeOutChild
            ? fade
                ? _FadeTroughTransitionZoomedFadeIn(animation: animation, child: child)
                : child
            : AnimatedBuilder(
                animation: animation,
                builder: (_, __) => animation.isDismissed
                    ? const SizedBox()
                    : fade
                        ? _FadeTroughTransitionZoomedFadeIn(
                            animation: animation,
                            child: child,
                          )
                        : child,
              ),
      );
}
