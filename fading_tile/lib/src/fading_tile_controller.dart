// ignore_for_file:sort_unnamed_constructors_first

import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:await_route/await_route.dart';
import 'package:fading_tile/src/fading_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:refresh_storage/refresh_storage.dart';
import 'package:utils/utils.dart';

class _FadingTileControllerStorage extends RefreshStorageItem {
  final finished = <int>{};
  int maxIndex = -1;
}

/// Holds and schedules [AnimationController]s of [FadingTile]s.
class FadingTileController extends StatefulWidget {
  /// Creates [FadingTileController] with no sizing animation.
  FadingTileController({
    Key? key,
    required this.child,
    required this.expectedItemCount,
    this.bucket,
    this.pageSize = 20,
    this.awaitRoute = false,
    this.startFrom = 0,
    this.poolControllers = false,
    this.prepareControllers = true,
    this.initialOffset,
    this.lastMountedItem,
    this.optimizeOutControllers = true,
    Duration? staggerDuration,
    Duration? duration,
  })  : _size = false,
        duration = duration ?? FadingTile.defaultDuration,
        staggerDuration = staggerDuration ?? FadingTile.defaultStaggerDuration,
        super(key: key);

  /// Creates [FadingTileController] with sizing animation.
  FadingTileController.size({
    Key? key,
    required this.child,
    required this.expectedItemCount,
    this.bucket,
    this.pageSize = 20,
    this.awaitRoute = false,
    this.startFrom = 0,
    this.poolControllers = false,
    this.prepareControllers = true,
    this.initialOffset,
    this.lastMountedItem,
    this.optimizeOutControllers = true,
    Duration? staggerDuration,
    Duration? duration,
  })  : _size = true,
        duration = duration ?? FadingTile.defaultDuration,
        staggerDuration = staggerDuration ?? FadingTile.defaultStaggerDuration,
        super(key: key);

  final bool _size;

  /// Page storage bucket identifier.
  final String? bucket;

  /// Child widget that builds the descendant [FadeTile]s.
  final Widget child;

  /// Page size of the collection thats being paginated.
  final int pageSize;

  /// Optional expected item count to better allow the [FadingTileController]
  /// to optimize offscreen items.
  final int expectedItemCount;

  /// Getter function of the last mounted item index, within the list, to better
  /// optimize out the tiles that don't need fade anymore.
  final int Function()? lastMountedItem;

  /// Delay between every next fade in animation. If set to null,
  /// every next fade will start after the previous one finishes.
  final Duration staggerDuration;

  /// [FadeTiles]s with their index lower than [startFrom] will be ignored.
  final int startFrom;

  /// When the controller is initialized, overrides the currently accounted
  /// highest child index, so all children with the index lower than the
  /// [initialOffset] don't get faded.
  final int Function()? initialOffset;

  /// Whether to only start animating after the route has finished animating.
  final bool awaitRoute;

  /// Pooling controllers will await 1 frame, to allow multiple controllers
  /// to build, before seeking the earliest stopped controller and animating
  /// from that.
  final bool poolControllers;

  /// Preparing controllers early will allow their stagger animations to begin
  /// and finish even if no widget has consumed them yet.
  ///
  /// Older controllers get optimized out by newer ones, if the newer ones
  /// detect unused older ones.
  final bool prepareControllers;

  /// Whether to attept to optimize out fades of off-screen widgets.
  final bool optimizeOutControllers;

  /// Animation duration of each fading tile.
  final Duration duration;

  /// Get a [FadingTileController] from the context.
  static _FadingTileControllerState of(BuildContext context) =>
      Provider.of<_FadingTileControllerState>(context, listen: false);

  @override
  _FadingTileControllerState createState() => _FadingTileControllerState();
}

class _FadingTileControllerState extends State<FadingTileController>
    with TickerProviderStateMixin<FadingTileController> {
  static final _log = Log.named('FadingTileController');
  final _controllers = HashMap<int, AnimationController?>();
  final _animatingControllers = HashSet<int>();
  final _indexes = <int>[];

  late final RefreshStorageEntry<_FadingTileControllerStorage> _storage;

  ModalRoute? _route;
  int _highestRequestedIndex = -1;
  bool get _isAnimationInProgress => _animatingControllers.isNotEmpty;
  int get _maxIndex => _storage.value?.maxIndex ?? -1;
  set _maxIndex(int value) => _storage.value?.maxIndex = value;

  static bool _handleUpdateShouldNotify(dynamic _, dynamic __) => false;

  /// If [considerInitial], this will be the first controller, that starts animating.
  /// Rest of the controllers should either be null or sometimes dismissed.
  ///
  /// If a list receives a lot of items at once, multiple controllers could be created,
  /// but never scheduled, since the index has skipped them. If that happens, use [widget.poolControllers].
  ///
  /// Pooling controllers will await 1 frame, allowing them to finish building, then
  /// seek to the index of the earliest dismissed controller and begin animating from that.
  Future _rescheduleController(int index, {bool considerInitial = false}) async {
    int targetIndex = index;

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
      }

      if (_route != null && mounted) {
        assert(widget.awaitRoute); // If `_route` != null, means we're intended to await the route animation.
        await AwaitRoute.of<dynamic>(context, route: _route);
      }
    }

    if (!considerInitial && widget.staggerDuration > Duration.zero) {
      await Future<void>.delayed(widget.staggerDuration * timeDilation); // Stagger the animation.
    }

    if (mounted) _forwardController(targetIndex);
  }

  /// This mimics `_rescheduleController` conditions but allows still forwarding the controller
  /// synchronously, incase none of the conditions need to be awaited.
  FutureOr _scheduleController(int index, {bool considerInitial = false}) {
    assert(mounted);

    if (considerInitial) {
      if (widget.poolControllers) {
        return _rescheduleController(index, considerInitial: considerInitial);
      } else if (_route != null && !(_route!.animation?.isCompleted ?? true)) {
        return _rescheduleController(index, considerInitial: considerInitial);
      }
    }

    if (!considerInitial && widget.staggerDuration > Duration.zero) {
      return _rescheduleController(index, considerInitial: considerInitial);
    }

    // _log.w('Forwarding controller synchronously');
    if (mounted) _forwardController(index);
  }

  int _getSmallestNonDismissedIndex(int from) {
    int effectiveIndex = from;
    for (int i = from - 1; i >= 0; i -= 1) {
      if (_controllers[i]?.isDismissed == true) {
        effectiveIndex = i;
      } else {
        break;
      }
    }
    return effectiveIndex;
  }

  void _forwardController(int index) {
    assert(mounted);

    final effectiveIndex = _getSmallestNonDismissedIndex(index);

    assert((() {
      if (effectiveIndex < index) {
        _log.w(' !! Effective index reduced to $effectiveIndex, from of $index');
      }
      return true;
    })());

    if (_controllers[effectiveIndex] != null) {
      // _log.i(' ++ Forwarding $effectiveIndex, $_indexes');

      _animatingControllers.add(effectiveIndex);
      _controllers[effectiveIndex]!.forward();

      assert(
        (() {
          for (var i = effectiveIndex; i >= 0; i -= 1) if (_controllers[i]?.isDismissed == true) return false;
          return true;
        })(),
        'Frozen controllers found before index: $effectiveIndex'
        ', animating controllers: ${_animatingControllers.length}'
        ', indexes: ${_controllers.keys}',
      );
    }
    // else {
    //   _log.w(
    //     ' -- Tried to forward $effectiveIndex, but it\'s missing, highest index - $_highestRequestedIndex, max: $_maxIndex'
    //     ', $_indexes',
    //   );
    // }
  }

  AnimationController _createControllerFor(int index) {
    assert(!_controllers.containsKey(index));
    final controller = AnimationController(vsync: this, duration: widget.duration)
      ..addStatusListener((status) => _handleAnimationStatus(index, status));
    _controllers[index] = controller;
    return controller;
  }

  bool _removeAndDisposeControllerAt(int index) {
    final controller = _controllers.remove(index)
      ?..clearStatusListeners() // Clear status listeners so this doesn't handle complete event.
      ..value = 1.0;

    if (controller != null) _animatingControllers.remove(index);
    controller?.dispose();
    return controller != null;
  }

  void _handleAnimationStatus(int index, AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.reverse:
        break; // Ignore.
      case AnimationStatus.forward:
        assert(_isAnimationInProgress);
        if (widget.staggerDuration > Duration.zero) {
          if (widget.prepareControllers) _prepareControllersFor(index + 1);
          if (_controllers.containsKey(index + 1)) _scheduleController(index + 1);
        }
        break;
      case AnimationStatus.completed:
        assert(_isAnimationInProgress);

        if (widget.staggerDuration == Duration.zero) _scheduleController(index + 1);
        _maxIndex = math.max(index, _maxIndex);

        // final isAnimating = _isAnimationInProgress;
        _removeAndDisposeControllerAt(index);

        // if (isAnimating && !_isAnimationInProgress) {
        //   _log.w('Animation ended at index $index');
        // } else {
        //   _log.i('Animating: $_animatingControllers, indexes: $_indexes');
        // }

        if (index >= _indexes.last && widget.optimizeOutControllers) {
          _optimizeOutUselessControllers(index);
          assert(_controllers.isEmpty);
        }

        break;
    }
  }

  void registerIndex(int index) {
    assert(_highestRequestedIndex >= index);

    if (_indexes.isEmpty) {
      _indexes.add(index);
    } else {
      if (index < _indexes.first) {
        _indexes.insert(0, index);
      } else if (index > _indexes.last) {
        _indexes.add(index);
      } else {
        _indexes // This can happen on an orientation change.
          ..add(index)
          ..sort();
      }
    }

    assert(listEquals(_indexes, _indexes.toList(growable: false)..sort()));

    // _log.i('Indexes: $_indexes');
  }

  void unregisterIndex(int index) {
    _indexes.remove(index);
    // _log.i('Indexes: $_indexes');
  }

  /// If the animation has finished, the controller is disposed and this function
  /// returns null.
  AnimationController? getController(int index) {
    if (_highestRequestedIndex < index) _highestRequestedIndex = index;

    if (index <= _maxIndex || index < widget.startFrom) {
      assert(!_controllers.containsKey(index));
      return null;
    }

    // This begins the stagger.
    _prepareControllersFor(index);
    if (!_isAnimationInProgress) _scheduleController(index, considerInitial: true);

    return _controllers[index];
  }

  void _prepareControllersFor(int index) {
    if (!widget.prepareControllers) {
      // Still prepare a single controller for this `index`.
      if (!_controllers.containsKey(index)) _createControllerFor(index);
      return;
    }

    final ceiling = math.max(index + widget.pageSize, widget.expectedItemCount);
    final startFrom = math.max(_maxIndex, index);
    final preparedIndexes = <int>[];

    if (startFrom > widget.expectedItemCount) {
      // _log.wtf('$startFrom > ${widget.expectedItemCount}');
      return;
    }
    // _log.wtf('Ceiling: $ceiling, expected size: ${widget.expectedItemCount}, start from $startFrom');

    // Iterate in reverse, to faster break from already made controllers.
    for (int i = ceiling; i >= startFrom; i -= 1) {
      if (_controllers.containsKey(i)) break;
      _createControllerFor(i);
      preparedIndexes.add(i);
    }

    // _log.wtf('Preparing controllers for $preparedIndexes');
  }

  void _optimizeOutUselessControllers(int index) {
    if (!mounted || !widget.optimizeOutControllers || index < _indexes.last) return;

    final uselessControllers = _controllers.keys.where((k) => k >= index).toList(growable: false);
    int highestOptimizedIndex = index;

    for (final i in uselessControllers) {
      highestOptimizedIndex = math.max(index, i);
      _removeAndDisposeControllerAt(i);
    }

    _maxIndex = math.max(highestOptimizedIndex, _maxIndex);
    if (widget.expectedItemCount > _maxIndex) _maxIndex = widget.expectedItemCount;

    // _log.wtf('Optimized out page, $uselessControllers, max index set at $_maxIndex');

    assert(
      (() {
        for (var i = index; i >= 0; i -= 1) if (_controllers[i]?.isDismissed == true) return false;
        return true;
      })(),
      'Frozen controllers found before index: $index'
      ', animating controllers: ${_animatingControllers.length}'
      ', indexes: ${_controllers.keys}',
    );
  }

  void _optimizeOutByExpectedItemCount([dynamic _]) {
    if (!mounted || !widget.optimizeOutControllers || _isAnimationInProgress) return;

    final optimizationSize = widget.expectedItemCount;
    final uselessControllers = _controllers.keys.where((k) => k < optimizationSize).toList(growable: false);

    uselessControllers.forEach(_removeAndDisposeControllerAt);
    _maxIndex = math.max(optimizationSize - 1, _maxIndex);

    // _log.wtf('Optimized out expected item count, $uselessControllers, max index set at $_maxIndex');

    assert(
      (() {
        for (var i = optimizationSize; i >= 0; i -= 1) if (_controllers[i]?.isDismissed == true) return false;
        return true;
      })(),
      'Frozen controllers found before index: $optimizationSize'
      ', animating controllers: ${_animatingControllers.length}'
      ', indexes: ${_controllers.keys}',
    );
  }

  @override
  void didUpdateWidget(covariant FadingTileController oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(oldWidget._size == widget._size);

    if (widget.optimizeOutControllers && oldWidget.expectedItemCount < widget.expectedItemCount) {
      // _log.w('Fade tile count changed from ${oldWidget.expectedItemCount} -> ${widget.expectedItemCount}');

      // Using a postframe to allow item widgets to build and create controllers,
      // unless they're not onscreen.
      WidgetsBinding.instance!.addPostFrameCallback(_optimizeOutByExpectedItemCount);
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
    if (initialOffset != null) _maxIndex = initialOffset;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _route = widget.awaitRoute ? ModalRoute.of(context) : null;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) controller?.dispose();
    _storage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Provider<_FadingTileControllerState>.value(
        value: this,
        child: widget.child,
        updateShouldNotify: _handleUpdateShouldNotify,
      );
}
