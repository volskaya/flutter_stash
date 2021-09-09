import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A widget that rebuilds when the given [Listenable] changes value.
///
/// Unlike [AnimatedWidget], this widget also has a `shouldRebuild` callback.
abstract class AnimatedListenableWidget<D extends Listenable, T> extends StatefulWidget {
  /// Creates a widget that rebuilds when the given listenable changes.
  ///
  /// The [listenable] argument is required.
  const AnimatedListenableWidget({
    Key? key,
    required this.listenable,
  }) : super(key: key);

  /// The [Listenable] to which this widget is listening.
  ///
  /// Commonly an [Animation] or a [ChangeNotifier].
  final D listenable;

  /// Override this method to build widgets that depend on the state of the
  /// listenable (e.g., the current value of the animation).
  @protected
  Widget build(BuildContext context, T value);

  @protected
  bool shouldRebuild(T oldValue, T value) => oldValue != value;

  @protected
  T getValue(D listenable);

  /// Subclasses typically do not override this method.
  @override
  State<AnimatedListenableWidget<D, T>> createState() => _AnimatedState<D, T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Listenable>('listenable', listenable));
  }
}

class _AnimatedState<D extends Listenable, T> extends State<AnimatedListenableWidget<D, T>> {
  late T _value;

  void _handleChange() {
    final value = widget.getValue(widget.listenable);
    final shouldRebuild = widget.shouldRebuild(_value, value);

    if (shouldRebuild) {
      _value = value;
      markNeedsBuild();
    }
  }

  @override
  void initState() {
    super.initState();
    _value = widget.getValue(widget.listenable);
    widget.listenable.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(AnimatedListenableWidget<D, T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listenable != oldWidget.listenable) {
      oldWidget.listenable.removeListener(_handleChange);
      widget.listenable.addListener(_handleChange);
      _handleChange();
    }
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_handleChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, _value);
}
