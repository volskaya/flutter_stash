import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

/// Attaches to a [ScrollController] and notifies of when it's scrolled
/// past a certain offset.
class ScrollControllerToggle extends ChangeNotifier implements ValueListenable<bool> {
  ScrollControllerToggle({
    @required this.controller,
    this.offset = 0,
    bool initialValue,
    bool calculateInitialValuePostFrame = false,
  }) {
    controller.addListener(_handleChange);

    if (initialValue != null) {
      _value = initialValue;
    } else if (calculateInitialValuePostFrame) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _value = Utils.isScrolled(controller, offset),
      );
    } else {
      _value = Utils.isScrolled(controller, offset);
    }
  }

  final ScrollController controller;

  double offset;
  bool _value = false;
  @override
  bool get value => _value;

  void _handleChange() {
    final isScrolledNow = Utils.isScrolled(controller, offset);
    if (_value != isScrolledNow) {
      _value = isScrolledNow;
      notifyListeners();
    }
  }

  void changeOffset(double newOffset) {
    if (newOffset != offset) {
      offset = newOffset;
      _handleChange();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_handleChange);
  }
}
