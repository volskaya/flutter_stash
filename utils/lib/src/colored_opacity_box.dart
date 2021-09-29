import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ColoredOpacityBox extends SingleChildRenderObjectWidget {
  /// Creates a widget that paints its area with the specified [Color].
  ///
  /// The [color] parameter must not be null.
  const ColoredOpacityBox({
    Key? key,
    required this.color,
    this.opacity,
    Widget? child,
  }) : super(key: key, child: child);

  /// The color to paint the background area with.
  final Color color;

  /// The opacity animation to pass to the render box.
  final Animation<double>? opacity;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderBox(color: color, opacity: opacity);
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    (renderObject as _RenderBox)
      ..color = color
      ..opacity = opacity;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(DiagnosticsProperty<Animation<double>>('opacity', opacity));
  }
}

class _RenderBox extends RenderProxyBoxWithHitTestBehavior {
  _RenderBox({
    required Color color,
    Animation<double>? opacity,
  })  : _color = color,
        _opacity = opacity,
        super(behavior: HitTestBehavior.opaque) {
    _opacity?.addListener(markNeedsPaint);
  }

  /// The fill color for this render object.
  ///
  /// This parameter must not be null.
  Color get color => _color;
  Color _color;
  set color(Color value) {
    if (value == _color) {
      return;
    }
    _color = value;
    markNeedsPaint();
  }

  Animation<double>? get opacity => _opacity;
  Animation<double>? _opacity;
  set opacity(Animation<double>? value) {
    if (value == _opacity) {
      return;
    }
    _opacity?.removeListener(markNeedsPaint);
    _opacity = value?..addListener(markNeedsPaint);
    markNeedsPaint();
  }

  @override
  void dispose() {
    _opacity?.removeListener(markNeedsPaint);
    super.dispose();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // It's tempting to want to optimize out this `drawRect()` call if the
    // color is transparent (alpha==0), but doing so would be incorrect. See
    // https://github.com/flutter/flutter/pull/72526#issuecomment-749185938 for
    // a good description of why.
    if (size > Size.zero) {
      final effectiveColor = _opacity != null ? color : color.withRelativeOpacity(opacity!.value);
      context.canvas.drawRect(offset & size, Paint()..color = effectiveColor);
    }
    if (child != null) {
      context.paintChild(child!, offset);
    }
  }
}

extension _ColorExtension on Color {
  Color withRelativeOpacity(double opacity) {
    if (opacity >= 1.0) return this;
    final a = alpha != 255 ? ui.lerpDouble(0.0, alpha, opacity)!.round() : (255.0 * opacity).round();
    return withAlpha(a);
  }
}
