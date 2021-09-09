import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:refresh_storage/src/refresh_counter_pod.dart';
import 'package:refresh_storage/src/refresh_storage_entry.dart';
import 'package:refresh_storage/src/refresh_storage_item.dart';
import 'package:refresh_storage/src/refresh_storage_pod.dart';

class RefreshStorage extends ConsumerWidget {
  const RefreshStorage({
    Key? key,
    required this.child,
    this.dependents = const <Override>[],
  }) : super(key: key);

  /// The child of [RefreshStorage]. All descending widgets will cache their data in the state here.
  final Widget child;

  /// Dependent providers that should be scoped by the nested [ProviderScope].
  final List<Override> dependents;

  static RefreshStoragePod notifierOf(BuildContext context, {bool listen = false}) => of(context, listen: listen);
  static RefreshStoragePod of(BuildContext context, {bool listen = false}) =>
      ProviderScope.containerOf(context, listen: listen).read(RefreshStoragePod.provider);

  /// Creates a [Provider<RefreshStorageState>] that's used by [RefreshStorage].
  @Deprecated('Build the ProviderScope yourself and don\'t forget to override dependents')
  static Widget wrapProvider({
    Key? key,
    required RefreshStoragePod state,
    required Widget child,
  }) =>
      ProviderScope(
        key: key,
        overrides: [RefreshStoragePod.provider.overrideWithValue(state)],
        child: child,
      );

  /// Write and get a value from [PageStorage]. Data are built with `builder`
  /// and are built only once.
  ///
  /// [RefreshStorage] will call dispose when a new refresh is used with the
  /// same identifier or when the route pops.
  static RefreshStorageEntry<T> write<T extends RefreshStorageItem>({
    required BuildContext context,
    required String identifier,
    required T Function() builder,
    int? refreshes,
    RefreshStoragePod? storage,
  }) =>
      (storage ?? RefreshStorage.of(context)).write<T>(
        identifier: identifier,
        builder: builder,
        refreshes: refreshes,
      );

  /// Memoizes a basic item, that does not need to be disposed.
  static T memoize<T>(
    BuildContext context,
    String identifier,
    T Function() builder, {
    int? refreshes,
    RefreshStoragePod? storage,
  }) =>
      (storage ?? RefreshStorage.of(context)).memoize<T>(identifier, builder, refreshes: refreshes);

  /// Returns true if the storage contains this identifier.
  static bool contains(
    BuildContext context,
    String identifier, {
    RefreshStoragePod? storage,
  }) =>
      (storage ?? RefreshStorage.of(context)).contains(identifier);

  /// Manually destroy a [RefreshStorageItem] cached in [RefreshStorageState].
  static void destroy({
    required BuildContext context,
    required String identifier,
    RefreshStoragePod? storage,
  }) =>
      (storage ?? RefreshStorage.of(context)).destroy(identifier);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = RefreshCounterPod.providerFamily(ref.hashCode);

    return ProviderScope(
      child: child,
      overrides: [
        RefreshCounterPod.provider.overrideWithProvider(provider),
        RefreshStoragePod.provider,
        ...dependents,
      ],
    );
  }
}
