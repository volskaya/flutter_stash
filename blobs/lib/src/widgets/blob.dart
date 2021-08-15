import 'dart:async';

import 'package:blobs/blobs.dart';
import 'package:blobs/src/config.dart';
import 'package:blobs/src/models.dart';
import 'package:blobs/src/services/blob_generator.dart';
import 'package:blobs/src/widgets/animated_blob.dart';
import 'package:blobs/src/widgets/simple_blob.dart';
import 'package:flutter/material.dart';

class Blob extends StatefulWidget {
  const Blob.random({
    Key? key,
    required this.size,
    this.edgesCount = BlobConfig.edgesCount,
    this.minGrowth = BlobConfig.minGrowth,
    this.debug = false,
    this.styles,
    this.child,
  })  : loop = false,
        seed = null,
        duration = null,
        isAnimated = false,
        super(key: key);

  const Blob.animatedRandom({
    Key? key,
    required this.size,
    this.edgesCount = BlobConfig.edgesCount,
    this.minGrowth = BlobConfig.minGrowth,
    this.debug = false,
    this.styles,
    this.duration = const Duration(milliseconds: BlobConfig.animDurationMs),
    this.loop = false,
    this.child,
  })  : isAnimated = true,
        seed = null,
        super(key: key);

  const Blob.fromSeed({
    Key? key,
    required this.seed,
    required this.size,
    this.debug = false,
    this.styles,
    this.child,
  })  : loop = false,
        edgesCount = null,
        minGrowth = null,
        duration = null,
        isAnimated = false,
        super(key: key);

  const Blob.animatedFromSeed({
    Key? key,
    required this.seed,
    required this.size,
    this.debug = false,
    this.styles,
    this.duration = const Duration(milliseconds: BlobConfig.animDurationMs),
    this.loop = false,
    this.child,
  })  : isAnimated = true,
        edgesCount = null,
        minGrowth = null,
        super(key: key);

  final double size;
  final bool debug;
  final BlobStyles? styles;
  final Widget? child;
  final int? edgesCount;
  final int? minGrowth;
  final List<String>? seed;
  final Duration? duration;
  final bool loop;
  final bool isAnimated;

  static int count = 0;

  @override
  _BlobState createState() => _BlobState();
}

class _BlobState extends State<Blob> {
  BlobData? _blobData;
  BlobData? _fromBlobData;
  Timer? _timer;

  BlobData _getRandomBlobData() => BlobGenerator(
        edgesCount: widget.edgesCount ?? 2,
        minGrowth: widget.minGrowth ?? 3,
        size: Size.square(widget.size),
        seed: _getRandomizedSeed(),
      ).generate();

  String? _getRandomizedSeed() {
    if (!(widget.seed?.isNotEmpty == true)) return null;

    Blob.count++;
    if (widget.seed!.length == 1) return widget.seed![0];
    return widget.seed![Blob.count % widget.seed!.length];
  }

  BlobData _updateBlob([dynamic _]) {
    if (widget.isAnimated) _fromBlobData = _blobData;
    _blobData = _getRandomBlobData();
    markNeedsBuild();
    return _blobData!;
  }

  @override
  void initState() {
    super.initState();
    _updateBlob();
    _handleLoopChange();
  }

  void _handleLoopChange({bool durationChanged = false}) {
    if ((_timer == null || durationChanged) && widget.loop) {
      final instantlyUpdateBlob = _timer == null;
      _timer?.cancel();
      _timer = Timer.periodic(widget.duration ?? const Duration(seconds: 1), _updateBlob);
      if (instantlyUpdateBlob) _updateBlob();
    } else if (_timer != null && !widget.loop) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void didUpdateWidget(covariant Blob oldWidget) {
    if (oldWidget.loop != widget.loop || oldWidget.duration != widget.duration)
      _handleLoopChange(durationChanged: oldWidget.duration != widget.duration);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => !widget.isAnimated
      ? SimpleBlob(
          blobData: _blobData!,
          size: widget.size,
          styles: widget.styles,
          debug: widget.debug,
          child: widget.child,
        )
      : AnimatedBlob(
          fromBlobData: _fromBlobData,
          toBlobData: _blobData!,
          size: widget.size,
          styles: widget.styles,
          debug: widget.debug,
          duration: widget.duration,
          child: widget.child,
        );
}
