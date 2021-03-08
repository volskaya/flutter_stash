import 'dart:async';

import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

typedef IndicatorBuilder = Widget Function(BuildContext context, ValueListenable<double> animation, int thumbnailCount);

class CarouselSlider extends StatefulWidget {
  const CarouselSlider({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
    this.pageStorageKey,
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
    this.scrollPhysics,
    this.scrollDirection = Axis.horizontal,
    this.shouldSkip,
    this.indicatorBuilder,
    this.initialPage,
  }) : super(key: key);

  static const int _kRealPage = 10000;

  final PageStorageKey pageStorageKey;
  final bool Function() shouldSkip;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double height;
  final double aspectRatio;
  final bool enableInfiniteScroll;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final Duration autoPlayAnimationDuration;
  final Curve autoPlayCurve;
  final Duration pauseAutoPlayOnTouch;
  final bool enlargeCenterPage;
  final Axis scrollDirection;
  final ValueChanged<int> onPageChanged;
  final ScrollPhysics scrollPhysics;
  final PageController pageController;
  final IndicatorBuilder indicatorBuilder;
  final int initialPage;

  static PageController getPageController({int initialPage = 0}) => PageController(
        viewportFraction: 1,
        initialPage: CarouselSlider._kRealPage + initialPage,
      );

  @override
  CarouselSliderState createState() => CarouselSliderState();
}

class CarouselSliderState extends State<CarouselSlider>
    with TickerProviderStateMixin<CarouselSlider>, WidgetsBindingObserver {
  PageController _pageController;
  PageControllerValueListenable _pageControllerValueListenable;
  Timer _metronome; // Slide metronome.
  Timer _timer; // Pause timer.
  double get currentPage => (_pageController?.page ?? 0.0) % CarouselSlider._kRealPage;

  int _getRealIndex(int index) {
    final remainder = (index - CarouselSlider._kRealPage) % widget.itemCount;
    return remainder < 0 ? widget.itemCount + remainder : remainder;
  }

  void _handleTimerTick([dynamic _]) {
    assert(mounted);
    if (widget.autoPlay && mounted && ModalRoute.of(context).isCurrent && !(widget.shouldSkip?.call() == true)) {
      _pageController.nextPage(
        duration: widget.autoPlayAnimationDuration,
        curve: widget.autoPlayCurve,
      );
    }
  }

  void _buildMetronome() {
    assert(_timer == null || !_timer.isActive);
    assert(_metronome == null);
    _metronome?.cancel();
    _metronome = Timer.periodic(widget.autoPlayInterval, _handleTimerTick);
  }

  /// Cancel the metronome
  void _handlePanDown([DragDownDetails _]) {
    _timer?.cancel();
    _metronome?.cancel();
    _metronome = null; // Metronome will be rebuilt with a new anchor
  }

  /// Resume the metronome after [CarouselSlider.pauseAutoPlayOnTouch] duration
  void _handlePanEnd([DragEndDetails _]) {
    _metronome?.cancel();
    _timer?.cancel();
    _timer = Timer(widget.pauseAutoPlayOnTouch, _buildMetronome);
  }

  void _handlePageChange(int index) => widget.onPageChanged?.call(_getRealIndex(index));

  @override
  void initState() {
    _pageController = widget.pageController ?? CarouselSlider.getPageController(initialPage: widget.initialPage ?? 0);
    _pageControllerValueListenable = PageControllerValueListenable(
      controller: _pageController,
      base: CarouselSlider._kRealPage,
    );

    _buildMetronome();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _metronome?.cancel();
    _timer?.cancel();
    if (widget.pageController == null) _pageController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        if (_metronome?.isActive != true) _buildMetronome(); // Resume animations.
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _handlePanDown(); // Disposes metronome.
        break;
    }
  }

  Widget _buildGestureDetector({@required Widget child}) => GestureDetector(
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
          itemCount: CarouselSlider._kRealPage * 2,
          controller: _pageController,
          onPageChanged: _handlePageChange,
          physics: widget.enableInfiniteScroll ? widget.scrollPhysics : const NeverScrollableScrollPhysics(),
          fillColor: Theme.of(context).colorScheme.background,
        );
        break;
      case Axis.vertical:
        pageView = FancyView.vertical(
          itemBuilder: (context, i) => widget.itemBuilder(context, _getRealIndex(i)),
          itemCount: CarouselSlider._kRealPage * 2,
          controller: _pageController,
          onPageChanged: _handlePageChange,
          physics: widget.enableInfiniteScroll ? widget.scrollPhysics : const NeverScrollableScrollPhysics(),
          fillColor: Theme.of(context).colorScheme.background,
        );
        break;
    }

    if (widget.height != null) {
      pageView = SizedBox(height: widget.height, child: pageView);
    } else if (widget.aspectRatio != null) {
      pageView = AspectRatio(aspectRatio: widget.aspectRatio, child: pageView);
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
          widget.indicatorBuilder(context, _pageControllerValueListenable, widget.itemCount),
        ],
      );
    }

    return pageView;
  }
}
