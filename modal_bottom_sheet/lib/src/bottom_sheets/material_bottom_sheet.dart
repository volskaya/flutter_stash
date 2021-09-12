import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:async';

/// Shows a modal material design bottom sheet.
Future<T?> showMaterialModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  double? closeProgressThreshold,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color? barrierColor,
  bool bounce = false,
  bool expand = false,
  Curve? animationCurve,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Duration? duration,
  ModalBottomSheetStateCallback<T>? onInitialized,
  ModalBottomSheetStateCallback<T>? onDisposed,
}) {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    ModalBottomSheetRoute<T>(
      builder: builder,
      closeProgressThreshold: closeProgressThreshold,
      bounce: bounce,
      expanded: expand,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor,
      enableDrag: enableDrag,
      animationCurve: animationCurve,
      duration: duration,
      onInitialized: onInitialized,
      onDisposed: onDisposed,
      containerBuilder: _materialContainerBuilder(
        context,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
      ),
    ),
  );
}

/// Default container builder is the Material Appearance.
ModalBottomSheetContainerBuilder _materialContainerBuilder(
  BuildContext context, {
  Color? backgroundColor,
  double? elevation,
  Clip? clipBehavior,
  ShapeBorder? shape,
}) {
  final bottomSheetTheme = Theme.of(context).bottomSheetTheme;
  final color = backgroundColor ?? bottomSheetTheme.modalBackgroundColor ?? bottomSheetTheme.backgroundColor;
  final _elevation = elevation ?? bottomSheetTheme.elevation ?? 0.0;
  final _shape = shape ?? bottomSheetTheme.shape;
  final _clipBehavior = clipBehavior ?? bottomSheetTheme.clipBehavior ?? Clip.none;

  return (context, animation, child) => Material(
        color: color,
        elevation: _elevation,
        shape: _shape,
        clipBehavior: _clipBehavior,
        child: child,
      );
}
