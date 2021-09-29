import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class CompoundTransitionAnimation<T> extends Animation<T>
    with AnimationLazyListenerMixin, AnimationLocalListenersMixin, AnimationLocalStatusListenersMixin {
  CompoundTransitionAnimation({
    required this.compound,
    required this.animation,
    required this.forwardAnimatable,
    this.reverseAnimatable,
    this.invert = false,
  }) {
    _effectiveAnimationStatus = animation.status;
    _updateAnimations();
  }

  final Animation<double> animation;
  final Animatable<T> forwardAnimatable;
  final Animatable<T>? reverseAnimatable;
  final T Function(T a, T b) compound;
  final bool invert;

  final ProxyAnimation _forwardAnimation = ProxyAnimation();
  final ProxyAnimation _reverseAnimation = ProxyAnimation();

  static double compoundScale(double a, double b) => math.min(a, b);
  static double compoundOpacity(double a, double b) => math.min(a, b);
  static Offset compoundTranslation(Offset a, Offset b) => a + b;

  @override
  T get value {
    if (reverseAnimatable == null) {
      if (!invert) {
        return forwardAnimatable.evaluate(_forwardAnimation);
      } else {
        return forwardAnimatable.evaluate(_reverseAnimation);
      }
    }

    final T forwardValue, reverseValue;

    if (!invert) {
      forwardValue = forwardAnimatable.evaluate(_forwardAnimation);
      reverseValue = reverseAnimatable!.evaluate(_reverseAnimation);
    } else {
      forwardValue = forwardAnimatable.evaluate(_reverseAnimation);
      reverseValue = reverseAnimatable!.evaluate(_forwardAnimation);
    }

    return compound(forwardValue, reverseValue);
  }

  @override
  void didStartListening() {
    animation.addListener(_maybeNotifyListeners);
    animation.addStatusListener(_maybeNotifyStatusListeners);
  }

  @override
  void didStopListening() {
    animation.removeListener(_maybeNotifyListeners);
    animation.removeStatusListener(_maybeNotifyStatusListeners);
  }

  /// Gets the status of this animation based on the [forwardAnimation] and [reverseAnimation] status.
  ///
  /// The default is that if the [reverseAnimation] animation is moving, use its status.
  /// Otherwise, default to [forwardAnimation].
  @override
  AnimationStatus get status => _effectiveAnimationStatus;

  @override
  String toString() {
    return '$runtimeType($animation)';
  }

  T? _lastValue;
  void _maybeNotifyListeners() {
    if (value != _lastValue) {
      _lastValue = value;
      notifyListeners();
    }
  }

  late AnimationStatus _effectiveAnimationStatus;
  void _maybeNotifyStatusListeners(AnimationStatus _) {
    final AnimationStatus oldEffective = _effectiveAnimationStatus;
    _effectiveAnimationStatus = _calculateEffectiveAnimationStatus(
      lastEffective: _effectiveAnimationStatus,
      current: animation.status,
    );

    if (oldEffective != _effectiveAnimationStatus) {
      _updateAnimations();
      notifyStatusListeners(status);
    }
  }

  void _updateAnimations() {
    switch (_effectiveAnimationStatus) {
      case AnimationStatus.dismissed:
      case AnimationStatus.forward:
        _forwardAnimation.parent = animation;
        _reverseAnimation.parent = kAlwaysDismissedAnimation;
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.completed:
        _forwardAnimation.parent = kAlwaysCompleteAnimation;
        _reverseAnimation.parent = ReverseAnimation(animation);
        break;
    }
  }

  // When a transition is interrupted midway we just want to play the ongoing
  // animation in reverse. Switching to the actual reverse transition would
  // yield a disjoint experience since the forward and reverse transitions are
  // very different.
  static AnimationStatus _calculateEffectiveAnimationStatus({
    required AnimationStatus lastEffective,
    required AnimationStatus current,
  }) {
    switch (current) {
      case AnimationStatus.dismissed:
      case AnimationStatus.completed:
        return current;
      case AnimationStatus.forward:
        switch (lastEffective) {
          case AnimationStatus.dismissed:
          case AnimationStatus.completed:
          case AnimationStatus.forward:
            return current;
          case AnimationStatus.reverse:
            return lastEffective;
          default:
        }
        break;
      case AnimationStatus.reverse:
        switch (lastEffective) {
          case AnimationStatus.dismissed:
          case AnimationStatus.completed:
          case AnimationStatus.reverse:
            return current;
          case AnimationStatus.forward:
            return lastEffective;
        }
      default:
        break;
    }
    throw 'Unreachable code reached';
  }
}
