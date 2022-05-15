import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';
import 'package:refresh_storage/refresh_storage.dart';

part 'fading_tile_coordinator.freezed.dart';

@freezed
class FadingTileProps with _$FadingTileProps {
  const factory FadingTileProps({
    required AnimationController controller,
  }) = _FadingTileProps;

  const factory FadingTileProps.delayed({
    required AnimationController controller,
    required Interval interval,
  }) = _FadingTilePropsDelayed;

  const factory FadingTileProps.inProgress({
    required AnimationController controller,
    required double progress,
  }) = _FadingTilePropsInProgress;
}

class FadingTileCoordinator extends RefreshStorageItem {
  FadingTileCoordinator({
    this.staggerDuration = const Duration(milliseconds: 30),
    this.expectedItemCount,
  });

  final Duration staggerDuration;

  final _indexes = <int>[];
  final _animatingIndexes = <int>[];

  int? expectedItemCount;
  int? lastFadeTime;
  MapEntry<int, int>? anchor;
  int _maxIndex = -1;

  static FadingTileCoordinator of(BuildContext context) => Provider.of<FadingTileCoordinator>(context, listen: false);

  FadingTileProps? requestFade(
    int index,
    TickerProvider vsync, {
    required Duration fadeDuration,
  }) {
    if (_maxIndex > index) return null;

    final now = DateTime.now();

    if (anchor == null) {
      lastFadeTime = now.millisecondsSinceEpoch;
      anchor = MapEntry(index, now.millisecondsSinceEpoch);

      return FadingTileProps(
        controller: AnimationController(
          vsync: vsync,
          duration: fadeDuration,
        ),
      );
    } else {
      final lastFadeTime = anchor!.value + (staggerDuration.inMilliseconds * (index - anchor!.key));
      final supposedFadeTime = lastFadeTime + staggerDuration.inMilliseconds;

      if (supposedFadeTime >= now.millisecondsSinceEpoch) {
        // This index is not supposed to fade in yet and the controller can wait.

        final awaitTime = supposedFadeTime - now.millisecondsSinceEpoch;
        final effectiveFadeDuration = Duration(milliseconds: awaitTime + fadeDuration.inMilliseconds);
        final intervalBegin = awaitTime / effectiveFadeDuration.inMilliseconds;

        return FadingTileProps.delayed(
          interval: Interval(intervalBegin, 1.0),
          controller: AnimationController(
            vsync: vsync,
            duration: effectiveFadeDuration,
          ),
        );
      } else {
        // This index should have been faded in yet.

        final elapsedTime = now.millisecondsSinceEpoch - supposedFadeTime;
        final t = elapsedTime / fadeDuration.inMilliseconds;
        final effectiveFadeDuration = fadeDuration * (1.0 - t);

        if (t < 1.0) {
          return FadingTileProps.inProgress(
            progress: t,
            controller: AnimationController(
              vsync: vsync,
              duration: effectiveFadeDuration,
            ),
          );
        } else {
          // Nothing to animate anymore, leave the controller null.
          anchor = null;
          bumpMaxIndex(index);
        }

        assert(!elapsedTime.isNegative);
      }
    }
    return null;
  }

  void registerIndex(int index) {
    assert(!_indexes.contains(index));

    if (_indexes.isEmpty) {
      _indexes.add(index);
    } else if (index < _indexes.first) {
      _indexes.insert(0, index);
    } else if (index > _indexes.last) {
      _indexes.add(index);
    } else {
      _indexes // This can happen on an orientation change.
        ..add(index)
        ..sort();
    }

    assert(listEquals(_indexes, _indexes.toList(growable: false)..sort()));
  }

  void registerAnimatingIndex(int index) {
    assert(!_animatingIndexes.contains(index));

    if (_animatingIndexes.isEmpty) {
      _animatingIndexes.add(index);
    } else if (index < _animatingIndexes.first) {
      _animatingIndexes.insert(0, index);
    } else if (index > _animatingIndexes.last) {
      _animatingIndexes.add(index);
    } else {
      _animatingIndexes // This can happen on an orientation change.
        ..add(index)
        ..sort();
    }

    assert(listEquals(_animatingIndexes, _animatingIndexes.toList(growable: false)..sort()));
  }

  bool unregisterIndex(int index) => _indexes.remove(index);
  bool unregisterAnimatingIndex(int index, {bool didComplete = false}) {
    final removed = _animatingIndexes.remove(index);

    // When the last item finishes animating, reset the anchor and bump the last index
    // to the expected item count.
    if (didComplete && removed && _indexes.last <= index) {
      anchor = null;
      bumpMaxIndex(index);
    }

    if (_animatingIndexes.isEmpty) anchor = null;
    return removed;
  }

  void bumpMaxIndex(int newIndex) {
    _maxIndex = math.max(newIndex, expectedItemCount != null ? math.max(_maxIndex, expectedItemCount!) : _maxIndex);
  }

  void bumpExpectedItemCount(int newCount) {
    assert(expectedItemCount == null || newCount > expectedItemCount!);
    expectedItemCount = newCount;
    if (_animatingIndexes.isEmpty) _maxIndex = math.max(_maxIndex, newCount);
  }
}
