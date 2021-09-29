import 'package:animations/src/compound_transition_animation/compound_transition_animation.dart';
import 'package:flutter/widgets.dart';

class DualTransitionAnimation<T> extends Animation<T>
    with AnimationLazyListenerMixin, AnimationLocalListenersMixin, AnimationLocalStatusListenersMixin {
  DualTransitionAnimation({
    required this.compound,
    required this.animation,
    this.secondaryAnimation,
  });

  final T Function(T a, T b) compound;
  final CompoundTransitionAnimation<T> animation;
  final CompoundTransitionAnimation<T>? secondaryAnimation;

  @override
  T get value {
    if (secondaryAnimation == null) return animation.value;

    final forwardValue = animation.value;
    final reverseValue = secondaryAnimation!.value;
    return compound(forwardValue, reverseValue);
  }

  @override
  void didStartListening() {
    animation.addListener(_maybeNotifyListeners);
    animation.addStatusListener(_maybeNotifyStatusListeners);
    if (secondaryAnimation != null) {
      secondaryAnimation!.addListener(_maybeNotifyListeners);
      secondaryAnimation!.addStatusListener(_maybeNotifyStatusListeners);
    }
  }

  @override
  void didStopListening() {
    animation.removeListener(_maybeNotifyListeners);
    animation.removeStatusListener(_maybeNotifyStatusListeners);
    if (secondaryAnimation != null) {
      secondaryAnimation!.removeListener(_maybeNotifyListeners);
      secondaryAnimation!.removeStatusListener(_maybeNotifyStatusListeners);
    }
  }

  /// Gets the status of this animation based on the [animation] and [secondaryAnimation] status.
  ///
  /// The default is that if the [secondaryAnimation] animation is moving, use its status.
  /// Otherwise, default to [animation].
  @override
  AnimationStatus get status {
    if (secondaryAnimation != null &&
        (secondaryAnimation!.status == AnimationStatus.forward ||
            secondaryAnimation!.status == AnimationStatus.reverse)) {
      return secondaryAnimation!.status;
    }

    return animation.status;
  }

  @override
  String toString() {
    return '$runtimeType($animation, $secondaryAnimation)';
  }

  T? _lastValue;
  void _maybeNotifyListeners() {
    if (value != _lastValue) {
      _lastValue = value;
      notifyListeners();
    }
  }

  AnimationStatus? _lastStatus;
  void _maybeNotifyStatusListeners(AnimationStatus _) {
    if (status != _lastStatus) {
      _lastStatus = status;
      notifyStatusListeners(status);
    }
  }
}
