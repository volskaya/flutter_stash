import 'package:flutter/widgets.dart';

mixin InitialDependencies<T extends StatefulWidget> on State<T> {
  bool _hasCalled = false;

  void initDependencies();

  @override
  void didChangeDependencies() {
    if (!_hasCalled) {
      _hasCalled = true;
      initDependencies();
    }

    super.didChangeDependencies();
  }
}
