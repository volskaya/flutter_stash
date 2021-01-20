import 'package:encapsulated_scaffold/src/encapsulated_notification_item.dart';
import 'package:encapsulated_scaffold/src/encapsulated_notification_overlay_scrim.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:provider/provider.dart';

/// [EncapsulatedNotificationOverlay] provides [EncapsulatedNotificationOverlayController].
///
/// This widget is intended to be nested within [MaterialApp.builder].
class EncapsulatedNotificationOverlay extends StatefulWidget {
  /// Creates [EncapsulatedNotificationOverlay].
  const EncapsulatedNotificationOverlay({
    Key key,
    this.body,
    this.children = const <Widget>[],
    this.onEnd,
    this.insetNotifications = true,
  }) : super(key: key);

  /// Body widget, preferably child of [MaterialApp.builder].
  final Widget body;

  /// Children items to build in the overlay stack, above the [body] and below the notifications.
  final Iterable<Widget> children;

  /// Called when the notification item transition ends.
  final VoidCallback onEnd;

  /// Whether to use [EncapsulatedScaffoldState.bottomInset] on the notification items.
  final bool insetNotifications;

  @override
  EncapsulatedNotificationOverlayController createState() => EncapsulatedNotificationOverlayController();
}

/// Provider of [EncapsulatedNotificationOverlayController].
class EncapsulatedNotificationOverlayController extends State<EncapsulatedNotificationOverlay> {
  EncapsulatedScaffoldStore _store;

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
    BackButtonInterceptor.add(_handleBackButton);
    _store = EncapsulatedScaffoldStore.of(context);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_handleBackButton);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: <Widget>[
          if (widget.body != null) widget.body,
          // Switcher for unimportant notifications.
          Observer(
            builder: (_, __) {
              final item = _store.notification;
              return FancySwitcher(
                alignment: Alignment.bottomCenter,
                onEnd: widget.onEnd,
                child: item?.important == false
                    ? FancySwitcherTag(
                        tag: item,
                        child: _NotificationItem(
                          store: _store,
                          item: item,
                          duration: item.timeout,
                          useInset: widget.insetNotifications,
                          builder: (_, animation) => Provider<EncapsulatedNotificationProps>.value(
                            child: item.builder(context, item.dismiss, animation),
                            value: EncapsulatedNotificationProps(
                              dismiss: item.dismiss,
                              dismissAnimation: animation,
                              reference: item,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(key: ValueKey('idle')),
              );
            },
          ),
          ...widget.children,
          // Important notification scrim.
          Observer(
            builder: (_, __) => EncapsulatedNotificationOverlayScrim(
              toggled: _store.importantNotifications.isNotEmpty,
              onDismissed: () =>
                  (_store.importantNotifications.isNotEmpty ? _store.importantNotifications.last : null)?.dismiss(),
            ),
          ),
          // Notification item switcher.
          Observer(
            builder: (_, __) {
              final item = _store.notification;
              return FancySwitcher(
                alignment: Alignment.bottomCenter,
                onEnd: widget.onEnd,
                child: item?.important == true
                    ? FancySwitcherTag(
                        tag: item,
                        child: _NotificationItem(
                          store: _store,
                          item: item,
                          duration: item.timeout,
                          useInset: false,
                          builder: (_, animation) => Provider<EncapsulatedNotificationProps>.value(
                            child: item.builder(context, item.dismiss, animation),
                            value: EncapsulatedNotificationProps(
                              dismiss: item.dismiss,
                              dismissAnimation: animation,
                              reference: item,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(key: ValueKey('idle')),
              );
            },
          ),
        ],
      );
}

class _NotificationItem extends StatefulObserverWidget {
  const _NotificationItem({
    Key key,
    @required this.builder,
    @required this.duration,
    @required this.store,
    @required this.item,
    this.useInset = true,
  }) : super(key: key, name: 'notification_item');

  final Widget Function(BuildContext context, Animation<double> animation) builder;
  final Duration duration;
  final EncapsulatedScaffoldStore store;
  final EncapsulatedNotificationItem item;
  final bool useInset;

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
            animationBehavior: AnimationBehavior.preserve,
          )..forward())
        : null;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notification = widget.builder(context, _controller?.view);
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.padding +
        mediaQuery.viewInsets +
        (!widget.item.important && widget.useInset
            ? EdgeInsets.only(bottom: widget.store.capsule?.bottomInset ?? 0)
            : EdgeInsets.zero);

    // Provide the child with correctly insetted padding.
    return IgnorePointer(
      ignoring: widget.item != widget.store.notification,
      child: MediaQuery(
        data: mediaQuery.copyWith(padding: padding),
        child: notification,
      ),
    );
  }
}
