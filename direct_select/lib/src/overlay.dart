import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySelectionOverlay extends StatefulWidget {
  final double top;
  final Widget child;
  final double bottom;
  final Color backgroundColor;
  final List<Widget> overlayChildren;

  const MySelectionOverlay({
    Key key,
    this.top,
    this.bottom,
    this.child,
    this.backgroundColor,
    this.overlayChildren,
  }) : super(key: key);

  @override
  MySelectionOverlayState createState() {
    return MySelectionOverlayState();
  }
}

class MySelectionOverlayState extends State<MySelectionOverlay> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _fadeAnimation;

  void _handleStatus(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        break;
      case AnimationStatus.dismissed:
        _rebuildAnimations(decelerateEasing);
        break;
      case AnimationStatus.completed:
        _rebuildAnimations(accelerateEasing);
        break;
    }
  }

  void _rebuildAnimations(Curve curve) {
    assert(_controller != null);
    final curveTween = CurveTween(curve: curve);
    _scaleAnimation = Tween(begin: 1.0, end: 1.12).chain(curveTween).animate(_controller);
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).chain(curveTween).animate(_controller);
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 200),
    )..addStatusListener(_handleStatus);
    _handleStatus(_controller.status);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: <Widget>[
            ColoredBox(color: widget.backgroundColor),
            Positioned(
              // top: widget.top - MediaQuery.of(context).size.height / 2,
              top: widget.top,
              left: 0.0,
              right: 0.0,
              bottom: widget.bottom,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: widget.child,
              ),
            ),
            ...widget.overlayChildren,
          ],
        ),
      );

  void reverse(OverlayEntry overlayEntry) {
    _controller.reverse().whenComplete(() => overlayEntry.remove());
  }
}

class MySelectionList extends StatelessWidget {
  const MySelectionList({
    Key key,
    @required this.controller,
    @required this.builder,
    @required this.childCount,
    @required this.onItemChanged,
    @required this.onItemSelected,
    @required this.itemExtent,
    @required this.itemMagnification,
    this.allowScrollEnd = true,
  }) : super(key: key);

  final FixedExtentScrollController controller;
  final IndexedWidgetBuilder builder;
  final int childCount;
  final ValueChanged<int> onItemChanged;
  final VoidCallback onItemSelected;
  final double itemExtent;
  final double itemMagnification;
  final bool allowScrollEnd;

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (!allowScrollEnd && scrollNotification is ScrollEndNotification) {
                onItemSelected();
              }
              return false;
            },
            child: CupertinoPicker.builder(
              scrollController: controller,
              offAxisFraction: 0.0,
              itemExtent: itemExtent,
              childCount: childCount,
              useMagnifier: true,
              magnification: itemMagnification,
              diameterRatio: 13.0,
              // squeeze: 10,
              onSelectedItemChanged: onItemChanged,
              itemBuilder: builder,
            ),
          ),
        ),
      );
}
