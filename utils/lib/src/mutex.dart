import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loader_coordinator/loader_coordinator.dart';
import 'package:log/log.dart';

class Mutex {
  static final _log = Log.named('Mutex');
  static final _tags = <String>{};

  final _rwMutex = ReadWriteMutex();

  bool get isLocked => _rwMutex.isLocked;
  Future acquire() => _rwMutex.acquireWrite();
  void release() => _rwMutex.release();

  static Future<Duration> awaitPostframe() async {
    final completer = Completer<Duration>();
    WidgetsBinding.instance.addPostFrameCallback(completer.complete);
    return completer.future;
  }

  Future protectTillSuccess(
    Function criticalSection, {
    int retries = 5000,
    String tag,
    ValueChanged<bool> onEnd,
    bool showLoader = false,
  }) =>
      protect(() async {
        int attempt = 0;
        bool success = false;
        while (!success && attempt < retries) {
          attempt += 1;
          if (attempt > 1) _log.w('Retrying ${criticalSection.hashCode} for $attempt. time already');
          try {
            await criticalSection();
            success = true;
          } catch (e) {
            _log.e(e);
            await Mutex.awaitPostframe();
          }
        }

        onEnd?.call(success);
      }, tag: tag, showLoader: showLoader);

  /// If `tag` is used, make sure the callback is idempotent.
  Future protect(
    Function criticalSection, {
    String tag,
    bool showLoader = false,
  }) async {
    if (tag != null && _tags.contains(tag)) {
      if (_tags.contains(tag)) {
        _log.wtf('Dropped a redundant call on $tag');
        return; // Redundant.
      }
      _tags.add(tag);
    }
    final loader = showLoader ? LoaderCoordinator.instance.touch() : null;
    await acquire();
    try {
      await criticalSection();
    } finally {
      if (tag != null) _tags.remove(tag);
      loader?.dispose();
      release();
    }
  }
}

class _ReadWriteMutexRequest {
  _ReadWriteMutexRequest({this.isRead});

  /// Indicates if this is a read or write lock.
  final bool isRead; // true = read lock requested; false = write lock requested.
  final Completer<void> completer = Completer<void>();
}

class ReadWriteMutex {
  final _waiting = <_ReadWriteMutexRequest>[];

  /// -1 = write lock, +ve = number of read locks; 0 = no lock.
  int _state = 0;

  /// Indicates if a lock (read or write) has been acquired and not released.
  bool get isLocked => _state != 0;

  /// Indicates if a write lock has been acquired and not released.
  bool get isWriteLocked => _state == -1;

  /// Indicates if one or more read locks has been acquired and not released.
  bool get isReadLocked => 0 < _state;

  Future acquireRead() => _acquire(true);
  Future acquireWrite() => _acquire(false);

  /// Release a lock that has been acquired.
  void release() {
    if (_state == -1) {
      // Write lock released
      _state = 0;
    } else if (0 < _state) {
      // Read lock released
      _state--;
    } else if (_state == 0) {
      throw StateError('no lock to release');
    } else {
      assert(false);
    }

    // Let all jobs that can now acquire a lock do so.
    while (_waiting.isNotEmpty) {
      final nextJob = _waiting.first;
      if (_jobAcquired(nextJob)) {
        _waiting.removeAt(0);
      } else {
        break; // no more can be acquired
      }
    }
  }

  Future<void> protectRead(Function criticalSection) async {
    await acquireRead();
    try {
      await criticalSection();
    } finally {
      release();
    }
  }

  Future<void> protectWrite(Function criticalSection) async {
    await acquireWrite();
    try {
      await criticalSection();
    } finally {
      release();
    }
  }

  Future _acquire(bool isRead) {
    final newJob = _ReadWriteMutexRequest(isRead: isRead);
    if (!_jobAcquired(newJob)) {
      _waiting.add(newJob);
    }
    return newJob.completer.future;
  }

  /// Determine if the [job] can now acquire the lock.
  ///
  /// If it can acquire the lock, the job's completer is completed, the
  /// state updated, and true is returned. If not, false is returned.
  bool _jobAcquired(_ReadWriteMutexRequest job) {
    assert(-1 <= _state);
    if (_state == 0 || (0 < _state && job.isRead)) {
      // Can acquire
      _state = (job.isRead) ? (_state + 1) : -1;
      job.completer.complete();
      return true;
    } else {
      return false;
    }
  }
}
