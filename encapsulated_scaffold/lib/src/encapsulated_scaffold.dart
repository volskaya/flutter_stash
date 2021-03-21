import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';

/// Scaffold wrap of [EncapsulatedScaffold].
typedef EncapsulatedScaffoldCustomBuilder = Widget Function(BuildContext context, Scaffold scaffold);

/// Route aware capsule for [Scaffold] which exposes convenience methods for
/// easier deep links and reactions to created scaffolds troughout the app.
class EncapsulatedCapsule extends ProxyWidget {
  /// Creates [EncapsulatedScaffold].
  const EncapsulatedCapsule({
    Key? key,
    required Widget child,
    this.bottomInset = 0,
  }) : super(key: key, child: child);

  /// The height of the navigation bar. This will inset encapsulated notifications, when the
  /// scaffold is in foreground.
  final double bottomInset;

  @override
  Element createElement() => EncapsulatedCapsuleElement(this);
}

/// The [EncapsulatedCapsuleElement] that's pushed to [EncapsulatedScaffoldStore] when the
/// element is mounted / unmounted.
class EncapsulatedCapsuleElement extends ProxyElement {
  /// Creates [EncapsulatedCapsuleElement].
  EncapsulatedCapsuleElement(EncapsulatedCapsule widget) : super(widget);

  @override
  EncapsulatedCapsule get widget => super.widget as EncapsulatedCapsule;
  double get bottomInset => widget.bottomInset;

  @override
  void notifyClients(ProxyWidget oldWidget) {}

  late final EncapsulatedScaffoldStore _store;
  bool _capsuleWasUpdated = false;

  void _detatchCapsule() {
    if (_capsuleWasUpdated) {
      final removed = _store.capsules.remove(this);
      if (removed) _capsuleWasUpdated = false;
    }
  }

  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _store = EncapsulatedScaffoldStore.of(this);
    ModalRoute.of(this); // Register dependency.
    WidgetsBinding.instance!.addPostFrameCallback((_) => _capsuleWasUpdated = _store.capsules.add(this));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_capsuleWasUpdated && ModalRoute.of(this)?.isActive != true) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _detatchCapsule());
    }
  }

  @override
  void unmount() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _detatchCapsule());
    super.unmount();
  }
}
