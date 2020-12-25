import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/src/bottom_sheet.dart';

/// Widget that that will scroll to the top the ScrollController
/// when tapped on the status bar.
///
/// Extracted from Scaffold and used in modal bottom sheet.
class ScrollToTopStatusBarHandler extends StatefulWidget {
  const ScrollToTopStatusBarHandler({
    Key key,
    @required this.child,
    @required this.scrollController,
  }) : super(key: key);

  final Widget child;
  final ScrollController scrollController;

  @override
  _ScrollToTopStatusBarState createState() => _ScrollToTopStatusBarState();
}

class _ScrollToTopStatusBarState extends State<ScrollToTopStatusBarHandler> {
  void _handleStatusBarTap(BuildContext context) {
    if (widget.scrollController?.hasClients == true) {
      widget.scrollController.animateTo(0.0, duration: kMediumMotionDuration, curve: standardEasing);
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          widget.child,
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).padding.top,
            child: Builder(
              builder: (context) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                excludeFromSemantics: true, // iOS accessibility automatically adds scroll-to-top to the status clock.
                onTap: () => _handleStatusBarTap(context),
              ),
            ),
          ),
        ],
      );
}
