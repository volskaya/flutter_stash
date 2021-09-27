library revealing_bar;

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';

part 'revealing_bar.freezed.dart';

/// Optional conditional of [RevealingBar] to further finetune visible condition.
///
/// Return `true` to indicate the bar should be hidden.
typedef RevealingBarConditional = bool Function(bool shouldHide);

/// [RevealingBar] child's custom builder.
typedef RevealingBarBuilder = Widget Function(BuildContext context, Widget? child, bool hide);

/// Notification sent out by [RevealingBarNotifier] to [RevealingBarController]s.
@freezed
class RevealingBarNotification with _$RevealingBarNotification {
  const factory RevealingBarNotification({
    required double maxExtent,
    double? localOffset,
    double? remoteOffset,
  }) = _RevealingBarNotification;
}

class RevealingBarControllerState {
  RevealingBarControllerState({
    this.safeArea = 0,
    this.onlyShowBelowSafeArea = false,
    this.revealAtEnd = false,
  }) {
    notifier = ValueNotifier<bool>(!(onlyShowBelowSafeArea && safeArea > 0));
  }

  /// The offset past which to hide the bar.
  final double safeArea;

  /// Keeps the bar hidden, unless scrolled past the [safeArea].
  final bool onlyShowBelowSafeArea;

  /// Whether the bars should reveal, when the last scrollable reaches the end.
  final bool revealAtEnd;

  final _locks = HashSet<dynamic>();

  /// Holds the boolean of whether the bars should be hidden.
  late final ValueNotifier<bool> notifier;
  bool get locked => _locks.isNotEmpty;
  double get _globalScrollOffset => _lastLocalOffset + _lastRemoteOffset;
  double get _globalMaxExtent => _lastLocalMaxExtent + _lastRemoteMaxExtent;

  double _lastLocalMaxExtent = 0;
  double _lastLocalOffset = 0;
  double _lastRemoteMaxExtent = 0;
  double _lastRemoteOffset = 0;
  double _lastGlobalScrollOffset = 0;

  void _setVisibility(bool status) {
    if (notifier.value != status && !locked) notifier.value = status;
  }

  void _alignBars({bool ignoreVelocity = false}) {
    final force = onlyShowBelowSafeArea ? _globalScrollOffset < safeArea : false;

    // Animate in/out appbar and navbar, depending on scroll direction
    if (!force) {
      final velocity = _globalScrollOffset - _lastGlobalScrollOffset;
      final withinSafeArea = _globalScrollOffset < safeArea;
      final isAtEnd = revealAtEnd && _globalScrollOffset == _globalMaxExtent;

      if (isAtEnd) {
        _setVisibility(true); // Visible.
      } else if (withinSafeArea || (velocity < -5 || ignoreVelocity)) {
        _setVisibility(true); // Visible.
      } else if ((velocity > 5 || ignoreVelocity) && !withinSafeArea) {
        _setVisibility(false); // Not visible.
      }
    } else {
      _setVisibility(false);
    }

    _lastGlobalScrollOffset = _globalScrollOffset;
  }

  // Handles a scroll notification.
  void push(RevealingBarNotification notification) {
    if (notification.localOffset != null) {
      _lastLocalOffset = notification.localOffset!;
      _lastLocalMaxExtent = notification.maxExtent;
    }
    if (notification.remoteOffset != null) {
      _lastRemoteOffset = notification.remoteOffset!;
      _lastRemoteMaxExtent = notification.maxExtent;
    }

    // If nothing changed, just update `_lastGlobalScrollOffset`
    if (_globalScrollOffset == _lastGlobalScrollOffset) {
      _lastGlobalScrollOffset = _globalScrollOffset;
    } else {
      _alignBars();
    }
  }

  void reveal() {
    if (!locked) notifier.value = true;
  }

  void lock(dynamic locker) {
    final added = _locks.add(locker);
    if (added) notifier.value = true;
  }

  void release(dynamic locker) {
    final removed = _locks.remove(locker);
    if (removed && !locked) _alignBars(ignoreVelocity: true);
  }

  void dispose() {
    notifier.dispose();
  }
}

/// Listens for updates from [RevealingBarNotifier]s and calculates if bars
/// should be visible or hidden.
class RevealingBarControllerProvider {
  const RevealingBarControllerProvider._();

  /// Get the nearest [RevealingBarControllerState].
  static RevealingBarControllerState of(BuildContext context) =>
      Provider.of<RevealingBarControllerState>(context, listen: false);

  /// Has the [RevealingBarController] set bars as should be visible.
  static void reveal(BuildContext context) => RevealingBarController.of(context).reveal();

  static Widget build({
    Key? key,
    required Widget child,
    double safeArea = 0.0,
    bool onlyShowBelowSafeArea = false,
    bool revealAtEnd = false,
  }) =>
      Provider<RevealingBarControllerState>(
        // key: ValueKey(hashValues(revealAtEnd, onlyShowBelowSafeArea, safeArea)),
        child: child,
        dispose: (_, v) => v.dispose(),
        create: (_) => RevealingBarControllerState(
          revealAtEnd: revealAtEnd,
          onlyShowBelowSafeArea: onlyShowBelowSafeArea,
          safeArea: safeArea,
        ),
      );
}

/// Listens for updates from [RevealingBarNotifier]s and calculates if bars
/// should be visible or hidden.
class RevealingBarController extends StatelessWidget {
  /// Creates [RevealingBarController].
  const RevealingBarController({
    Key? key,
    required this.child,
    this.safeArea = 0,
    this.onlyShowBelowSafeArea = false,
    this.local,
    this.remote,
    this.revealAtEnd = false,
  })  : assert(local == null || local >= 0),
        assert(remote == null || (local != null && remote > local), 'Use `local` first'),
        super(key: key);

  /// Child widget of [RevealingBarController].
  final Widget child;

  /// If not null, will automatically wrap child in a [RevealingBarNotifier] with a local position.
  final int? local;

  /// If not null, will automatically wrap child in a [RevealingBarNotifier] with a remote position.
  final int? remote;

  /// The offset past which to hide the bar.
  final double safeArea;

  /// Keeps the bar hidden, unless scrolled past the [safeArea].
  final bool onlyShowBelowSafeArea;

  /// Whether the bars should reveal, when the last scrollable reaches the end.
  final bool revealAtEnd;

  /// Get the nearest [RevealingBarControllerState].
  static RevealingBarControllerState of(BuildContext context) =>
      Provider.of<RevealingBarControllerState>(context, listen: false);

  /// Has the [RevealingBarController] set bars as should be visible.
  static void reveal(BuildContext context) => RevealingBarController.of(context).reveal();

  @override
  Widget build(BuildContext context) {
    final provider = Provider<RevealingBarControllerState>(
      child: child,
      dispose: (_, v) => v.dispose(),
      create: (_) => RevealingBarControllerState(
        revealAtEnd: revealAtEnd,
        onlyShowBelowSafeArea: onlyShowBelowSafeArea,
        safeArea: safeArea,
      ),
    );

    return local != null
        ? RevealingBarNotifier(
            local: local!,
            remote: remote,
            child: provider,
          )
        : provider;
  }
}

/// Listens to [ScrollNotification]s and pushes updates to nearest [RevealingBarController].
class RevealingBarNotifier extends StatelessWidget {
  /// Creates [RevealingBarNotifier].
  const RevealingBarNotifier({
    Key? key,
    required this.child,
    this.local = 0,
    this.remote,
  })  : assert(local >= 0),
        assert(remote == null || remote > local),
        super(key: key);

  /// A global toggle to disable [RevealingBarNotifier]s from sending messages.
  @visibleForTesting static bool disable = false;

  /// Closest scroll controller index.
  final int local;

  /// Remote scroll controller index, in case of a nested scroll view.
  final int? remote;

  /// Child scrollable widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    final controller = RevealingBarController.of(context);

    return NotificationListener<ScrollNotification>(
      child: child,
      onNotification: (notification) {
        // Ignore notifications from animating out routes.
        if (route?.isCurrent != true || disable) return false;

        RevealingBarNotification? update;

        if (notification.depth == local) {
          update = RevealingBarNotification(
            localOffset: notification.metrics.pixels,
            maxExtent: notification.metrics.maxScrollExtent,
          );
        } else if (notification.depth == remote) {
          update = RevealingBarNotification(
            remoteOffset: notification.metrics.pixels,
            maxExtent: notification.metrics.maxScrollExtent,
          );
        }

        if (update != null) controller.push(update);
        return false;
      },
    );
  }
}

/// Abstracts transform animation for revealing bars.
class RevealingBar extends StatefulWidget {
  /// Creates [RevealingBar]
  const RevealingBar({
    Key? key,
    this.child,
    this.conditional,
    this.alignment = Alignment.topCenter,
    this.builder,
    this.ignoring,
    this.bounceOut = false,
    this.optimizeOutChild = false,
    this.bounceOutDuration = const Duration(milliseconds: 600),
    this.duration = const Duration(milliseconds: 250),
  })  : assert(child != null || builder != null),
        super(key: key);

  /// Optional child widget. If this is null, [build] must be defined.
  final Widget? child;

  /// Return `true` to indicate the bar should be hidden.
  final RevealingBarConditional? conditional;

  /// Alignment of the slide animation.
  final Alignment alignment;

  /// Optional custom builder, makes [child] ineffective.
  final RevealingBarBuilder? builder;

  /// Whether the pointer should be ignored.
  final bool? ignoring;

  /// Whether to use a bounce out curve, for the reveal animation.
  final bool bounceOut;

  /// Whether to build the [child], when the bar is hidden.
  final bool optimizeOutChild;

  /// Bounce out's animation duration. Bounce out is toggled with [bounceOut].
  final Duration bounceOutDuration;

  /// Toggle animation duration;
  final Duration duration;

  @override
  State<RevealingBar> createState() => _RevealingBarState();
}

class _RevealingBarState extends State<RevealingBar> {
  RevealingBarControllerState? _controller;
  Offset? _optimizeOutOffset;

  bool get _showBars => _controller?.notifier.value ?? true;

  void _handleOptizeOutOffsetChange() =>
      _optimizeOutOffset = widget.optimizeOutChild ? Offset(widget.alignment.x, widget.alignment.y) : null;

  @override
  void initState() {
    super.initState();
    _controller = RevealingBarController.of(context)..notifier.addListener(markNeedsBuild);
    _handleOptizeOutOffsetChange();
  }

  @override
  void didUpdateWidget(covariant RevealingBar oldWidget) {
    if (oldWidget.optimizeOutChild != widget.optimizeOutChild) _handleOptizeOutOffsetChange();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller?.notifier.removeListener(markNeedsBuild);
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shouldHide = widget.conditional?.call(!_showBars) ?? !_showBars;

    return IgnorePointer(
      ignoring: widget.ignoring ?? shouldHide,
      child: widget.builder?.call(context, widget.child, shouldHide) ??
          TweenAnimationBuilder<Offset>(
            duration: !shouldHide && widget.bounceOut ? widget.bounceOutDuration : widget.duration,
            curve: !shouldHide && widget.bounceOut ? Curves.elasticOut : standardEasing,
            tween: Tween<Offset>(
                end: shouldHide ? _optimizeOutOffset ?? Offset(widget.alignment.x, widget.alignment.y) : Offset.zero),
            builder: (_, offset, ___) => FractionalTranslation(
              translation: offset,
              child: offset == _optimizeOutOffset ? null : widget.child,
            ),
          ),
    );
  }
}
