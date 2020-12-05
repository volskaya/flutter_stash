library future_card_button;

import 'dart:async';

import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// When the [callback] is null, the button is locked/loading.
typedef FutureButtonChildBuilder = Widget Function(BuildContext context, VoidCallback callback);

/// Builder that passes locking mechanism of [FutureCardButton].
class FutureButtonBuilder extends StatefulWidget {
  /// Creates [FutureButtonBuilder].
  const FutureButtonBuilder({
    Key key,
    @required this.builder,
    @required this.onPressed,
    this.family,
  }) : super(key: key);

  /// Child builder callback.
  final FutureButtonChildBuilder builder;

  /// Future event, when the button is pressed.
  final Future Function() onPressed;

  /// If `family` is defined, the buttons will share the same notifiers
  /// and lock/unlock at the same time
  final String family;

  @override
  FutureButtonBuilderState createState() => FutureButtonBuilderState();
}

/// State of [FutureButtonBuilder] that exposes [FutureBuilderState.press].
class FutureButtonBuilderState extends State<FutureButtonBuilder> {
  // Used, when the widget has no family
  final _privateNotifier = ValueNotifier<bool>(false);

  ValueNotifier<bool> get _notifier {
    if (widget.family?.isNotEmpty == true) {
      FutureCardButton._notifiers[widget.family] ??= ValueNotifier<bool>(false);
      return FutureCardButton._notifiers[widget.family];
    }
    return _privateNotifier;
  }

  Future _handleOnPressed() async {
    if (_notifier.value) return; // Redundant
    _notifier.value = true;
    try {
      await widget.onPressed?.call();
    } finally {
      if (mounted) _notifier.value = false;
    }
  }

  /// Trigger buttons press event.
  Future press() => _handleOnPressed();

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _notifier,
        builder: (context, __) => widget.builder(
          context,
          !_notifier.value && widget.onPressed != null ? _handleOnPressed : null,
        ),
      );
}

/// [FutureCardButton] allows passing future `onPress` callacks which animate
/// in an a loader indicator, until the future is completed.
///
/// [FutureCardButtons] can be linked by specifying `family`, which will have
/// them use the same status notifier, which allows triggering the indicator
/// across multiple buttons.
class FutureCardButton extends StatefulWidget {
  /// Creates material design themed [FutureCardButton].
  const FutureCardButton({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.color,
    this.textColor,
    this.width = double.infinity,
    this.height = 56, // Match size with the text fields
    this.family,
    this.elevation,
    this.shape,
  })  : _adaptive = false,
        super(key: key);

  /// Creates an adaptive [FutureCardButton].
  ///
  /// On iOS the future indicator will show a [CupertinoActivityIndicator],
  /// on Android - [CircularProgressIndicator].
  const FutureCardButton.adaptive({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.color,
    this.textColor,
    this.width = double.infinity,
    this.height = 56, // Match size with the text fields
    this.family,
    this.elevation,
    this.shape,
  })  : _adaptive = true,
        super(key: key);

  /// Creates a [FutureCardButton] with no indicator animation and future callback.
  static Widget simple({
    Key key,
    @required Widget child,
    @required VoidCallback onPressed,
    Color color,
    Color textColor,
    double width = double.infinity,
    double height = 56, // Match size with the text fields
    double elevation,
    ShapeBorder shape,
  }) =>
      _SimpleButton(
        key: key,
        child: child,
        onPressed: onPressed,
        color: color,
        textColor: textColor,
        width: width,
        height: height,
        elevation: elevation,
        shape: shape,
      );

  /// Child of the button, usually [Text].
  final Widget child;

  /// Future event, when the button is pressed.
  final Future Function() onPressed;

  /// Color of the button. Defaults to [ThemeData.buttonColor].
  final Color color;

  /// Text color override.
  final Color textColor;

  /// Width of the button.
  final double width;

  /// Height of the button.
  final double height;

  /// Elevation of the button.
  final double elevation;

  /// Shape of the button.
  final ShapeBorder shape;

  /// If `family` is defined, the buttons will share the same notifiers
  /// and lock/unlock at the same time
  final String family;

  static final _notifiers = <String, ValueNotifier<bool>>{};
  final bool _adaptive;

  /// Returns true when the `family` is locked - `onPress` future in progress.
  static bool isFamilyLocked(String family) => _notifiers.containsKey(family) && _notifiers[family].value;

  @override
  FutureCardButtonState createState() => FutureCardButtonState();
}

/// State of [FutureCardButton].
class FutureCardButtonState extends State<FutureCardButton> {
  // Used, when the widget has no family
  final _privateNotifier = ValueNotifier<bool>(false);

  ValueNotifier<bool> get _notifier {
    if (widget.family?.isNotEmpty == true) {
      FutureCardButton._notifiers[widget.family] ??= ValueNotifier<bool>(false);
      return FutureCardButton._notifiers[widget.family];
    }
    return _privateNotifier;
  }

  Future _handleOnPressed() async {
    if (_notifier.value) return; // Redundant
    _notifier.value = true;
    try {
      await widget.onPressed?.call();
    } finally {
      if (mounted) _notifier.value = false;
    }
  }

  /// Trigger buttons press event.
  Future press() => _handleOnPressed();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget indicator;

    if (_notifier.value) {
      if (widget._adaptive) {
        switch (theme.platform) {
          case TargetPlatform.iOS:
          case TargetPlatform.macOS:
            indicator = const CupertinoActivityIndicator();
            break;
          default:
            indicator = const CircularProgressIndicator();
        }
      } else {
        // If the widget is not adaptive, default to material indicator
        indicator = const CircularProgressIndicator();
      }
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _notifier,
        builder: (_, __) => RaisedButton(
          onPressed: !_notifier.value ? _handleOnPressed : null,
          color: widget.color,
          textColor: widget.textColor,
          shape: widget.shape ?? theme.cardTheme.shape,
          elevation: widget.elevation ?? theme.cardTheme.elevation,
          child: FancySwitcher.horizontal(
            child: indicator != null
                ? SizedBox.fromSize(
                    key: const ValueKey('future_in_progress'),
                    size: const Size.square(24),
                    child: const CupertinoActivityIndicator(),
                  )
                : KeyedSubtree(key: const ValueKey('idle'), child: widget.child),
          ),
        ),
      ),
    );
  }
}

/// Version of [FutureCardButton], without the animation
class _SimpleButton extends StatelessWidget {
  const _SimpleButton({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.color,
    this.textColor,
    this.width = double.infinity,
    this.height = 56, // Match size with the text fields
    this.elevation,
    this.shape,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double elevation;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        textColor: textColor,
        child: child,
        elevation: elevation ?? theme.cardTheme.elevation,
        shape: shape ?? theme.cardTheme.shape,
      ),
    );
  }
}
