// ignore_for_file: public_member_api_docs

import 'dart:collection';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refresh_storage/src/refresh_counter_pod.dart';
import 'package:refresh_storage/src/refresh_storage_entry.dart';
import 'package:refresh_storage/src/refresh_storage_item.dart';
import 'package:riverpod/riverpod.dart';

part 'refresh_storage_pod.freezed.dart';

@freezed
class RefreshStorageValueItem<T extends RefreshStorageItem> with _$RefreshStorageValueItem<T> {
  const factory RefreshStorageValueItem({
    required T item,
    @Default(-1) int refresh,
  }) = _RefreshStorageValueItem;
}

@freezed
class RefreshStorageValue with _$RefreshStorageValue {
  const factory RefreshStorageValue({
    required IMap<int, RefreshStorageValueItem> items,
  }) = _RefreshStorageValue;

  const RefreshStorageValue._();

  /// Returns true if the storage contains this identifier.
  bool contains(String identifier) => items.containsKey(identifier.hashCode);
  T? getItem<T extends RefreshStorageItem>(String identifier) => items[identifier.hashCode]?.item as T?;
}

class RefreshStoragePod {
  RefreshStoragePod(this.ref);

  static final provider = Provider<RefreshStoragePod>(_referenceNotifier, name: 'RefreshStoragePod');

  static RefreshStoragePod _referenceNotifier(ProviderRefBase ref, [dynamic family]) {
    final notifier = RefreshStoragePod(ref);
    ref.onDispose(notifier.dispose);
    return notifier;
  }

  final ProviderRefBase ref;
  final _state = HashMap<int, RefreshStorageValueItem>();

  /// Write and get a value from the storage. Data are built with `builder`
  /// and are built only once.
  ///
  /// The state will call dispose when a new refresh is used with the
  /// same identifier or when the route pops.
  RefreshStorageEntry<T> write<T extends RefreshStorageItem>({
    required String identifier,
    required T Function() builder,
    int? refreshes,
  }) {
    final _refreshes = refreshes ?? ref.read<int>(RefreshCounterPod.provider);

    assert(_refreshes >= 0);
    var entry = _state[identifier.hashCode] as RefreshStorageValueItem<T>?;

    if ((entry?.refresh ?? -1) < _refreshes) {
      // Dispose the previous refresh, post frame.
      if (entry != null) WidgetsBinding.instance!.addPostFrameCallback(entry.item.dispose);

      // Build the new item.
      entry = RefreshStorageValueItem<T>(item: builder(), refresh: _refreshes);
      _state[identifier.hashCode] = entry;
    }

    return RefreshStorageEntry<T>(identifier, entry!.item);
  }

  /// Memoizes a basic item, that does not need to be disposed.
  T memoize<T>(
    String identifier,
    T Function() builder, {
    int? refreshes,
  }) {
    final item = write<BasicRefreshStorageItem<T>>(
      identifier: identifier,
      builder: () => BasicRefreshStorageItem(builder()),
      refreshes: refreshes,
    );

    final value = item.value!.value;
    item.dispose(); // NOTE: [BasicRefreshStorageItem] doesn't really need to be disposed.
    return value;
  }

  /// Returns true if the storage contains this identifier.
  bool contains(String identifier) => _state.containsKey(identifier);
  RefreshStorageValueItem<T>? getItem<T extends RefreshStorageItem>(String identifier) =>
      _state[identifier.hashCode] as RefreshStorageValueItem<T>?;

  /// Update an entry under the identifier.
  void add<T extends RefreshStorageItem>(String identifier, T value, [int? refresh]) {
    if (refresh != null) {
      final previousEntry = _state[identifier.hashCode];

      if (previousEntry != null && previousEntry.refresh < refresh) {
        WidgetsBinding.instance!.addPostFrameCallback(previousEntry.item.dispose);
      }
    }

    _state[identifier.hashCode] = RefreshStorageValueItem<T>(
      item: value,
      refresh: refresh ?? _state[identifier.hashCode]?.refresh ?? 0,
    );
  }

  void destroy(String identifier) {
    _state.remove(identifier.hashCode)?.item.dispose();
  }

  void dispose() {
    for (final value in _state.values) value.item.dispose();
  }
}
