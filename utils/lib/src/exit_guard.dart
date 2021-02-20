import 'dart:async';

import 'package:flutter/scheduler.dart';

/// Ask to confirm exit of the app.
class ExitGuard {
  ExitGuard._();

  static final instance = ExitGuard._();
  Timer _timer;

  /// [WillPopScope] callback.
  Future<bool> handleExit(VoidCallback onIntercepted) async {
    if (_timer == null) {
      _timer = Timer(const Duration(seconds: 2) * timeDilation, () => _timer = null);
      onIntercepted();
      return false;
    }

    return true;
  }
}
