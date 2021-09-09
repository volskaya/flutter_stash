import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inherited_animation_listenable.freezed.dart';

@freezed
class InheritedAnimationValue with _$InheritedAnimationValue {
  const factory InheritedAnimationValue({
    @Default(1.0) double opacity,
    @Default(1.0) double scale,
    @Default(0.0) double rotation,
    @Default(Offset.zero) Offset translation,
  }) = _InheritedAnimationValue;
}

@immutable
class InheritedAnimationListenable implements Listenable {
  InheritedAnimationListenable({
    this.parent,
    this.opacityAnimation,
    this.scaleAnimation,
    this.rotationAnimation,
    this.translationAnimation,
    this.inheritOpacity = true,
    this.inheritScale = true,
    this.inheritRotation = true,
    this.inheritTranslation = true,
  })  : parents = parent != null ? parent.parents + 1 : 0,
        trackedScales = parent?.scaleAnimation != null && inheritScale
            ? parent!.trackedScales + (scaleAnimation != null ? 1 : 0)
            : (scaleAnimation != null ? 1 : 0);

  static InheritedAnimationListenable? of(BuildContext context, {bool listen = true}) {
    try {
      return Provider.of<InheritedAnimationListenable?>(context, listen: listen);
    } catch (_) {}
  }

  final InheritedAnimationListenable? parent;
  final Animation<double>? opacityAnimation;
  final Animation<double>? scaleAnimation;
  final Animation<double>? rotationAnimation;
  final Animation<Offset>? translationAnimation;
  final bool inheritOpacity;
  final bool inheritScale;
  final bool inheritRotation;
  final bool inheritTranslation;
  final int parents;
  final int trackedScales;

  double get _parentOpacityValue => inheritOpacity ? parent?.opacity ?? 1.0 : 1.0;
  double get _parentScaleValue => inheritScale ? parent?.scale ?? 1.0 : 1.0;
  double get _parentRotationValue => inheritRotation ? parent?.rotation ?? 0.0 : 0.0;
  Offset get _parentTranslationValue => inheritTranslation ? parent?.translation ?? Offset.zero : Offset.zero;

  double get _opacityValue => opacityAnimation?.value ?? 1.0;
  double get _scaleValue => scaleAnimation?.value ?? 1.0;
  double get _rotationValue => rotationAnimation?.value ?? 0.0;
  Offset get _translationValue => translationAnimation?.value ?? Offset.zero;

  double get opacity => math.min(_parentOpacityValue, _opacityValue);
  // double get scale => (_parentScaleValue * parents + _scaleValue) / (parents + 1);
  double get scale => math.min(_parentScaleValue, _scaleValue);
  double get rotation => _parentRotationValue + _rotationValue;
  Offset get translation => _parentTranslationValue + _translationValue;

  @override
  void addListener(VoidCallback listener) {
    parent?.addListener(listener);
    if (inheritOpacity) opacityAnimation?.addListener(listener);
    if (inheritScale) scaleAnimation?.addListener(listener);
    if (inheritRotation) rotationAnimation?.addListener(listener);
    if (inheritTranslation) translationAnimation?.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    parent?.removeListener(listener);
    if (inheritOpacity) opacityAnimation?.removeListener(listener);
    if (inheritScale) scaleAnimation?.removeListener(listener);
    if (inheritRotation) rotationAnimation?.removeListener(listener);
    if (inheritTranslation) translationAnimation?.removeListener(listener);
  }

  InheritedAnimationListenable copyWith({
    bool opacity = true,
    bool scale = true,
    bool rotation = true,
    bool translation = true,
  }) =>
      InheritedAnimationListenable(
        opacityAnimation: opacity ? opacityAnimation : null,
        scaleAnimation: scale ? scaleAnimation : null,
        rotationAnimation: rotation ? rotationAnimation : null,
        translationAnimation: translation ? translationAnimation : null,
        inheritOpacity: opacity,
        inheritScale: scale,
        inheritRotation: rotation,
        inheritTranslation: translation,
      );

  InheritedAnimationValue freeze() => InheritedAnimationValue(
        opacity: opacity,
        scale: scale,
        rotation: rotation,
        translation: translation,
      );
}
