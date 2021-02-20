library utils;

import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'src/mixins.dart';

export 'src/country_catalog.dart';
export 'src/custom_ink_splash.dart';
export 'src/debounce.dart';
export 'src/exit_guard.dart';
export 'src/mark_storage.dart';
export 'src/mutex.dart';
export 'src/observable_keep_aliver.dart';
export 'src/page_controller_value_listenable.dart';
export 'src/range_tween.dart';
export 'src/scroll_controller_toggle.dart';
export 'src/storage_upload.dart';
export 'src/enums.dart';
export 'src/mixins.dart';
export 'src/converters.dart';
export 'src/format.dart';

abstract class Utils {
  static int androidSdkVersion;
  static PictureInPictureObserver pictureInPictureObserver;

  static double clampAspectRatio(double aspectRatio) => aspectRatio.clamp(9 / 16, 16 / 9).toDouble();

  static bool isPictureInPicture(MediaQueryData mediaQuery) {
    assert(androidSdkVersion != null && pictureInPictureObserver != null);

    if ((androidSdkVersion ?? 0) < 24) {
      return false; // Not supported;
    } else if (androidSdkVersion > 26) {
      // Above api 26 the PIP window is set to be a square. So using the window size,
      // since it will be updated faster than the method channel event.
      return nearEqual(mediaQuery.size.aspectRatio, 1.0, Tolerance.defaultTolerance.distance);
    } else {
      return pictureInPictureObserver?.isInPictureInPictureMode ?? false;
    }
  }

  static bool isScrolled(ScrollController controller, [double offset = 0]) =>
      // ignore:invalid_use_of_protected_member
      controller.positions.length == 1 ? controller.offset > offset : false;

  static Future<Duration> awaitPostframe() async {
    final completer = Completer<Duration>();
    WidgetsBinding.instance.addPostFrameCallback(completer.complete);
    return completer.future;
  }

  static String encodeStorageTrailingProps(Map<String, dynamic> props) {
    final str = json.encode(props);
    final bytes = utf8.encode(str);
    final base = base64.encode(bytes);
    return Uri.encodeComponent(base);
  }

  static List<Widget> sliverChildrenWithSafeArea(
    Iterable<Widget> children, {
    bool top = true,
    bool bottom = true,
  }) =>
      [
        if (top) const SliverSafeArea(bottom: false, sliver: SliverPadding(padding: EdgeInsets.zero)),
        ...children,
        if (bottom) const SliverSafeArea(top: false, sliver: SliverPadding(padding: EdgeInsets.zero)),
      ];

  /// The app has 2 navigators. Make sure [WillPopScope] doesn't
  /// stand in the root navigator's way.
  static Future<bool> protectRootNavigator(BuildContext context, FutureOr<bool> Function() callback) async {
    final rootNavigator = Navigator.of(context, rootNavigator: true);

    if (rootNavigator?.canPop() == true) {
      rootNavigator.pop();
      return false;
    }

    return await callback();
  }

  static const platformViewGestures = <Factory<OneSequenceGestureRecognizer>>{};

  static Widget buildAndroidPlatformView(
    Map<String, dynamic> params,
    String viewType, [
    bool useHybridComposition = false,
    void Function(int) onPlatformViewCreated,
  ]) =>
      !useHybridComposition
          ? RepaintBoundary(
              child: AndroidView(
                viewType: viewType,
                clipBehavior: Clip.none,
                creationParamsCodec: const StandardMessageCodec(),
                creationParams: params,
                gestureRecognizers: platformViewGestures,
                onPlatformViewCreated: onPlatformViewCreated,
              ),
            )
          : PlatformViewLink(
              viewType: viewType,
              surfaceFactory: (context, controller) => AndroidViewSurface(
                controller: controller as AndroidViewController,
                gestureRecognizers: platformViewGestures,
                hitTestBehavior: PlatformViewHitTestBehavior.opaque,
              ),
              onCreatePlatformView: (PlatformViewCreationParams p) => PlatformViewsService.initSurfaceAndroidView(
                id: p.id,
                viewType: viewType,
                layoutDirection: ui.TextDirection.ltr,
                creationParams: params,
                creationParamsCodec: const StandardMessageCodec(),
              )
                ..addOnPlatformViewCreatedListener((v) {
                  p.onPlatformViewCreated(v);
                  onPlatformViewCreated?.call(v);
                })
                ..create(),
            );
}
