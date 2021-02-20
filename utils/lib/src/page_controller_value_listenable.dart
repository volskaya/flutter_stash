import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Passes listeners to the [PageController] while returning an adjusted value,
/// depending on [base].
class PageControllerValueListenable implements ValueListenable<double> {
  const PageControllerValueListenable({
    @required this.controller,
    this.base = 0,
  });

  final PageController controller;
  final int base;

  @override
  void addListener(VoidCallback listener) => controller.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => controller.removeListener(listener);

  @override
  double get value => controller.page % math.max(base, 1);
}
