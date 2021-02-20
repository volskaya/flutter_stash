import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

/// Allows subscribing to multiple observables to keep them alive,
/// even if there are no "real" clients subscribed to them.
class ObservableKeepAliver {
  ObservableKeepAliver(List<VoidCallback> observables)
      : _reactions = observables.map((observable) => autorun((_) => observable())).toList(growable: false);

  final List<ReactionDisposer> _reactions;

  void dispose() {
    for (final disposer in _reactions) disposer.call();
  }
}
