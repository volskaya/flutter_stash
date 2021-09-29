import 'dart:async';

import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

typedef IndicatorBuilder = Widget Function(BuildContext context, ValueListenable<double> animation, int thumbnailCount);

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    Key? key,
    required this.itemBuilder,
    required this.itemCount,
    this.pageController,
    this.height,
    this.aspectRatio,
    this.enableInfiniteScroll = true,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = standardEasing,
    this.pauseAutoPlayOnTouch,
    this.enlargeCenterPage = false,
    this.onPageChanged,
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
    this.scrollDirection = Axis.horizontal,
    this.shouldSkip,
    this.indicatorBuilder,
    this.initialPage,
    this.children = const <Widget>[],
    this.inherit = false,
    this.paintInheritedAnimations = false,
    this.wrapInheritBoundary = false,
  }) : super(key: key);

  static const int _kRealPage = 10000;

  final bool Function()? shouldSkip;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double? height;
  final double? aspectRatio;
  final bool enableInfiniteScroll;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final Duration? pauseAutoPlayOnTouch;
  final bool enlargeCenterPage;
  final Axis scrollDirection;
  final ValueChanged<int>? onPageChanged;
  final ScrollPhysics scrollPhysics;
  final PageController? pageController;
  final IndicatorBuilder? indicatorBuilder;
  final int? initialPage;
  final List<Widget> children;
  final bool inherit;
  final bool paintInheritedAnimations;
  final bool wrapInheritBoundary;

  static PageController getPageController({int initialPage = 0, int base = 0}) => PageController(
        viewportFraction: 1,
        initialPage: base + initialPage,
      );

  @override
  CarouselSliderState createState() => CarouselSliderState();
}

class CarouselSliderState extends State<CarouselSlider>
    with TickerProviderStateMixin<CarouselSlider>, WidgetsBindingObserver {
  late final PageController _pageController;
  late final PageControllerValueListenable _pageControllerValueListenable;
  Timer? _metronome; // Slide metronome.
  Timer? _timer; // Pause timer.
  double get currentPage =>
      (_pageController.page ?? 0.0) % (widget.enableInfiniteScroll ? CarouselSlider._kRealPage : widget.itemCount);

  int _getRealIndex(int index) {
    final base = widget.enableInfiniteScroll ? CarouselSlider._kRealPage : 0;
    final remainder = (index - base) % widget.itemCount;
    return remainder < 0 ? widget.itemCount + remainder : remainder;
  }

  void _handleTimerTick([dynamic _]) {
    assert(mounted);
    if (widget.autoPlay &&
        mounted &&
        ModalRoute.of(context)?.isCurrent == true &&
        !(widget.shouldSkip?.call() == true)) {
      _pageController.nextPage(
        duration: widget.autoPlayAnimationDuration,
        curve: widget.autoPlayCurve,
      );
    }
  }

  void _buildMetronome() {
    assert(_timer == null || !_timer!.isActive);
    assert(_metronome == null);
    _metronome?.cancel();
    _metronome = Timer.periodic(widget.autoPlayInterval, _handleTimerTick);
  }

  /// Cancel the metronome.
  void _handlePanDown([DragDownDetails? _]) {
    _timer?.cancel();
    _metronome?.cancel();
    _metronome = null; // Metronome will be rebuilt with a new anchor.
  }

  /// Resume the metronome after [CarouselSlider.pauseAutoPlayOnTouch] duration.
  void _handlePanEnd([DragEndDetails? _]) {
    _metronome?.cancel();
    _timer?.cancel();
    _timer = Timer(widget.pauseAutoPlayOnTouch!, _buildMetronome);
  }

  void _handlePageChange(int index) => widget.onPageChanged?.call(_getRealIndex(index));

  int getItemCount() => widget.enableInfiniteScroll ? CarouselSlider._kRealPage * 2 : widget.itemCount;
  int getBase() => widget.enableInfiniteScroll ? CarouselSlider._kRealPage : 0;

  @override
  void initState() {
    final initialPage = widget.initialPage ?? 0;
    final base = getBase();
    final maxItemCount = getItemCount();

    _pageController = widget.pageController ?? CarouselSlider.getPageController(initialPage: initialPage, base: base);
    _pageControllerValueListenable = PageControllerValueListenable(controller: _pageController, base: maxItemCount);

    _buildMetronome();
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _metronome?.cancel();
    _timer?.cancel();
    if (widget.pageController == null) _pageController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CarouselSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(oldWidget.enableInfiniteScroll == widget.enableInfiniteScroll);
  }

  bool? _toggledLifecycle;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        if (_toggledLifecycle != true && _metronome?.isActive != true) {
          _toggledLifecycle = true;
          _buildMetronome(); // Resume animations.
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (_toggledLifecycle != false) {
          _toggledLifecycle = false;
          _handlePanDown(); // Disposes metronome.
        }
        break;
    }
  }

  Widget _buildGestureDetector({required Widget child}) => GestureDetector(
        onPanDown: _handlePanDown,
        onPanEnd: _handlePanEnd,
        onPanCancel: _handlePanEnd,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    Widget pageView;

    switch (widget.scrollDirection) {
      case Axis.horizontal:
        pageView = FancyView.horizontal(
          itemBuilder: (context, i) => widget.itemBuilder(context, _getRealIndex(i)),
          itemCount: getItemCount(),
          controller: _pageController,
          onPageChanged: _handlePageChange,
          physics: widget.scrollPhysics,
          fillColor: Theme.of(context).colorScheme.background,
          inherit: widget.inherit,
          paintInheritedAnimations: widget.paintInheritedAnimations,
          wrapInheritBoundary: widget.wrapInheritBoundary,
          enableScroll: widget.itemCount > 1,
        );
        break;
      case Axis.vertical:
        pageView = FancyView.vertical(
          itemBuilder: (context, i) => widget.itemBuilder(context, _getRealIndex(i)),
          itemCount: getItemCount(),
          controller: _pageController,
          onPageChanged: _handlePageChange,
          physics: widget.scrollPhysics,
          fillColor: Theme.of(context).colorScheme.background,
          inherit: widget.inherit,
          paintInheritedAnimations: widget.paintInheritedAnimations,
          wrapInheritBoundary: widget.wrapInheritBoundary,
          enableScroll: widget.itemCount > 1,
        );
        break;
    }

    if (widget.height != null) {
      pageView = SizedBox(height: widget.height, child: pageView);
    } else if (widget.aspectRatio != null) {
      pageView = AspectRatio(aspectRatio: widget.aspectRatio!, child: pageView);
    }

    if (widget.autoPlay && widget.pauseAutoPlayOnTouch != null) {
      pageView = _buildGestureDetector(child: pageView);
    }

    if (widget.indicatorBuilder != null) {
      pageView = Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        children: <Widget>[
          pageView,
          if (widget.indicatorBuilder != null)
            widget.indicatorBuilder!(context, _pageControllerValueListenable, widget.itemCount),
          ...widget.children,
        ],
      );
    }

    return pageView;
  }
}
