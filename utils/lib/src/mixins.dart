import 'package:cloud_firestore/cloud_firestore.dart';

mixin PictureInPictureObserver {
  bool get isInPictureInPictureMode;
}

mixin TitledModel {
  String get id;
  String get title;
}

mixin UserModel {
  String get id;
  String get title;
  Timestamp get banTime;
}
