import 'package:flutter/material.dart';
import 'package:utils/src/ink_features_widget.dart';

class OverlayedInkWell extends StatelessWidget {
  const OverlayedInkWell({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.onTapCancel,
    this.fit = StackFit.passthrough,
    this.borderRadius,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onTapCancel;
  final BorderRadius? borderRadius;
  final StackFit fit;

  @override
  Widget build(BuildContext context) => Stack(
        fit: fit,
        clipBehavior: Clip.none,
        children: <Widget>[
          child,
          Positioned.fill(
            child: InkFeaturesWidget(
              child: InkWell(
                onTap: onTap,
                onLongPress: onLongPress,
                onTapCancel: onTapCancel,
                borderRadius: borderRadius,
              ),
            ),
          ),
        ],
      );
}
