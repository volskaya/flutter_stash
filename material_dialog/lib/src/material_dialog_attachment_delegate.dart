import 'package:flutter/widgets.dart';
import 'package:refresh_storage/refresh_storage.dart';

mixin MaterialDialogAttachmentDelegate {
  RefreshStorageState get storage;
  Widget? get widget;
}
