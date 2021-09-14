import 'dart:math' as math;

import 'package:animations/src/inherited_animation/inherited_animation_variants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';

part 'inherited_animation.freezed.dart';

@freezed
class InheritedAnimationValue with _$InheritedAnimationValue {
  const factory InheritedAnimationValue({
    @Default(1.0) double opacity,
    @Default(1.0) double scale,
    @Default(Offset.zero) Offset translation,
  }) = _InheritedAnimationValue;
}

class InheritedAnimation extends Listenable
    with AnimationLazyListenerMixin, AnimationLocalListenersMixin, AnimationLocalStatusListenersMixin {
  InheritedAnimation({
    this.parent,
    this.opacityAnimation,
    this.scaleAnimation,
    this.translationAnimation,
    this.inheritOpacity = true,
    this.inheritScale = true,
    this.inheritTranslation = true,
  });

  static InheritedAnimation? of(BuildContext context, {bool listen = true}) {
    try {
      return Provider.of<InheritedAnimation?>(context, listen: listen);
    } catch (_) {}
  }

  final InheritedAnimation? parent;
  final Animation<double>? opacityAnimation;
  final Animation<double>? scaleAnimation;
  final Animation<Offset>? translationAnimation;
  final bool inheritOpacity;
  final bool inheritScale;
  final bool inheritTranslation;

  double get _parentOpacityValue => inheritOpacity ? parent?.opacity ?? 1.0 : 1.0;
  double get _parentScaleValue => inheritScale ? parent?.scale ?? 1.0 : 1.0;
  Offset get _parentTranslationValue => inheritTranslation ? parent?.translation ?? Offset.zero : Offset.zero;

  double get _opacityValue => opacityAnimation?.value ?? 1.0;
  double get _scaleValue => scaleAnimation?.value ?? 1.0;
  Offset get _translationValue => translationAnimation?.value ?? Offset.zero;

  double get opacity => math.min(_parentOpacityValue, _opacityValue);
  double get scale => math.min(_parentScaleValue, _scaleValue);
  Offset get translation => _parentTranslationValue + _translationValue;

  AnimationStatus get opacityStatus =>
      (inheritOpacity ? _reuseAnimationStatus(parent?.opacityStatus) : null) ??
      opacityAnimation?.status ??
      AnimationStatus.completed;

  AnimationStatus get scaleStatus =>
      (inheritScale ? _reuseAnimationStatus(parent?.scaleStatus) : null) ??
      scaleAnimation?.status ??
      AnimationStatus.completed;

  AnimationStatus get translationStatus =>
      (inheritTranslation ? _reuseAnimationStatus(parent?.translationStatus) : null) ??
      translationAnimation?.status ??
      AnimationStatus.completed;

  static AnimationStatus? _reuseAnimationStatus(AnimationStatus? status) =>
      _shouldUseAnimationSatus(status) ? status : null;

  static bool _shouldUseAnimationSatus(AnimationStatus? status) =>
      status == AnimationStatus.forward || status == AnimationStatus.reverse;

  @override
  void didStartListening() {
    bool hasInheritance = false;

    if (inheritOpacity) {
      hasInheritance = true;
      opacityAnimation?.addListener(_maybeNotifyListeners);
      opacityAnimation?.addStatusListener(_maybeNotifyStatusListeners);
    }
    if (inheritScale) {
      hasInheritance = true;
      scaleAnimation?.addListener(_maybeNotifyListeners);
      scaleAnimation?.addStatusListener(_maybeNotifyStatusListeners);
    }
    if (inheritTranslation) {
      hasInheritance = true;
      translationAnimation?.addListener(_maybeNotifyListeners);
      translationAnimation?.addStatusListener(_maybeNotifyStatusListeners);
    }

    if (hasInheritance) {
      parent?.addListener(_maybeNotifyListeners);
      parent?.addStatusListener(_maybeNotifyStatusListeners);
    }
  }

  @override
  void didStopListening() {
    bool hasInheritance = false;

    if (inheritOpacity) {
      hasInheritance = true;
      opacityAnimation?.removeListener(_maybeNotifyListeners);
      opacityAnimation?.removeStatusListener(_maybeNotifyStatusListeners);
    }
    if (inheritScale) {
      hasInheritance = true;
      scaleAnimation?.removeListener(_maybeNotifyListeners);
      scaleAnimation?.removeStatusListener(_maybeNotifyStatusListeners);
    }
    if (inheritTranslation) {
      hasInheritance = true;
      translationAnimation?.removeListener(_maybeNotifyListeners);
      translationAnimation?.removeStatusListener(_maybeNotifyStatusListeners);
    }

    if (hasInheritance) {
      parent?.addListener(_maybeNotifyListeners);
      parent?.addStatusListener(_maybeNotifyStatusListeners);
    }
  }

  void _maybeNotifyListeners() {
    notifyListeners();
  }

  void _maybeNotifyStatusListeners(AnimationStatus _) {
    notifyStatusListeners(AnimationStatus.completed);
  }

  InheritedAnimationValue freeze() => InheritedAnimationValue(
        opacity: opacity,
        scale: scale,
        translation: translation,
      );

  InheritedAnimation copyWith({
    bool opacity = true,
    bool scale = true,
    bool translation = true,
  }) =>
      InheritedAnimation(
        opacityAnimation: opacity ? opacityAnimation : null,
        scaleAnimation: scale ? scaleAnimation : null,
        translationAnimation: translation ? translationAnimation : null,
        inheritOpacity: opacity,
        inheritScale: scale,
        inheritTranslation: translation,
      );

  InheritedOpacityAnimation selectOpacityVariant() => InheritedOpacityAnimation(this);
  InheritedScaleAnimation selectScaleVariant() => InheritedScaleAnimation(this);
  InheritedTranslationAnimation selectTranslationVariant() => InheritedTranslationAnimation(this);
}
