// ignore_for_file: avoid_classes_with_only_static_members
library await_route;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// [AwaitRoute] awaits the end of route enter transition animation,
/// of the [ModalRoute] tied to a [BuildContext].
///
/// Useful for views with input fields, where the auto focus should only fire
/// after the route has finished its animation.
class AwaitRoute {
  static Future<void> _awaitNow(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route?.animation?.isCompleted ?? true) return SynchronousFuture<void>(null);

    final completer = Completer<void>();
    final timeout = Timer(const Duration(seconds: 1), completer.complete);

    ValueChanged<AnimationStatus> listener;
    listener = (AnimationStatus status) {
      if (status == AnimationStatus.completed && !completer.isCompleted) {
        if (timeout.isActive) timeout.cancel();
        completer.complete();
        if (listener != null) route.animation.removeStatusListener(listener);
      }
    };

    route.animation.addStatusListener(listener);
    return completer.future;
  }

  static Future<void> _awaitInPostFrame(BuildContext context) {
    final completer = Completer<void>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _awaitNow(context).then(completer.complete));
    return completer.future;
  }

  /// Awaits the end of the [ModalRoute] enter animation.
  ///
  /// Use from [StatefulWidget.didChangeDependencies].
  static Future<void> of(
    BuildContext context, {

    /// Await post frame, to allow this to be called from [StatefulWidget.initState].
    bool postFrame = false,
  }) =>
      postFrame ? _awaitInPostFrame(context) : _awaitNow(context);
}

/// Extension of [BuildContext] to easily access [AwaitRoute] as a helper method.
extension AwaitContextRoute on BuildContext {
  /// Awaits the end of the [ModalRoute] enter animation
  Future awaitRoute({bool postFrame = false}) => AwaitRoute.of(this, postFrame: postFrame);
}
