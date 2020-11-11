part of direct_select_plugin;

class _MySelectionOverlay extends StatefulWidget {
  final double top;
  final Widget child;
  final double bottom;
  final Color backgroundColor;
  final List<Widget> overlayChildren;

  const _MySelectionOverlay({
    Key key,
    this.top,
    this.bottom,
    this.child,
    this.backgroundColor,
    this.overlayChildren,
  }) : super(key: key);

  @override
  _MySelectionOverlayState createState() {
    return _MySelectionOverlayState();
  }
}

class _MySelectionOverlayState extends State<_MySelectionOverlay> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 230),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(color: widget.backgroundColor),
          ),
          Positioned(
            top: widget.top - MediaQuery.of(context).size.height / 2,
            left: 0.0,
            right: 0.0,
            bottom: widget.bottom,
            child: ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.12).animate(_controller),
              child: widget.child,
            ),
          ),
          ...widget.overlayChildren,
        ],
      ),
    );
  }

  void reverse(OverlayEntry overlayEntry) {
    _controller.reverse().whenComplete(() => overlayEntry.remove());
  }
}

class _MySelectionList extends StatelessWidget {
  final FixedExtentScrollController controller;
  final IndexedWidgetBuilder builder;
  final int childCount;
  final ValueChanged<int> onItemChanged;
  final VoidCallback onItemSelected;
  final double itemExtent;
  final double itemMagnification;
  final bool allowScrollEnd;

  const _MySelectionList({
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

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 2,
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
}
