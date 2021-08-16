import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

/// A widget that rebuilds by reacting to observables or when the given
/// [Listenable] changes value.
abstract class AnimatedObserverWidget extends StatefulObserverWidget {
  /// Creates a widget that rebuilds when the given listenable changes.
  ///
  /// The [listenable] argument is required.
  const AnimatedObserverWidget({
    Key? key,
    required this.listenable,
  }) : super(key: key);

  /// The [Listenable] to which this widget is listening.
  ///
  /// Commonly an [Animation] or a [ChangeNotifier].
  final Listenable listenable;

  /// Override this method to build widgets that depend on the state of the
  /// listenable (e.g., the current value of the animation).
  @protected
  Widget build(BuildContext context);

  /// Subclasses typically do not override this method.
  @override
  State<AnimatedWidget> createState() => _AnimatedState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Listenable>('animation', listenable));
  }
}

class _AnimatedState extends State<AnimatedWidget> {
  @override
  void initState() {
    super.initState();
    widget.listenable.addListener(markNeedsBuild);
  }

  @override
  void didUpdateWidget(AnimatedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listenable != oldWidget.listenable) {
      oldWidget.listenable.removeListener(markNeedsBuild);
      widget.listenable.addListener(markNeedsBuild);
    }
  }

  @override
  void dispose() {
    widget.listenable.removeListener(markNeedsBuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context);
}
