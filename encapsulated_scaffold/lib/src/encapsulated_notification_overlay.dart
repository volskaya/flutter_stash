import 'dart:async';

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
    @required this.child,
  }) : super(key: key);

  /// Child widget, preferably child of [MaterialApp.builder].
  final Widget child;

  @override
  EncapsulatedNotificationOverlayController createState() =>
      EncapsulatedNotificationOverlayController();
}

/// Provider of [EncapsulatedNotificationOverlayController].
class EncapsulatedNotificationOverlayController
    extends State<EncapsulatedNotificationOverlay> {
  /// Look up nearest [EncapsulatedNotificationOverlayController].
  static EncapsulatedNotificationOverlayController of(BuildContext context) =>
      Provider.of<EncapsulatedNotificationOverlayController>(context,
          listen: false);

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

  Widget _buildOverlayItem(
    BuildContext context,
    EncapsulatedNotificationItem item,
  ) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    final backgroundColor =
        item.backgroundColor ?? theme.colorScheme.secondaryVariant;
    var textColor = item.textColor;

    if (textColor == null) {
      switch (ThemeData.estimateBrightnessForColor(backgroundColor)) {
        case Brightness.dark:
          textColor = Colors.white;
          break;
        case Brightness.light:
          textColor = Colors.black;
          break;
      }
    }

    final titleStyle = theme.textTheme.headline5.apply(color: textColor);
    final buttonStyle = theme.textTheme.button.apply(color: textColor);
    final contentStyle =
        theme.textTheme.subtitle1.copyWith(color: textColor, height: 1.25);

    final contents = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (item.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: DefaultTextStyle(
              style: titleStyle,
              child: item.icon != null
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        item.icon,
                        const SizedBox(width: 6),
                        item.title,
                      ],
                    )
                  : item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        DefaultTextStyle(
          style: contentStyle,
          child: item.content,
          overflow: TextOverflow.ellipsis,
          maxLines: 10,
        )
      ],
    );

    final buttons = item.buttons.isNotEmpty
        ? <Widget>[
            const Divider(height: 0),
            Row(
              children: item.buttons
                  .map((button) => Flexible(
                        flex: 100 ~/ (item.buttons.length + 1),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: DefaultTextStyle(
                            style: buttonStyle,
                            child: button,
                          ),
                        ),
                      ))
                  .toList(growable: false),
            ),
          ]
        : const <Widget>[];

    return AnimatedBuilder(
      animation: _paddingNotifier,
      builder: (_, child) => AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutQuart,
        child: child,
        padding: _paddingNotifier.value
            .add(theme.cardTheme.margin * 1.5)
            .add(mediaQuery.viewInsets),
      ),
      child: Material(
        elevation: 12,
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        shape: theme.cardTheme.shape,
        child: InkWell(
          onTap: () => _dismissItem(item),
          child: IconTheme.merge(
            data: IconThemeData(color: textColor, size: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: theme.cardTheme.margin,
                  child: contents,
                ),
                if (buttons.isNotEmpty) ...buttons,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _store = EncapsulatedScaffoldStore.of<dynamic>(context);

    // Reaction to adjust screen padding based on the last
    // encapsulated scaffold
    _capsuleReactionDisposer = autorun((_) {
      final onScreenCapsule = _store.capsule;
      final mediaQuery = onScreenCapsule.scaffold?.context != null
          ? MediaQuery.of(onScreenCapsule.scaffold.context)
          : null;

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
  Widget build(BuildContext context) =>
      Provider<EncapsulatedNotificationOverlayController>.value(
        value: this,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            widget.child,
            Observer(
              builder: (context) => FancySwitcher.vertical(
                alignment: Alignment.bottomCenter,
                child: _items.isNotEmpty
                    ? KeyedSubtree(
                        key: ValueKey(_items.last.tag),
                        child: _buildOverlayItem(context, _items.last),
                      )
                    : const SizedBox(key: ValueKey('idle')),
              ),
            ),
          ],
        ),
      );
}
