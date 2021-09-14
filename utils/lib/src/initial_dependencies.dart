import 'package:flutter/widgets.dart';

mixin InitialDependencies<T extends StatefulWidget> on State<T> {
  bool _hasCalled = false;
  bool _hasCalledPost = false;

  void initDependencies() {}
  void postInitDependencies() {}

  @override
  void didChangeDependencies() {
    if (!_hasCalled) {
      _hasCalled = true;
      initDependencies();
    }

    super.didChangeDependencies();

    if (!_hasCalledPost) {
      _hasCalledPost = true;
      postInitDependencies();
    }
  }
}
