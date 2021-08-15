import 'package:blobs/blobs.dart';
import 'package:blobs/src/models.dart';
import 'package:blobs/src/services/blob_animator.dart';
import 'package:blobs/src/services/blob_generator.dart';
import 'package:blobs/src/widgets/simple_blob.dart';
import 'package:flutter/material.dart';

class AnimatedBlob extends StatefulWidget {
  const AnimatedBlob({
    Key? key,
    required this.toBlobData,
    this.fromBlobData,
    this.size = 200,
    this.debug = false,
    this.styles,
    this.seed,
    this.duration,
    this.child,
  }) : super(key: key);

  final double size;
  final bool debug;
  final BlobStyles? styles;
  final String? seed;
  final Widget? child;
  final Duration? duration;
  final BlobData? fromBlobData; // FIXME: WTF is this?
  final BlobData toBlobData; // FIXME: WTF is this?

  @override
  _AnimatedBlobState createState() => _AnimatedBlobState();
}

class _AnimatedBlobState extends State<AnimatedBlob> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final BlobAnimator _animator;
  late BlobGenerator _generator;
  late BlobData _data;

  void _handleGeneratorChange() => _generator = BlobGenerator(
        edgesCount: widget.toBlobData.edges,
        minGrowth: widget.toBlobData.growth,
        size: Size(widget.size, widget.size),
      );

  void _handlePointsChange() => _animator.morphTo(widget.toBlobData.points!.destPoints);

  void _handleBlobAnimatorChange(List<Offset> offsets) {
    _data = _generator.generateFromPoints(offsets);
    markNeedsBuild();
  }

  @override
  void initState() {
    _handleGeneratorChange();
    _animationController = AnimationController(duration: widget.duration, vsync: this);
    _animator = BlobAnimator(
      animationController: _animationController,
      pathPoints: widget.toBlobData.points!.destPoints,
      onChanged: _handleBlobAnimatorChange,
    );

    _handlePointsChange();
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedBlob oldWidget) {
    if (oldWidget.toBlobData != widget.toBlobData || oldWidget.size != widget.size) _handleGeneratorChange();
    if (oldWidget.toBlobData != widget.toBlobData) _handlePointsChange();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animator.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SimpleBlob(
        blobData: _data,
        styles: widget.styles,
        debug: widget.debug,
        size: widget.size,
        child: widget.child,
      );
}
