import 'dart:math' as math;

import 'package:animations/animations.dart';
import 'package:await_route/await_route.dart';
import 'package:carousel_slider/src/carousel_slider.dart';
import 'package:carousel_slider/src/periodic_child_switcher.dart';
import 'package:carousel_slider/src/periodic_child_switcher_builder.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:refresh_storage/refresh_storage.dart';
import 'package:utils/utils.dart';

typedef MultiPhotoCarouselChildWrap = Widget
    Function(BuildContext context, FirebasePhotoReference? photo, Widget child);

class _Storage extends RefreshStorageItem {
  _Storage({this.lastPage});
  int? lastPage;
}

enum MultiPhotoCarouselStyle {
  /// The carousel builds photos in a [PageView] with [SwitchingImage] children.
  draggable,

  /// The carousel builds photos in a [FancySwitcher] with [SwitchingImage] children.
  periodicallySwitched,

  /// The carousel builds photos with a single [SwitchingImage].
  periodicallySwitchedImage,
}

/// Copy pasted from a different project
class MultiPhotoCarousel extends StatefulWidget {
  const MultiPhotoCarousel({
    Key? key,
    required this.photos,
    required this.idleChild,
    required this.bucket,
    this.wrap,
    this.initialPage,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.autoPlay = true,
    this.shouldSkip,
    this.indicatorBuilder,
    this.scrollAware = false,
    this.precacheSurroundingPhotos = true,
    this.precacheThumbnailsInstead = false,
    this.getCacheSize,
    this.style = MultiPhotoCarouselStyle.draggable,
    this.autoPlayAnimationDuration = const Duration(milliseconds: 600),
    this.children = const <Widget>[],
    this.uniqueIdleChildBuilder,
    this.inherit = false,
    this.paintInheritedAnimations = false,
    this.wrapInheritBoundary = false,
  }) : super(key: key);

  final String? bucket;
  final int? initialPage;
  final MultiPhotoCarouselChildWrap? wrap;
  final Map<String, FirebasePhotoReference>? photos;
  final ScrollPhysics physics;
  final bool autoPlay;
  final bool Function()? shouldSkip;
  final IndicatorBuilder? indicatorBuilder;
  final Widget idleChild;
  final bool scrollAware;
  final bool precacheSurroundingPhotos;
  final bool precacheThumbnailsInstead;
  final Size Function(FirebasePhotoReference photo)? getCacheSize;
  final MultiPhotoCarouselStyle style;
  final Duration autoPlayAnimationDuration;
  final List<Widget> children;
  final Widget Function(BuildContext context, FirebasePhotoReference photo)? uniqueIdleChildBuilder;
  final bool inherit;
  final bool paintInheritedAnimations;
  final bool wrapInheritBoundary;

  @override
  MultiPhotoCarouselState createState() => MultiPhotoCarouselState();
}

class MultiPhotoCarouselState extends State<MultiPhotoCarousel> with InitialDependencies<MultiPhotoCarousel> {
  final _carouselKey = GlobalKey<CarouselSliderState>();
  final _periodicChildSwicherKey = GlobalKey<PeriodicChildSwitcherBuilderState>();

  late final RefreshStorageEntry<_Storage> _storage;
  late List<FirebasePhotoReference> _photos;
  bool get isDraggable => widget.style == MultiPhotoCarouselStyle.draggable;

  Size _getCacheSize(FirebasePhotoReference photo, Size? constraints) =>
      FirebaseImage.getCacheSize(photo.size, (widget.getCacheSize?.call(photo) ?? constraints)!);

  FirebaseImage? _getImageProvider(FirebasePhotoReference? photo, [Size? constraints]) =>
      photo?.getImage(_getCacheSize(photo, constraints));

  int getPage() =>
      (!isDraggable ? _periodicChildSwicherKey.currentState?.index : _carouselKey.currentState?.currentPage.round()) ??
      0;

  /// Precaches the next image.
  void _handlePageChange(int page) {
    _storage.value?.lastPage = page;

    if (widget.precacheSurroundingPhotos) {
      assert(
        widget.getCacheSize != null,
        'External cache size must be set, because the page change can\'t be handled without the layout\'s constraints',
      );

      if (_photos.isNotEmpty) {
        assert(page < _photos.length);
        final nextPage = (page + 1) == _photos.length ? 0 : page + 1;
        final previousPage = (page - 1) < 0 ? _photos.length - 1 : page - 1;
        final photos = [
          if (previousPage != page && isDraggable) _photos[previousPage],
          if (nextPage != page) _photos[nextPage],
        ];

        for (final photo in photos) {
          final imageProvider = _getImageProvider(photo);
          final isCached = imageProvider != null
              ? PaintingBinding.instance!.imageCache!.containsKey(imageProvider) ||
                  (widget.precacheThumbnailsInstead
                      ? PaintingBinding.instance!.imageCache!.containsKey(imageProvider.thumbnail)
                      : false)
              : true;

          if (!isCached) {
            precacheImage(widget.precacheThumbnailsInstead ? imageProvider!.thumbnail : imageProvider!, context);
          }
        }
      }
    }
  }

  @override
  void initState() {
    _photos = widget.photos?.values.toList(growable: false) ?? const <FirebasePhotoReference>[];
    _storage = RefreshStorage.write<_Storage>(
      context: context,
      identifier: '${widget.bucket}_multi_photo_carousel',
      builder: () => _Storage(lastPage: widget.initialPage),
    );

    super.initState();
  }

  @override
  void initDependencies() {
    // Precache the next image.
    AwaitRoute.of(context).then((_) => mounted ? _handlePageChange(_storage.value?.lastPage ?? 0) : null);
  }

  @override
  void didUpdateWidget(covariant MultiPhotoCarousel oldWidget) {
    if (!mapEquals(oldWidget.photos, widget.photos))
      _photos = widget.photos?.values.toList(growable: false) ?? const <FirebasePhotoReference>[];
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _storage.dispose();
    super.dispose();
  }

  Widget _buildPhoto(BuildContext context, int index, [Size? constraints]) {
    assert(constraints != null || widget.getCacheSize != null);

    final photo = _photos.length > index ? _photos[index] : null;
    Widget child = SwitchingFirebaseImage(
      scrollAware: widget.scrollAware,
      imageProvider: _getImageProvider(photo, constraints),
      inherit: widget.inherit,
      paintInheritedAnimations: widget.paintInheritedAnimations,
      idleChild: widget.uniqueIdleChildBuilder != null && photo != null
          ? widget.uniqueIdleChildBuilder!(context, photo)
          : widget.idleChild,
    );

    switch (widget.style) {
      case MultiPhotoCarouselStyle.draggable:
      case MultiPhotoCarouselStyle.periodicallySwitched:
        child = widget.inherit ? InheritedAnimationBuilder(wrapTranslation: true, child: child) : child;
        break;
      case MultiPhotoCarouselStyle.periodicallySwitchedImage:
        break;
    }

    return widget.wrap?.call(context, photo, child) ?? child;
  }

  Widget _buildLayout(BuildContext context, [BoxConstraints? constraints]) {
    assert(constraints != null || widget.getCacheSize != null);

    final itemCount = math.max(_photos.length, 1);

    const autoPlayInterval = Duration(seconds: 20);
    const autoPlayPauseDuration = Duration(seconds: 10);

    switch (widget.style) {
      case MultiPhotoCarouselStyle.draggable:
        return CarouselSlider(
          key: _carouselKey,
          initialPage: _storage.value?.lastPage ?? widget.initialPage,
          height: double.infinity,
          scrollDirection: Axis.horizontal,
          enableInfiniteScroll: itemCount > 1,
          autoPlayCurve: standardEasing,
          autoPlayInterval: autoPlayInterval,
          pauseAutoPlayOnTouch: autoPlayPauseDuration,
          autoPlayAnimationDuration: widget.autoPlayAnimationDuration,
          scrollPhysics: itemCount > 1 ? widget.physics : const NeverScrollableScrollPhysics(),
          autoPlay: widget.autoPlay ? itemCount > 1 : false,
          shouldSkip: widget.shouldSkip,
          indicatorBuilder: widget.indicatorBuilder,
          onPageChanged: _handlePageChange,
          itemCount: itemCount,
          itemBuilder: (context, i) => _buildPhoto(context, i, constraints?.biggest),
          children: widget.children,
          inherit: widget.inherit,
          paintInheritedAnimations: widget.paintInheritedAnimations,
          wrapInheritBoundary: widget.wrapInheritBoundary,
        );
      case MultiPhotoCarouselStyle.periodicallySwitched:
        return PeriodicChildSwitcher(
          builderKey: _periodicChildSwicherKey,
          autoPlay: widget.autoPlay,
          initialIndex: _storage.value?.lastPage ?? widget.initialPage,
          childBuilder: (context, i) => _buildPhoto(context, i, constraints?.biggest),
          fillColor: Theme.of(context).colorScheme.background,
          childCount: _photos.length,
          shouldSkip: widget.shouldSkip,
          autoPlayInterval: autoPlayInterval,
          onChildChanged: _handlePageChange,
          axis: Axis.horizontal,
          inherit: widget.inherit,
          paintInheritedAnimations: widget.paintInheritedAnimations,
          wrapInheritBoundary: widget.wrapInheritBoundary,
        );
      case MultiPhotoCarouselStyle.periodicallySwitchedImage:
        return PeriodicChildSwitcherBuilder(
          key: _periodicChildSwicherKey,
          autoPlay: widget.autoPlay,
          initialIndex: _storage.value?.lastPage ?? widget.initialPage,
          builder: (context, i) => _buildPhoto(context, i, constraints?.biggest),
          childCount: _photos.length,
          shouldSkip: widget.shouldSkip,
          autoPlayInterval: autoPlayInterval,
          onChildChanged: _handlePageChange,
        );
    }
  }

  @override
  Widget build(BuildContext context) =>
      widget.getCacheSize != null ? _buildLayout(context) : LayoutBuilder(builder: _buildLayout);
}
