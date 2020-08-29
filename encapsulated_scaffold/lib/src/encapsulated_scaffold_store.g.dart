// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encapsulated_scaffold_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EncapsulatedScaffoldStore<T> on _EncapsulatedScaffoldStore<T>, Store {
  Computed<EncapsulatedScaffoldState<T>> _$capsuleComputed;

  @override
  EncapsulatedScaffoldState<T> get capsule => (_$capsuleComputed ??=
          Computed<EncapsulatedScaffoldState<T>>(() => super.capsule,
              name: '_EncapsulatedScaffoldStore.capsule'))
      .value;

  final _$capsulesAtom = Atom(name: '_EncapsulatedScaffoldStore.capsules');

  @override
  ObservableSet<EncapsulatedScaffoldState<T>> get capsules {
    _$capsulesAtom.reportRead();
    return super.capsules;
  }

  @override
  set capsules(ObservableSet<EncapsulatedScaffoldState<T>> value) {
    _$capsulesAtom.reportWrite(value, super.capsules, () {
      super.capsules = value;
    });
  }

  @override
  String toString() {
    return '''
capsules: ${capsules},
capsule: ${capsule}
    ''';
  }
}
