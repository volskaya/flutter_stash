import 'package:animations/src/inherited_animation/inherited_animation.dart';
import 'package:flutter/material.dart';

class InheritedOpacityAnimation extends Animation<double>
    with AnimationLazyListenerMixin, AnimationLocalListenersMixin, AnimationLocalStatusListenersMixin {
  InheritedOpacityAnimation(this.parent);

  final InheritedAnimation parent;

  @override
  void didStartListening() {
    parent.addListener(_maybeNotifyListeners);
    parent.addStatusListener(_maybeNotifyStatusListeners);
  }

  @override
  void didStopListening() {
    parent.removeListener(_maybeNotifyListeners);
    parent.removeStatusListener(_maybeNotifyStatusListeners);
  }

  @override
  AnimationStatus get status => parent.opacityStatus;

  @override
  double get value => parent.opacity;

  double? _lastValue;
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

class InheritedScaleAnimation extends Animation<double>
    with AnimationLazyListenerMixin, AnimationLocalListenersMixin, AnimationLocalStatusListenersMixin {
  InheritedScaleAnimation(this.parent);

  final InheritedAnimation parent;

  @override
  void didStartListening() {
    parent.addListener(_maybeNotifyListeners);
    parent.addStatusListener(_maybeNotifyStatusListeners);
  }

  @override
  void didStopListening() {
    parent.removeListener(_maybeNotifyListeners);
    parent.removeStatusListener(_maybeNotifyStatusListeners);
  }

  @override
  AnimationStatus get status => parent.scaleStatus;

  @override
  double get value => parent.scale;

  double? _lastValue;
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

class InheritedTranslationAnimation extends Animation<Offset>
    with AnimationLazyListenerMixin, AnimationLocalListenersMixin, AnimationLocalStatusListenersMixin {
  InheritedTranslationAnimation(this.parent);

  final InheritedAnimation parent;

  @override
  void didStartListening() {
    parent.addListener(_maybeNotifyListeners);
    parent.addStatusListener(_maybeNotifyStatusListeners);
  }

  @override
  void didStopListening() {
    parent.removeListener(_maybeNotifyListeners);
    parent.removeStatusListener(_maybeNotifyStatusListeners);
  }

  @override
  AnimationStatus get status => parent.translationStatus;

  @override
  Offset get value => parent.translation;

  Offset? _lastValue;
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
