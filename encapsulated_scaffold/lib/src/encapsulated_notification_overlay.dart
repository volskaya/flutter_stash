import 'dart:async';

import 'package:encapsulated_scaffold/src/encapsulated_scaffold.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';
import 'package:encapsulated_scaffold/src/encapsulated_notification_item.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

/// [EncapsulatedNotificationOverlay] provides [EncapsulatedNotificationOverlayController].
///
/// This widget is intended to be nested within [MaterialApp.builder].
class EncapsulatedNotificationOverlay extends StatefulWidget {
  /// Creates [EncapsulatedNotificationOverlay].
  const EncapsulatedNotificationOverlay({
    Key key,
    @required this.body,
    @required this.children,
  }) : super(key: key);

  /// Body widget, preferably child of [MaterialApp.builder].
  final Widget body;

  /// Children items to build in the overlay stack, above the [body] and below the notifications.
  final List<Widget> children;

  @override
  EncapsulatedNotificationOverlayController createState() => EncapsulatedNotificationOverlayController();
}

/// Provider of [EncapsulatedNotificationOverlayController].
class EncapsulatedNotificationOverlayController extends State<EncapsulatedNotificationOverlay> {
  /// Look up nearest [EncapsulatedNotificationOverlayController].
  static EncapsulatedNotificationOverlayController of(BuildContext context) =>
      Provider.of<EncapsulatedNotificationOverlayController>(context, listen: false);

  final _items = ObservableList<EncapsulatedNotificationItem>();
  final _paddingNotifier = ValueNotifier<EdgeInsets>(EdgeInsets.zero);

  EncapsulatedScaffoldStore _store;
  ReactionDisposer _capsuleReactionDisposer;

  /// Push an [EncapsulatedNotificationItem] to the overlay.
  void pushItem(EncapsulatedNotificationItem item) {
    _items.add(item);

    if (item.timeout != null) {
      Timer(item.timeout, () {
        if (_items.contains(item)) _items.remove(item);
      });
    }
  }

  void _dismissItem(EncapsulatedNotificationItem item) {
    _items.remove(item);
    item.onDismissed?.call();
  }

  @override
  void initState() {
    super.initState();
    _store = EncapsulatedScaffoldStore.of<EncapsulatedScaffoldDataBase>(context);

    // Reaction to adjust screen padding based on the last
    // encapsulated scaffold
    _capsuleReactionDisposer = autorun((_) {
      final onScreenCapsule = _store.capsule;
      final mediaQuery =
          onScreenCapsule.scaffold?.context != null ? MediaQuery.of(onScreenCapsule.scaffold.context) : null;

      _paddingNotifier.value = mediaQuery?.padding ?? EdgeInsets.zero;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _capsuleReactionDisposer();
    _items.clear();
  }

  @override
  Widget build(BuildContext context) => Provider<EncapsulatedNotificationOverlayController>.value(
        value: this,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            widget.body,
            ...widget.children,
            Observer(
              builder: (_) {
                final item = _items.isNotEmpty ? _items.last : null;
                return FancySwitcher.vertical(
                  alignment: Alignment.bottomCenter,
                  child: item != null
                      ? _NotificationItem(
                          key: ValueKey(item.tag + item.createTime.millisecondsSinceEpoch.toString()),
                          duration: item.timeout,
                          builder: (context, animation) => item.builder(context, () => _dismissItem(item), animation),
                        )
                      : const SizedBox(key: ValueKey('idle')),
                );
              },
            ),
          ],
        ),
      );
}

class _NotificationItem extends StatefulWidget {
  const _NotificationItem({
    Key key,
    @required this.builder,
    @required this.duration,
  }) : super(key: key);

  final Widget Function(BuildContext context, Animation<double> animation) builder;
  final Duration duration;

  @override
  __NotificationItemState createState() => __NotificationItemState();
}

class __NotificationItemState extends State<_NotificationItem> with SingleTickerProviderStateMixin<_NotificationItem> {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.duration != null
        ? (AnimationController(
            vsync: this,
            duration: widget.duration,
          )..forward())
        : null;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _controller?.view);
}
