import 'package:flutter/widgets.dart';
import 'package:refresh_storage/refresh_storage.dart';

mixin MaterialDialogAttachmentDelegate {
  RefreshStoragePod get storage;
  Widget? get widget;
}
