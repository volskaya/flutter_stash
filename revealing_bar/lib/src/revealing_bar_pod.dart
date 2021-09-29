import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revealing_bar/src/revealing_bar_notification.dart';

part 'revealing_bar_pod.freezed.dart';

@freezed
class RevealingBarProps with _$RevealingBarProps {
  const factory RevealingBarProps({
    @Default(0.0) double safeArea,
    @Default(false) bool onlyShowBelowSafeArea,
    @Default(false) bool revealAtEnd,
  }) = _RevealingBarProps;

  const RevealingBarProps._();

  ChangeNotifierProvider<RevealingBarPod> getProviderFamily() => RevealingBarPod.providerFamily(this);
  Override getProviderOverride() => RevealingBarPod.provider.overrideWithProvider(getProviderFamily());
}

class RevealingBarPod extends ChangeNotifier implements ValueListenable<bool> {
  RevealingBarPod({
    this.props = const RevealingBarProps(),
  }) {
    value = !(props.onlyShowBelowSafeArea && props.safeArea > 0);
  }

  static RevealingBarPod of(BuildContext context, {bool listen = false}) =>
      ProviderScope.containerOf(context, listen: listen).read(provider.notifier);

  static final provider = ChangeNotifierProvider<RevealingBarPod>((_) => RevealingBarPod());
  static final providerFamily = ChangeNotifierProvider.family<RevealingBarPod, RevealingBarProps>(
    (_, props) => RevealingBarPod(props: props),
  );

  final RevealingBarProps props;
  final _locks = HashSet<dynamic>();

  @override late bool value;

  bool get locked => _locks.isNotEmpty;
  double get _globalScrollOffset => _lastLocalOffset + _lastRemoteOffset;
  double get _globalMaxExtent => _lastLocalMaxExtent + _lastRemoteMaxExtent;

  double _lastLocalMaxExtent = 0;
  double _lastLocalOffset = 0;
  double _lastRemoteMaxExtent = 0;
  double _lastRemoteOffset = 0;
  double _lastGlobalScrollOffset = 0;

  void _setVisibility(bool status) {
    if (value != status && !locked) {
      value = status;
      notifyListeners();
    }
  }

  void _alignBars({bool ignoreVelocity = false}) {
    final force = props.onlyShowBelowSafeArea ? _globalScrollOffset < props.safeArea : false;

    // Animate in/out appbar and navbar, depending on scroll direction
    if (!force) {
      final velocity = _globalScrollOffset - _lastGlobalScrollOffset;
      final withinSafeArea = _globalScrollOffset < props.safeArea;
      final isAtEnd = props.revealAtEnd && _globalScrollOffset == _globalMaxExtent;

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
    if (!locked && value != true) {
      value = true;
      notifyListeners();
    }
  }

  void lock(dynamic locker) {
    final added = _locks.add(locker);
    if (added && value != true) {
      value = true;
      notifyListeners();
    }
  }

  void release(dynamic locker) {
    final removed = _locks.remove(locker);
    if (removed && !locked) _alignBars(ignoreVelocity: true);
  }
}
