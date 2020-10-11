import 'package:encapsulated_scaffold/src/encapsulated_notification_item.dart';
import 'package:encapsulated_scaffold/src/encapsulated_notification_overlay_scrim.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';
import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:provider/provider.dart';

/// Props provided to descending notifications.
class EncapsulatedNotificationProps {
  /// Creates [EncapsulatedNotificationProps].
  const EncapsulatedNotificationProps(this.dismiss, this.dismissAnimation, this.reference);

  /// Callable to dismiss the notification.
  final VoidCallback dismiss;

  /// Progress animation of the notifications dismiss timeout.
  /// Is null when the notification is built without a timeout.
  final Animation<double> dismissAnimation;

  /// Reference to the [EncapsulatedNotificatoinItem] these props belong to.
  final EncapsulatedNotificationItem reference;

  /// Get [EncapsulatedNotificationProps] provided trough the [BuildContext].
  static EncapsulatedNotificationProps of(BuildContext context) {
    try {
      return Provider.of<EncapsulatedNotificationProps>(context, listen: false);
    } catch (e) {
      print('No EncapsulatedNotificationProps found in the build context.'
          'Built widget is not a descendant of an EncapsulatedScaffoldOverlay notification?');
      rethrow;
    }
  }
}

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
  final _padding = Observable<EdgeInsets>(EdgeInsets.zero);

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
      _padding.value = onScreenCapsule.bodyMediaQuery?.padding ?? EdgeInsets.zero;
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
    final notifications = Observer(
      name: 'encapsulated_notification_overlay_notifications',
      builder: (_) {
        final showScrim = _store.importantNotifications.isNotEmpty;
        final item = _store.importantNotifications.isNotEmpty // Prioritize important notifications.
            ? _store.importantNotifications.last
            : _store.notifications.isNotEmpty ? _store.notifications.last : null;

        return EncapsulatedNotificationOverlayScrim(
          toggled: showScrim,
          onDismissed: () =>
              (_store.importantNotifications.isNotEmpty ? _store.importantNotifications.last : null)?.dismiss(),
          child: FancySwitcher(
            alignment: Alignment.bottomCenter,
            child: item != null
                ? _NotificationItem(
                    store: _store,
                    important: item.important,
                    padding: _padding,
                    key: ValueKey(item.tag + item.createTime.millisecondsSinceEpoch.toString()),
                    duration: item.timeout,
                    builder: (context, animation) => Provider<EncapsulatedNotificationProps>.value(
                      value: EncapsulatedNotificationProps(item.dismiss, animation, item),
                      child: item.builder(context, item.dismiss, animation),
                    ),
                  )
                : const SizedBox(key: ValueKey('idle')),
          ),
        );
      },
    );

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        if (widget.body != null) widget.body,
        ...widget.children,
        notifications,
      ],
    );
  }
}

class _NotificationItem extends StatefulObserverWidget {
  const _NotificationItem({
    Key key,
    @required this.builder,
    @required this.duration,
    @required this.store,
    this.padding,
    this.important = false,
  }) : super(key: key, name: 'notification_item');

  final Widget Function(BuildContext context, Animation<double> animation) builder;
  final Duration duration;
  final EncapsulatedScaffoldStore store;
  final Observable<EdgeInsets> padding;
  final bool important;

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
  Widget build(BuildContext context) {
    final notification = widget.builder(context, _controller?.view);
    if (widget.important) return notification;

    final padding = (widget.important || widget.padding == null ? EdgeInsets.zero : widget.padding.value) +
        MediaQuery.of(context).viewInsets;

    return TweenAnimationBuilder<EdgeInsets>(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      tween: EdgeInsetsTween(end: padding),
      builder: (_, value, __) => Transform.translate(
        offset: Offset(0, -value.bottom),
        child: notification,
      ),
    );
  }
}
