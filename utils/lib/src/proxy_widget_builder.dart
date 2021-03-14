import 'package:flutter/material.dart';

class ProxyWidgetBuilder extends ProxyWidget {
  const ProxyWidgetBuilder({
    Key key,
    @required Widget child,
    this.onMounted,
    this.onUnmounted,
  }) : super(key: key, child: child);

  final ValueChanged<BuildContext> onMounted;
  final VoidCallback onUnmounted;

  @override
  Element createElement() => _Element(this);
}

class _Element extends ProxyElement {
  _Element(ProxyWidgetBuilder widget) : super(widget);

  @override
  ProxyWidgetBuilder get widget => super.widget as ProxyWidgetBuilder;

  @override
  void notifyClients(covariant ProxyWidget oldWidget) {}

  @override
  void mount(Element parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    widget.onMounted?.call(this);
  }

  @override
  void unmount() {
    super.unmount();
    widget.onUnmounted?.call();
  }
}
