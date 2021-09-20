import 'package:encapsule/src/encapsule_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'encapsule.freezed.dart';

/// Scaffold wrap of [EncapsuleScaffold].
typedef EncapsuleScaffoldCustomBuilder = Widget Function(BuildContext context, Scaffold scaffold);

@freezed
class EncapsuleElementValue with _$EncapsuleElementValue {
  const factory EncapsuleElementValue({
    required double bottomInset,
  }) = _EncapsuleElementValue;
}

/// Route aware capsule for [Scaffold] which exposes convenience methods for
/// easier deep links and reactions to created scaffolds troughout the app.
class Encapsule extends ProxyWidget {
  /// Creates [EncapsuleScaffold].
  const Encapsule({
    Key? key,
    required Widget child,
    this.bottomInset = 0,
  }) : super(key: key, child: child);

  /// The height of the navigation bar. This will inset encapsulated notifications, when the
  /// scaffold is in foreground.
  final double bottomInset;

  @override
  Element createElement() => EncapsuleElement(this);
}

/// The [EncapsuleElement] that's pushed to [EncapsuleStore] when the element is mounted / unmounted.
class EncapsuleElement extends ProxyElement {
  /// Creates [EncapsuleElement].
  EncapsuleElement(Encapsule widget) : super(widget);

  @override
  Encapsule get widget => super.widget as Encapsule;

  late EncapsuleElementValue _value;

  bool _mounted = false;
  bool _capsuleWasUpdated = false;

  void _detatchCapsule() {
    if (_capsuleWasUpdated) {
      final removed = EncapsuleStore.instance.capsules.remove(_value);
      if (removed) _capsuleWasUpdated = false;
    }
  }

  @override
  void notifyClients(ProxyWidget oldWidget) {
    assert(oldWidget is Encapsule);
    assert((oldWidget as Encapsule).bottomInset == widget.bottomInset);
  }

  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _mounted = true;
    _value = EncapsuleElementValue(bottomInset: widget.bottomInset);

    ModalRoute.of(this); // Register dependency.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_mounted) _capsuleWasUpdated = EncapsuleStore.instance.capsules.add(_value);
    });
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
    _mounted = false;
    WidgetsBinding.instance!.addPostFrameCallback((_) => _detatchCapsule());
    super.unmount();
  }
}
