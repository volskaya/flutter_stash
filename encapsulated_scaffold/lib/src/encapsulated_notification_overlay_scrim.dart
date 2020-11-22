import 'package:flutter/material.dart';

/// Dark scrim overlay to be placed behind notifications.
///
/// Scrim widget is removed from the tree, when the animation is in a dismissed state.
class EncapsulatedNotificationOverlayScrim extends StatefulWidget {
  /// Creates [EncapsulatedNotificationOverlayScrim].
  const EncapsulatedNotificationOverlayScrim({
    Key key,
    @required this.onDismissed,
    this.toggled = false,
    this.duration = kThemeAnimationDuration,
  }) : super(key: key);

  /// Toggle of the scrim
  final bool toggled;

  /// Duration of the color animation.
  final Duration duration;

  /// Callback to execute, when the scrim is tapped - needing to be dismissed.
  final VoidCallback onDismissed;

  @override
  _EncapsulatedNotificationOverlayScrimState createState() => _EncapsulatedNotificationOverlayScrimState();
}

class _EncapsulatedNotificationOverlayScrimState extends State<EncapsulatedNotificationOverlayScrim>
    with SingleTickerProviderStateMixin<EncapsulatedNotificationOverlayScrim> {
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  bool _buildScrim = false;

  TickerFuture close() => _controller.reverse();

  bool _handleBarrierDissmiss() {
    widget.onDismissed();
    return false;
  }

  void _handleEnd(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        setState(() => _buildScrim = false);
        break;
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
      case AnimationStatus.completed:
        break; // Do nothing
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.toggled ? 1 : 0,
    )..addStatusListener(_handleEnd);

    _colorAnimation = ColorTween(
      begin: Colors.black54.withAlpha(0),
      end: Colors.black54,
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant EncapsulatedNotificationOverlayScrim oldWidget) {
    if (oldWidget.toggled != widget.toggled) {
      if (widget.toggled) {
        _controller.forward();
      } else {
        // NOTE: The scrim widget will be removed, when the animation is dismissed.
        _controller.reverse();
      }

      if (widget.toggled && !_buildScrim) _buildScrim = true;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => _buildScrim
      ? SizedBox.expand(
          child: IgnorePointer(
            ignoring: !widget.toggled,
            child: AnimatedModalBarrier(
              color: _colorAnimation,
              dismissible: true,
              willDismiss: _handleBarrierDissmiss,
            ),
          ),
        )
      : const SizedBox.shrink();
}
