import 'package:flutter/material.dart';

/// These are the ink features being built by the [Material] widget to
/// provide a surface for inks.
class InkFeaturesWidget extends StatefulWidget {
  const InkFeaturesWidget({
    Key? key,
    required this.child,
    this.absorbHitTest = true,
    this.color,
    this.clipBehavior = Clip.none,
    this.paintForeground = false,
  }) : super(key: key);

  final Widget child;
  final bool absorbHitTest;
  final Color? color;
  final Clip clipBehavior;
  final bool paintForeground;

  @override
  _InkFeaturesWidgetState createState() => _InkFeaturesWidgetState();
}

class _InkFeaturesWidgetState extends State<InkFeaturesWidget> with TickerProviderStateMixin<InkFeaturesWidget> {
  final _inkFeatureRenderer = GlobalKey(debugLabel: 'InkFeaturesWidget ink renderer');

  bool _handleLayoutChangeNotification(LayoutChangedNotification notification) {
    final renderer = _inkFeatureRenderer.currentContext!.findRenderObject()! as RenderInkFeatures;
    renderer.didChangeLayout();
    return false;
  }

  @override
  Widget build(BuildContext context) => NotificationListener<LayoutChangedNotification>(
        onNotification: _handleLayoutChangeNotification,
        child: InkFeatures(
          key: _inkFeatureRenderer,
          vsync: this,
          color: widget.color,
          absorbHitTest: widget.absorbHitTest,
          child: widget.child,
          clipBehavior: widget.clipBehavior,
          paintForeground: widget.paintForeground,
        ),
      );
}
