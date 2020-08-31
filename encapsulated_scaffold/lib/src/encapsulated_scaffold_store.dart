import 'package:encapsulated_scaffold/src/encapsulated_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

part 'encapsulated_scaffold_store.g.dart';

/// Store of [EncapsulatedScaffold].
class EncapsulatedScaffoldStore<T extends EncapsulatedScaffoldDataBase> extends _EncapsulatedScaffoldStore<T>
    with _$EncapsulatedScaffoldStore<T> {
  /// Creates [EncapsulatedScaffoldStore].
  ///
  /// Pass `navigator` for convenience.
  EncapsulatedScaffoldStore({@required GlobalKey<NavigatorState> navigator}) : super(navigator);

  /// Get the nearest [EncapsulatedScaffoldStore].
  static EncapsulatedScaffoldStore<D> of<D extends EncapsulatedScaffoldDataBase>(BuildContext context) =>
      Provider.of<EncapsulatedScaffoldStore>(context, listen: false) as EncapsulatedScaffoldStore<D>;
}

abstract class _EncapsulatedScaffoldStore<T extends EncapsulatedScaffoldDataBase> with Store {
  _EncapsulatedScaffoldStore(this.navigator);

  final GlobalKey<NavigatorState> navigator;

  /// Capsules are added and popped as the navigator routes. They're useful
  /// for accessing the top most scaffolds, for example when a new notification
  /// shows a toast, in the current view
  ///
  /// NOTE: .linkedHashSetFrom, to preserve order of insertion
  @observable
  ObservableSet<EncapsulatedScaffoldState<EncapsulatedScaffoldDataBase>> capsules =
      ObservableSet<EncapsulatedScaffoldState<EncapsulatedScaffoldDataBase>>.linkedHashSetFrom([]);

  @computed
  EncapsulatedScaffoldState<EncapsulatedScaffoldDataBase> get capsule => capsules.isNotEmpty ? capsules.last : null;
}
