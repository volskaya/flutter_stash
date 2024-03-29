import 'package:flutter/material.dart';

extension CorrectedMediaQueryData on MediaQueryData {
  EdgeInsets get horizontalPadding => EdgeInsets.only(left: padding.left, right: padding.right);
}

/// Assume any bottom inset below [CorrectedMediaQuery.keyboardHeightRatioHeuristic] to
/// not be a keyboard and move its size to regular padding.
///
/// This happens when the bottom navigation first reports its bottom inset, didnt observe
/// it happening to other sides.
///
/// After the initial inset is reported, on any other report the flutter engine moves
/// the inset to to padding by itself.
class CorrectedMediaQuery extends StatelessWidget {
  const CorrectedMediaQuery({
    Key? key,
    required this.child,
    this.onBuild,
  }) : super(key: key);

  /// Constant form the same `keyboardHeightRatioHeuristic` in the Flutter engine.
  static const keyboardHeightRatioHeuristic = 0.18;

  final Widget child;
  final ValueChanged<MediaQueryData>? onBuild;

  static bool isKeyboardHeightAboveRatioHeuristic(MediaQueryData mediaQuery) =>
      mediaQuery.viewInsets.bottom > (mediaQuery.size.height * keyboardHeightRatioHeuristic);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    if (!isKeyboardHeightAboveRatioHeuristic(mediaQuery)) {
      mediaQuery = mediaQuery.copyWith(
        padding: mediaQuery.padding + EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        viewPadding: mediaQuery.viewPadding + EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        viewInsets: mediaQuery.viewInsets.copyWith(bottom: 0.0),
      );
    }

    // Some code might want to perform some quick operation on these data.
    onBuild?.call(mediaQuery);

    return MediaQuery(
      data: mediaQuery,
      child: child,
    );
  }
}
