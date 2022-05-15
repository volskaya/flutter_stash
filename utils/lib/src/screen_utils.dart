import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

class ScreenUtil extends ChangeNotifier with WidgetsBindingObserver {
  ScreenUtil._({
    required this.designSize,
    required this.minTextAdapt,
  }) {
    _updateMetrics();
    WidgetsBinding.instance.addObserver(this);
  }

  static late ScreenUtil _instance;
  static ScreenUtil get instance => _instance;

  final Size designSize;
  final bool minTextAdapt;

  late Size _size;
  Size get size => _size;

  static void init({
    required Size designSize,
    bool splitScreenMode = false,
    bool minTextAdapt = false,
  }) {
    _instance = ScreenUtil._(
      designSize: designSize,
      minTextAdapt: minTextAdapt,
    );
  }

  Orientation get orientation => size.width > size.height ? Orientation.landscape : Orientation.portrait;

  double get textScaleFactor => window.textScaleFactor;
  double get pixelRatio => window.devicePixelRatio;

  double get screenWidth => size.width;
  double get screenHeight => size.height;
  double get statusBarHeight => window.padding.top;
  double get bottomBarHeight => window.padding.bottom;

  double get scaleWidth => screenWidth / designSize.width;
  double get scaleHeight => screenHeight / designSize.height;
  double get scaleText => minTextAdapt ? min(scaleWidth, scaleHeight) : scaleWidth;

  double setWidth(num width) => width * scaleWidth;
  double setHeight(num height) => height * scaleHeight;

  double radius(num r) => r * min(scaleWidth, scaleHeight);
  double setSp(num fontSize) => fontSize * scaleText;

  void _updateMetrics() {
    _size = window.physicalSize / window.devicePixelRatio;
  }

  @override
  void didChangeMetrics() {
    _updateMetrics();
    notifyListeners();
    super.didChangeMetrics();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

extension SizeExtension on num {
  double get w => ScreenUtil.instance.setWidth(this);
  double get h => ScreenUtil.instance.setHeight(this);
  double get r => ScreenUtil.instance.radius(this);
  double get sw => ScreenUtil.instance.screenWidth * this;
  double get sh => ScreenUtil.instance.screenHeight * this;
  double get sp => ScreenUtil.instance.setSp(this);
  double get sm => min(toDouble(), sp);
}
