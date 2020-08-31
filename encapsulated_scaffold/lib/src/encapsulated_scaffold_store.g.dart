// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encapsulated_scaffold_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EncapsulatedScaffoldStore<T extends EncapsulatedScaffoldDataBase>
    on _EncapsulatedScaffoldStore<T>, Store {
  Computed<EncapsulatedScaffoldState<EncapsulatedScaffoldDataBase>>
      _$capsuleComputed;

  @override
  EncapsulatedScaffoldState<EncapsulatedScaffoldDataBase> get capsule =>
      (_$capsuleComputed ??=
              Computed<EncapsulatedScaffoldState<EncapsulatedScaffoldDataBase>>(
                  () => super.capsule,
                  name: '_EncapsulatedScaffoldStore.capsule'))
          .value;

  final _$capsulesAtom = Atom(name: '_EncapsulatedScaffoldStore.capsules');

  @override
  ObservableSet<EncapsulatedScaffoldState<EncapsulatedScaffoldDataBase>>
      get capsules {
    _$capsulesAtom.reportRead();
    return super.capsules;
  }

  @override
  set capsules(
      ObservableSet<EncapsulatedScaffoldState<EncapsulatedScaffoldDataBase>>
          value) {
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
