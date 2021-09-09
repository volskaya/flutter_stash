import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A widget that rebuilds when the given [Listenable] changes value.
///
/// Unlike [AnimatedWidget], this widget also has a `shouldRebuild` callback.
abstract class AnimatedChangeWidget<T> extends StatefulWidget {
  /// Creates a widget that rebuilds when the given listenable changes.
  ///
  /// The [listenable] argument is required.
  const AnimatedChangeWidget({
    Key? key,
    required this.listenable,
  }) : super(key: key);

  /// The [Listenable] to which this widget is listening.
  ///
  /// Commonly an [Animation] or a [ChangeNotifier].
  final ValueListenable<T> listenable;

  /// Override this method to build widgets that depend on the state of the
  /// listenable (e.g., the current value of the animation).
  @protected
  Widget build(BuildContext context);

  @protected
  bool shouldRebuild(T oldValue, T value) => oldValue != value;

  /// Subclasses typically do not override this method.
  @override
  State<AnimatedChangeWidget<T>> createState() => _AnimatedState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Listenable>('listenable', listenable));
  }
}

class _AnimatedState<T> extends State<AnimatedChangeWidget<T>> {
  late T _oldValue;

  void _handleChange() {
    final value = widget.listenable.value;
    final shouldRebuild = widget.shouldRebuild(_oldValue, value);

    if (shouldRebuild) {
      _oldValue = value;
      markNeedsBuild();
    }
  }

  @override
  void initState() {
    super.initState();
    _oldValue = widget.listenable.value;
    widget.listenable.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(AnimatedChangeWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listenable != oldWidget.listenable) {
      oldWidget.listenable.removeListener(_handleChange);
      widget.listenable.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.listenable.removeListener(_handleChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context);
}
