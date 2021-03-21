import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:log/log.dart';

part 'storage_upload.freezed.dart';

@freezed
class StorageUploadObject with _$StorageUploadObject {
  const factory StorageUploadObject({
    required File file,
    required String path,
    SettableMetadata? metadata,
  }) = _StorageUploadObject;
}

@freezed
class StorageUploadEvent with _$StorageUploadEvent {
  factory StorageUploadEvent({
    required StorageUploadObject object,
    required int number,
    required int totalBytes,
    required int bytesTransferred,
  }) = _StorageUploadEvent;

  StorageUploadEvent._();

  late final double progress = bytesTransferred / totalBytes;
  late final double megabytesTotal = totalBytes / math.pow(10, 6);
  late final double megabytesTransferred = bytesTransferred / math.pow(10, 6);
}

/// Firebase storage upload task that also implements a [ChangeNotifier] to allow
/// animating its progress.
class StorageUpload extends ChangeNotifier {
  StorageUpload.upload(
    this.objects, {
    this.onComplete,
  }) {
    totalFiles = objects.length;
    currentlyUploading = objects.first;
    _beginUpload();
  }

  static final _log = Log.named('StorageUpload');

  final Iterable<StorageUploadObject> objects;
  final ValueChanged<bool>? onComplete; // Passes true, if upload was successful.
  final _completer = Completer<void>();
  late final int totalFiles;

  Future<void> get future => _completer.future;
  late StorageUploadObject currentlyUploading;
  StorageUploadEvent? latestEvent;
  int filesUploaded = 0;

  void _handleComplete([Object? error, StackTrace? trace]) {
    if (error == null) {
      _completer.complete();
    } else {
      _completer.completeError(error, trace);
    }
    onComplete?.call(error == null);
  }

  void _handleTaskEvent(TaskSnapshot snapshot, StorageUploadObject object) {
    if (currentlyUploading != object) return; // Late event?
    switch (snapshot.state) {
      case TaskState.running:
      case TaskState.success:
        if (snapshot.state == TaskState.success && filesUploaded + 1 < totalFiles) {
          filesUploaded += 1;
        }
        latestEvent = StorageUploadEvent(
          object: currentlyUploading,
          totalBytes: snapshot.totalBytes,
          bytesTransferred: snapshot.bytesTransferred,
          number: filesUploaded + 1,
        );
        break;
      case TaskState.paused:
      case TaskState.canceled:
      case TaskState.error:
        break;
    }
    notifyListeners();
  }

  Future _beginUpload() async {
    assert(objects.isNotEmpty);

    try {
      for (final object in objects) {
        currentlyUploading = object;
        final reference = FirebaseStorage.instance.ref().child(object.path);
        final task = reference.putFile(object.file, object.metadata);
        task.snapshotEvents.listen((event) => _handleTaskEvent(event, object));

        try {
          await task;
        } catch (e, t) {
          _handleComplete(e, t);
          return; // Return early.
        }
      }

      _handleComplete();
    } catch (e, t) {
      _handleComplete(e, t);
      _log.e('Storage upload failed', e, t);
    }
  }
}
