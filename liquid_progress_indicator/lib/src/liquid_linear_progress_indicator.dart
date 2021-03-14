import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/src/wave.dart';

class LiquidLinearProgressIndicator extends ProgressIndicator {
  LiquidLinearProgressIndicator({
    Key? key,
    double? value,
    Color? backgroundColor,
    Animation<Color?>? valueColor,
    this.child,
    this.direction = Axis.horizontal,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.easeInOut,
    this.waveDuration = const Duration(seconds: 2),
    this.shape,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
        );

  final ShapeBorder? shape;
  final Widget? child;
  final Axis direction;
  final Duration duration;
  final Curve curve;
  final Duration waveDuration;

  Color _getValueColor(BuildContext context) => valueColor?.value ?? Theme.of(context).accentColor;

  @override
  State<StatefulWidget> createState() => _LiquidLinearProgressIndicatorState();
}

class _LiquidLinearProgressIndicatorState extends State<LiquidLinearProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    final wave = Wave(
      value: widget.value ?? 0.0,
      color: widget._getValueColor(context),
      direction: widget.direction,
      duration: widget.duration,
      curve: widget.curve,
      waveDuration: widget.waveDuration,
    );

    final child = widget.child != null
        ? Stack(
            alignment: Alignment.center,
            children: <Widget>[
              wave,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DefaultTextStyle(
                  child: widget.child!,
                  style: Theme.of(context).textTheme.subtitle2!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        : wave;

    return widget.shape != null
        ? ClipPath(
            clipper: ShapeBorderClipper(shape: widget.shape!),
            child: child,
          )
        : child;
  }
}
