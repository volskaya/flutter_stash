library future_card_button;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_coordinator/loader_coordinator.dart';

/// When the [callback] is null, the button is locked/loading.
typedef FutureButtonChildBuilder = Widget Function(BuildContext context, VoidCallback? callback);

/// Builder that passes locking mechanism of [FutureCardButton].
class FutureButtonBuilder extends StatefulWidget {
  /// Creates [FutureButtonBuilder].
  const FutureButtonBuilder({
    Key? key,
    required this.builder,
    required this.onPressed,
    this.question,
    this.family,
  }) : super(key: key);

  /// Child builder callback.
  final FutureButtonChildBuilder builder;

  /// Future event, when the button is pressed.
  final Future Function()? onPressed;

  /// A question callback, like a modal that returns true, to call before the [onPressed].
  ///
  /// While this callback is awaited, the [FutureButtonBuilder] will not trigger [LoaderCoordinator].
  final Future<bool> Function()? question;

  /// If `family` is defined, the buttons will share the same notifiers
  /// and lock/unlock at the same time
  final String? family;

  /// All the currently alive cached notifiers used by [FutureButtonBuilder]s.
  static final _notifiers = <String, MapEntry<int, ValueNotifier<bool>>>{};

  /// Returns true when the `family` is locked - `onPress` future in progress.
  static bool isFamilyLocked(String family) =>
      _notifiers.containsKey(family) && _notifiers[family]?.value.value == true;

  /// Allows you to invoke futures on behalf of a family. If a widget is using this family,
  /// it will react to this call accordingly.
  static Future callOnBehalfOf(String family, FutureOr Function() callback) async {
    final notifier = _getFamilyNotifier(family);

    // Don't call if the notifier is locked.
    try {
      if (!notifier.value) {
        final loader = LoaderCoordinator.instance.touch(instant: true);
        notifier.value = true;
        try {
          await callback();
        } finally {
          loader.dispose();
          notifier.value = false;
        }
      }
    } finally {
      _disposeFamilyNotifier(family);
    }
  }

  static ValueNotifier<bool> _getFamilyNotifier(String family) {
    FutureButtonBuilder._notifiers[family] ??= MapEntry(0, ValueNotifier<bool>(false));
    FutureButtonBuilder._notifiers[family] = MapEntry(
      FutureButtonBuilder._notifiers[family]!.key + 1, // Increment counter.
      FutureButtonBuilder._notifiers[family]!.value, // Reuse the cached value.
    );

    return FutureButtonBuilder._notifiers[family]!.value;
  }

  static void _disposeFamilyNotifier(String family) {
    assert(FutureButtonBuilder._notifiers.containsKey(family));
    assert(FutureButtonBuilder._notifiers[family]!.key > 0); // Disposed too many times.

    final currentCount = FutureButtonBuilder._notifiers[family]?.key ?? 0;
    if (currentCount <= 1 && FutureButtonBuilder._notifiers.containsKey(family)) {
      // Time to dispose the notifier.
      final entry = FutureButtonBuilder._notifiers.remove(family);
      entry?.value.dispose();
    } else if (currentCount > 1) {
      FutureButtonBuilder._notifiers[family] = MapEntry(
        currentCount - 1,
        FutureButtonBuilder._notifiers[family]!.value,
      );
    }
  }

  @override
  FutureButtonBuilderState createState() => FutureButtonBuilderState();
}

/// State of [FutureButtonBuilder] that exposes [FutureBuilderState.press].
class FutureButtonBuilderState extends State<FutureButtonBuilder> {
  late ValueNotifier<bool> _notifier;

  Future _handleOnPressed() async {
    if (_notifier.value) return; // Redundant, the button should be locked.
    _notifier.value = true;

    // If a question was defined, handle it first.
    if (widget.question != null) {
      try {
        if (await widget.question!() != true) {
          _notifier.value = false;
          return;
        }
      } catch (_) {
        _notifier.value = false;
        rethrow;
      }
    }

    // Trigger the loader and handle the regular callback.
    final loader = LoaderCoordinator.instance.touch(instant: true);
    try {
      await widget.onPressed?.call();
    } finally {
      loader.dispose();
      if (mounted) _notifier.value = false;
    }
  }

  /// Trigger buttons press event.
  Future press() {
    assert((() {
      if (widget.family != null) {
        print(
          'FutureButtonBuilder was pressed trough the State, while having a family of ${widget.family}.'
          '\nPrefer to use [FutureCardButton.callOnBehalfOf] instead.',
        );
      }
      return true;
    })());

    return _handleOnPressed();
  }

  @override
  void initState() {
    _notifier =
        widget.family != null ? FutureButtonBuilder._getFamilyNotifier(widget.family!) : ValueNotifier<bool>(false);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FutureButtonBuilder oldWidget) {
    assert(oldWidget.family == widget.family);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (widget.family != null) {
      FutureButtonBuilder._disposeFamilyNotifier(widget.family!);
    } else {
      _notifier.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: _notifier,
        builder: (context, locked, __) => widget.builder(
          context,
          !locked && widget.onPressed != null ? _handleOnPressed : null,
        ),
      );
}
