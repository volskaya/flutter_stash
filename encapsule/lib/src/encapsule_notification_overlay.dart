import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:encapsule/src/encapsule_notification.dart';
import 'package:encapsule/src/encapsule_notification_overlay_scrim.dart';
import 'package:encapsule/src/encapsule_store.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

/// [EncapsuleNotificationOverlay] provides [EncapsuleNotificationOverlayController].
///
/// This widget is intended to be nested within [MaterialApp.builder].
class EncapsuleNotificationOverlay extends StatefulWidget {
  /// Creates [EncapsuleNotificationOverlay].
  const EncapsuleNotificationOverlay({
    Key? key,
    this.body,
    this.children = const <Widget>[],
    this.onEnd,
    this.insetNotifications = true,
  }) : super(key: key);

  /// Body widget, preferably child of [MaterialApp.builder].
  final Widget? body;

  /// Children items to build in the overlay stack, above the [body] and below the notifications.
  final Iterable<Widget> children;

  /// Called when the notification item transition ends.
  final VoidCallback? onEnd;

  /// Whether to use [EncapsuleScaffoldState.bottomInset] on the notification items.
  final bool insetNotifications;

  @override
  EncapsuleNotificationOverlayController createState() => EncapsuleNotificationOverlayController();
}

/// Provider of [EncapsuleNotificationOverlayController].
class EncapsuleNotificationOverlayController extends State<EncapsuleNotificationOverlay> {
  bool _handleBackButton(bool stopDefaultButtonEvent, RouteInfo _) {
    if (stopDefaultButtonEvent) return true;
    if (EncapsuleStore.instance.importantNotifications.isNotEmpty) {
      EncapsuleStore.instance.importantNotifications.removeLast().dismiss();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    BackButtonInterceptor.add(_handleBackButton);
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
          if (widget.body != null) widget.body!,
          // Switcher for unimportant notifications.
          Observer(
            builder: (_, __) {
              final item = EncapsuleStore.instance.notification;
              return FancySwitcher(
                alignment: Alignment.bottomCenter,
                onEnd: widget.onEnd,
                inherit: true,
                paintInheritedAnimations: true,
                wrapInheritBoundary: true,
                wrapChildrenInRepaintBoundary: false,
                child: item?.important == false
                    ? FancySwitcherTag(
                        tag: item,
                        child: _NotificationItem(
                          item: item!,
                          duration: item.timeout,
                          useInset: widget.insetNotifications,
                          builder: (_, animation) => Provider<EncapsuleNotificationProps>.value(
                            child: item.builder(context, item.dismiss, animation),
                            value: EncapsuleNotificationProps(
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
            builder: (_, __) => EncapsuleNotificationOverlayScrim(
              toggled: EncapsuleStore.instance.importantNotifications.isNotEmpty,
              onDismissed: () => (EncapsuleStore.instance.importantNotifications.isNotEmpty
                      ? EncapsuleStore.instance.importantNotifications.last
                      : null)
                  ?.dismiss(),
            ),
          ),
          // Notification item switcher.
          Observer(
            builder: (_, __) {
              final item = EncapsuleStore.instance.notification;
              return FancySwitcher(
                alignment: Alignment.bottomCenter,
                onEnd: widget.onEnd,
                inherit: true,
                paintInheritedAnimations: true,
                wrapInheritBoundary: true,
                wrapChildrenInRepaintBoundary: false,
                child: item?.important == true
                    ? FancySwitcherTag(
                        tag: item,
                        child: _NotificationItem(
                          item: item!,
                          duration: item.timeout,
                          useInset: false,
                          builder: (_, animation) => Provider<EncapsuleNotificationProps>.value(
                            child: item.builder(context, item.dismiss, animation),
                            value: EncapsuleNotificationProps(
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
    Key? key,
    required this.builder,
    required this.item,
    this.useInset = true,
    this.duration,
  }) : super(key: key, name: 'notification_item');

  final Widget Function(BuildContext context, Animation<double>? animation) builder;
  final Duration? duration;
  final EncapsuleNotification item;
  final bool useInset;

  @override
  __NotificationItemState createState() => __NotificationItemState();
}

class __NotificationItemState extends State<_NotificationItem> with SingleTickerProviderStateMixin<_NotificationItem> {
  AnimationController? _controller;

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
            ? EdgeInsets.only(bottom: EncapsuleStore.instance.capsule?.bottomInset ?? 0.0)
            : EdgeInsets.zero);

    // Provide the child with correctly insetted padding.
    return IgnorePointer(
      ignoring: widget.item != EncapsuleStore.instance.notification,
      child: MediaQuery(
        data: mediaQuery.copyWith(padding: padding),
        child: notification,
      ),
    );
  }
}
