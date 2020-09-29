import 'package:encapsulated_scaffold/src/encapsulated_notification_overlay_scrim.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

/// [EncapsulatedNotificationOverlay] provides [EncapsulatedNotificationOverlayController].
///
/// This widget is intended to be nested within [MaterialApp.builder].
class EncapsulatedNotificationOverlay extends StatefulWidget {
  /// Creates [EncapsulatedNotificationOverlay].
  const EncapsulatedNotificationOverlay({
    Key key,
    this.body,
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
  final _paddingNotifier = ValueNotifier<EdgeInsets>(EdgeInsets.zero);

  EncapsulatedScaffoldStore _store;
  ReactionDisposer _capsuleReactionDisposer;

  bool _handleBackButton(bool stopDefaultButtonEvent, RouteInfo _) {
    if (stopDefaultButtonEvent) return true;
    if (_store.importantNotifications.isNotEmpty) {
      _store.importantNotifications.removeLast().dismiss();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(_handleBackButton);
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
    BackButtonInterceptor.remove(_handleBackButton);
    _capsuleReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = AnimatedBuilder(
      animation: _paddingNotifier,
      builder: (context, child) => TweenAnimationBuilder<EdgeInsets>(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        tween: EdgeInsetsTween(end: _paddingNotifier.value + MediaQuery.of(context).viewInsets),
        builder: (_, value, __) => Transform.translate(
          offset: Offset(0, -value.bottom),
          child: child,
        ),
      ),
      child: Observer(
        builder: (_) {
          // Prioritize important notifications
          final item = _store.importantNotifications.isNotEmpty
              ? _store.importantNotifications.last
              : _store.notifications.isNotEmpty ? _store.notifications.last : null;

          return FancySwitcher.vertical(
            alignment: Alignment.bottomCenter,
            child: item != null
                ? _NotificationItem(
                    key: ValueKey(item.tag + item.createTime.millisecondsSinceEpoch.toString()),
                    duration: item.timeout,
                    builder: (context, animation) =>
                        item.builder(context, () => _store.dismissNotification(item), animation),
                  )
                : const SizedBox(key: ValueKey('idle')),
          );
        },
      ),
    );
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        if (widget.body != null) widget.body,
        ...widget.children,
        Observer(
          builder: (_) => EncapsulatedNotificationOverlayScrim(
            toggled: _store.importantNotifications.isNotEmpty,
            child: notifications,
            onDismissed: () =>
                (_store.importantNotifications.isNotEmpty ? _store.importantNotifications.last : null)?.dismiss(),
          ),
        ),
      ],
    );
  }
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
