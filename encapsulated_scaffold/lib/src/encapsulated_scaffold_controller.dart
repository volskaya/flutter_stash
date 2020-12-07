import 'package:encapsulated_scaffold/src/encapsulated_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';
import 'package:provider/provider.dart';

/// [EncapsulatedScaffoldStore] provider used by descending [EncapsulatedScaffolds].
///
/// Place this above [MaterialApp].
class EncapsulatedScaffoldController extends StatefulWidget {
  /// Creates [EncapsulatedScaffoldController].
  const EncapsulatedScaffoldController({
    Key key,
    @required this.child,
    this.onInit,
    this.onDispose,
  }) : super(key: key);

  /// Child of this widget.
  final Widget child;

  /// Callback when the widget is initialized.
  final ValueChanged<EncapsulatedScaffoldStore> onInit;

  /// Callback when the widget is disposed.
  final ValueChanged<EncapsulatedScaffoldStore> onDispose;

  /// Get the nearest [EncapsulatedScaffoldStore].
  static EncapsulatedScaffoldStore of(BuildContext context) =>
      Provider.of<EncapsulatedScaffoldStore>(context, listen: false);

  @override
  _EncapsulatedScaffoldControllerState createState() => _EncapsulatedScaffoldControllerState();
}

class _EncapsulatedScaffoldControllerState extends State<EncapsulatedScaffoldController> {
  EncapsulatedScaffoldStore _store;

  @override
  void initState() {
    _store = EncapsulatedScaffoldStore();
    widget.onInit?.call(_store);
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose?.call(_store);
    _store?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Provider<EncapsulatedScaffoldStore>.value(
        value: _store,
        child: widget.child,
      );
}
