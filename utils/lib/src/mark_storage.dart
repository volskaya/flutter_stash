import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:log/log.dart';
import 'package:refresh_storage/refresh_storage.dart';

class MarkStorage extends RefreshStorageItem {
  MarkStorage(this.identifier, this._mark);

  static final _log = Log.named('MarkStorage');

  final String identifier;
  final FutureOr<void> Function() _mark;

  bool _marked = false;

  Future handleMark() async {
    if (_marked) return; // Redundant.
    _marked = true;
    try {
      await _mark();
    } catch (e, t) {
      _marked = false;
      _log.e('Failed to mark $identifier', e, t);
    }
  }

  static Future mark(
    BuildContext context, {
    @required FutureOr<void> Function() callback,
    @required String bucket,
  }) {
    final identifier = '${bucket}_mark_write';
    final storage = RefreshStorage.write(
      context: context,
      refreshes: 0,
      identifier: identifier,
      builder: () => MarkStorage(identifier, callback),
    );

    try {
      return !storage.value._marked ? storage.value.handleMark() : SynchronousFuture(null);
    } finally {
      storage.dispose();
    }
  }
}
