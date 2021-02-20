import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:log/log.dart';

part 'storage_upload.freezed.dart';

@freezed
abstract class StorageUploadObject with _$StorageUploadObject {
  const factory StorageUploadObject({
    @required File file,
    @required String path,
    StorageMetadata metadata,
  }) = _StorageUploadObject;
}

@freezed
abstract class StorageUploadEvent with _$StorageUploadEvent {
  factory StorageUploadEvent({
    @required StorageUploadObject object,
    @required int number,
    @required int totalBytes,
    @required int bytesTransferred,
  }) = _StorageUploadEvent;

  @late
  double get progress => bytesTransferred / totalBytes;
  @late
  double get megabytesTotal => totalBytes / math.pow(10, 6);
  @late
  double get megabytesTransferred => bytesTransferred / math.pow(10, 6);
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

  final Iterable<StorageUploadObject> objects;
  final ValueChanged<int> onComplete;
  final _completer = Completer<void>();

  static final _log = Log.named('StorageUpload');

  Future<void> get future => _completer?.future;
  int totalFiles = 0;
  int filesUploaded = 0;
  StorageUploadObject currentlyUploading;
  StorageUploadEvent latestEvent;

  void _handleComplete(int error) {
    if (error == null || error == 0) {
      _completer.complete();
    } else {
      _completer.completeError(error);
    }
    onComplete?.call(error);
  }

  void _handleTaskEvent(StorageTaskEvent event, StorageUploadObject object) {
    if (currentlyUploading != object) return; // Late event?
    switch (event.type) {
      case StorageTaskEventType.progress:
      case StorageTaskEventType.success:
        if (event.type == StorageTaskEventType.success && filesUploaded + 1 < totalFiles) {
          filesUploaded += 1;
        }
        latestEvent = StorageUploadEvent(
          object: currentlyUploading,
          totalBytes: event.snapshot.totalByteCount,
          bytesTransferred: event.snapshot.bytesTransferred,
          number: filesUploaded + 1,
        );
        break;
      case StorageTaskEventType.resume:
      case StorageTaskEventType.pause:
      case StorageTaskEventType.failure:
        break; // Do nothing
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
        task.events.listen((event) => _handleTaskEvent(event, object));
        final snapshot = await task.onComplete;

        if (snapshot.error != null) {
          _handleComplete(snapshot.error);
          return; // Upload failed, return early.
        }
      }

      _handleComplete(0);
    } catch (e, t) {
      _handleComplete(1);
      _log.e('Storage upload failed', e, t);
    }
  }
}
