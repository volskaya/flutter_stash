library await_route;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// [AwaitRoute] awaits the end of route enter transition animation,
/// of the [ModalRoute] tied to a [BuildContext].
///
/// Useful for views with input fields, where the auto focus should only fire
/// after the route has finished its animation.
abstract class AwaitRoute {
  static Future<ModalRoute<T>?> _awaitNow<T extends Object?>(BuildContext context) {
    final route = ModalRoute.of<T>(context);
    if (route?.animation?.isCompleted ?? true) return SynchronousFuture<ModalRoute<T>?>(route);

    final completer = Completer<ModalRoute<T>>();
    Timer? timeout;
    timeout = Timer(const Duration(seconds: 1) * timeDilation, () {
      if (timeout?.isActive == true) timeout?.cancel();
      completer.complete(route);
    });

    ValueChanged<AnimationStatus>? listener;
    listener = (AnimationStatus status) {
      if (status == AnimationStatus.completed && !completer.isCompleted) {
        if (timeout?.isActive == true) timeout?.cancel();
        completer.complete(route);
        if (listener != null) route!.animation!.removeStatusListener(listener);
      }
    };

    route!.animation!.addStatusListener(listener);
    return completer.future;
  }

  static Future<ModalRoute<T>?> _awaitInPostFrame<T extends Object?>(BuildContext context) {
    if (WidgetsBinding.instance == null) return SynchronousFuture<ModalRoute<T>?>(null);

    final completer = Completer<ModalRoute<T>?>();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _awaitNow<T>(context).then(completer.complete));
    return completer.future;
  }

  /// Awaits the end of the [ModalRoute] enter animation.
  ///
  /// Use from [StatefulWidget.didChangeDependencies].
  static Future<ModalRoute<T>?> of<T extends Object?>(
    BuildContext context, {

    /// Await post frame, to allow this to be called from [StatefulWidget.initState].
    bool postFrame = false,
  }) =>
      postFrame ? _awaitInPostFrame<T>(context) : _awaitNow<T>(context);
}

/// Extension of [BuildContext] to easily access [AwaitRoute] as a helper method.
extension AwaitContextRoute on BuildContext {
  /// Awaits the end of the [ModalRoute] enter animation
  Future<ModalRoute<T>?> awaitRoute<T extends Object?>({bool postFrame = false}) =>
      AwaitRoute.of<T>(this, postFrame: postFrame);
}
