import 'package:encapsulated_scaffold/src/encapsulated_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';
import 'package:provider/provider.dart';

/// [EncapsulatedScaffoldStore] provider used by descending [EncapsulatedScaffolds].
///
/// Place this above [MaterialApp].
class EncapsulatedScaffoldController<T extends EncapsulatedScaffoldDataBase> extends StatefulWidget {
  /// Creates [EncapsulatedScaffoldController].
  const EncapsulatedScaffoldController({
    Key key,
    @required this.child,
    @required this.navigator,
    this.onInit,
    this.onDispose,
  }) : super(key: key);

  /// Child of this widget.
  final Widget child;

  /// Callback when the widget is initialized.
  final ValueChanged<EncapsulatedScaffoldStore> onInit;

  /// Callback when the widget is disposed.
  final ValueChanged<EncapsulatedScaffoldStore> onDispose;

  /// Navigator global key, that's shared with [MaterialApp].
  final GlobalKey<NavigatorState> navigator;

  /// Get the nearest [EncapsulatedScaffoldStore].
  static EncapsulatedScaffoldStore<T> of<T extends EncapsulatedScaffoldDataBase>(BuildContext context) =>
      Provider.of<EncapsulatedScaffoldStore>(context, listen: false) as EncapsulatedScaffoldStore<T>;

  @override
  _EncapsulatedScaffoldControllerState<T> createState() => _EncapsulatedScaffoldControllerState<T>();
}

class _EncapsulatedScaffoldControllerState<T extends EncapsulatedScaffoldDataBase>
    extends State<EncapsulatedScaffoldController<T>> {
  EncapsulatedScaffoldStore<T> _store;

  @override
  void initState() {
    _store = EncapsulatedScaffoldStore<T>(navigator: widget.navigator);
    widget.onInit?.call(_store);
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose?.call(_store);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Provider<EncapsulatedScaffoldStore>.value(
        value: _store,
        child: widget.child,
      );
}
