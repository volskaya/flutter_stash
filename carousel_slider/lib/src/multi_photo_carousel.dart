import 'dart:math' as math;

import 'package:await_route/await_route.dart';
import 'package:carousel_slider/src/carousel_slider.dart';
import 'package:carousel_slider/src/periodic_child_switcher.dart';
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
    this.scrollable = true,
    this.autoPlayAnimationDuration = const Duration(milliseconds: 600),
    this.children = const <Widget>[],
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
  final bool scrollable;
  final Duration autoPlayAnimationDuration;
  final List<Widget> children;

  @override
  MultiPhotoCarouselState createState() => MultiPhotoCarouselState();
}

class MultiPhotoCarouselState extends State<MultiPhotoCarousel> with InitialDependencies<MultiPhotoCarousel> {
  final _carouselKey = GlobalKey<CarouselSliderState>();
  final _periodicChildSwicherKey = GlobalKey<PeriodicChildSwitcherState>();

  late final RefreshStorageEntry<_Storage> _storage;
  late List<FirebasePhotoReference> _photos;

  Size _getCacheSize(FirebasePhotoReference photo, Size? constraints) =>
      FirebaseImage.getCacheSize(photo.size, (widget.getCacheSize?.call(photo) ?? constraints)!);

  FirebaseImage? _getImageProvider(FirebasePhotoReference? photo, [Size? constraints]) =>
      photo?.getImage(_getCacheSize(photo, constraints));

  int getPage() =>
      (!widget.scrollable
          ? _periodicChildSwicherKey.currentState?.index
          : _carouselKey.currentState?.currentPage.round()) ??
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
          if (previousPage != page && widget.scrollable) _photos[previousPage],
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
      identifier: 'multi_photo_carousel_${widget.bucket}',
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

  Widget _buildPhoto(BuildContext context, int index, Size constraints) {
    final photo = _photos.length > index ? _photos[index] : null;
    final child = SwitchingFirebaseImage(
      idleChild: widget.idleChild,
      imageProvider: _getImageProvider(photo, constraints),
      scrollAware: widget.scrollAware,
    );

    return widget.wrap?.call(context, photo, child) ?? child;
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final itemCount = math.max(_photos.length, 1);
          final refresh = RefreshController.of(context)?.refresh ?? 0;

          const autoPlayInterval = Duration(seconds: 20);
          const autoPlayPauseDuration = Duration(seconds: 10);

          if (!widget.scrollable) {
            return PeriodicChildSwitcher(
              key: _periodicChildSwicherKey,
              autoPlay: widget.autoPlay,
              initialIndex: _storage.value?.lastPage ?? widget.initialPage,
              childBuilder: (context, i) => _buildPhoto(context, i, constraints.biggest),
              fillColor: Theme.of(context).colorScheme.background,
              childCount: _photos.length,
              shouldSkip: widget.shouldSkip,
              autoPlayInterval: autoPlayInterval,
              onChildChanged: _handlePageChange,
              axis: Axis.horizontal,
            );
          }

          return CarouselSlider(
            key: _carouselKey,
            pageStorageKey: widget.bucket != null ? PageStorageKey<String>('$refresh-${widget.bucket}') : null,
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
            itemBuilder: (context, i) => _buildPhoto(context, i, constraints.biggest),
            children: widget.children,
          );
        },
      );
}
