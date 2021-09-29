// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:animations/src/animations.dart';
import 'package:animations/src/compound_transition_animation/compound_transition_animation.dart';
import 'package:animations/src/compound_transition_animation/dual_transition_animation.dart';
import 'package:animations/src/dual_transition_animation_builder.dart';
import 'package:animations/src/inherited_animation/inherited_animation_wrap.dart';
import 'package:flutter/material.dart' hide decelerateEasing; // ignore: undefined_hidden_name
import 'package:flutter/src/material/curves.dart'; // ignore: implementation_imports

import 'modal.dart';

/// The modal transition configuration for a Material fade transition.
///
/// The fade pattern is used for UI elements that enter or exit from within
/// the screen bounds. Elements that enter use a quick fade in and scale from
/// 80% to 100%. Elements that exit simply fade out. The scale animation is
/// only applied to entering elements to emphasize new content over old.
///
/// ```dart
/// /// Sample widget that uses [showModal] with [FadeScaleTransitionConfiguration].
/// class MyHomePage extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: ElevatedButton(
///           onPressed: () {
///             showModal(
///               context: context,
///               configuration: FadeScaleTransitionConfiguration(),
///               builder: (BuildContext context) {
///                 return _CenteredFlutterLogo();
///               },
///             );
///           },
///           child: Icon(Icons.add),
///         ),
///       ),
///     );
///   }
/// }
///
/// /// Displays a centered Flutter logo with size constraints.
/// class _CenteredFlutterLogo extends StatelessWidget {
///   const _CenteredFlutterLogo();
///
///   @override
///   Widget build(BuildContext context) {
///     return Center(
///       child: SizedBox(
///         width: 250,
///         height: 250,
///         child: const Material(
///           child: Center(
///             child: FlutterLogo(size: 250),
///           ),
///         ),
///       ),
///     );
///   }
/// }
/// ```
class FadeScaleTransitionConfiguration extends ModalConfiguration {
  /// Creates the Material fade transition configuration.
  ///
  /// [barrierDismissible] configures whether or not tapping the modal's
  /// scrim dismisses the modal. [barrierLabel] sets the semantic label for
  /// a dismissible barrier. [barrierDismissible] cannot be null. If
  /// [barrierDismissible] is true, the [barrierLabel] cannot be null.
  const FadeScaleTransitionConfiguration({
    Color barrierColor = Colors.black54,
    bool barrierDismissible = true,
    Duration transitionDuration = const Duration(milliseconds: 250),
    Duration reverseTransitionDuration = const Duration(milliseconds: 200),
    String barrierLabel = 'Dismiss',
  }) : super(
          barrierColor: barrierColor,
          barrierDismissible: barrierDismissible,
          barrierLabel: barrierLabel,
          transitionDuration: transitionDuration,
          reverseTransitionDuration: reverseTransitionDuration,
        );

  @override
  Widget transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeScaleTransition(
      animation: animation,
      child: child,
      inherit: true,
      paintInheritedAnimations: true,
    );
  }
}

/// A widget that implements the Material fade transition.
///
/// The fade pattern is used for UI elements that enter or exit from within
/// the screen bounds. Elements that enter use a quick fade in and scale from
/// 80% to 100%. Elements that exit simply fade out. The scale animation is
/// only applied to entering elements to emphasize new content over old.
///
/// This widget is not to be confused with Flutter's [FadeTransition] widget,
/// which animates only the opacity of its child widget.
class FadeScaleTransition extends StatelessWidget {
  /// Creates a widget that implements the Material fade transition.
  ///
  /// The fade pattern is used for UI elements that enter or exit from within
  /// the screen bounds. Elements that enter use a quick fade in and scale from
  /// 80% to 100%. Elements that exit simply fade out. The scale animation is
  /// only applied to entering elements to emphasize new content over old.
  ///
  /// This widget is not to be confused with Flutter's [FadeTransition] widget,
  /// which animates only the opacity of its child widget.
  ///
  /// [animation] is typically an [AnimationController] that drives the transition
  /// animation. [animation] cannot be null.
  const FadeScaleTransition({
    Key? key,
    required this.animation,
    required this.child,
    this.sliver = false,
    this.inherit = false,
    this.paintInheritedAnimations = false,
  })  : assert(!paintInheritedAnimations || inherit),
        super(key: key);

  /// The animation that drives the [child]'s entrance and exit.
  ///
  /// See also:
  ///
  ///  * [TransitionRoute.animate], which is the value given to this property
  ///    when it is used as a page transition.
  final Animation<double> animation;

  /// The widget below this widget in the tree.
  ///
  /// This widget will transition in and out as driven by [animation] and
  /// [secondaryAnimation].
  final Widget child;

  /// Whether to use sliver variants of animation widgets.
  final bool sliver;

  /// Whether to defer the animations to [InheritedAnimationCoordinator].
  final bool inherit;

  /// Whether to paint any deferred animations before the child.
  final bool paintInheritedAnimations;

  static final Animatable<double> _fadeInTransition = CurveTween(curve: const Interval(0.0, 0.3));
  static final Animatable<double> _scaleInTransition =
      Tween<double>(begin: 0.8, end: 1.0).chain(CurveTween(curve: decelerateEasing));
  static final Animatable<double> _fadeOutTransition = Tween<double>(begin: 1.0, end: 0.0);

  @override
  Widget build(BuildContext context) {
    final child = paintInheritedAnimations
        ? InheritedAnimationWrap(
            child: this.child,
            opacity: true,
            scale: true,
          )
        : this.child;

    return DualTransitionAnimationBuilder(
      child: child,
      animation: animation,
      getAnimations: (animation, secondaryAnimation) => [
        DualTransitionAnimation<double>(
          compound: CompoundTransitionAnimation.compoundOpacity,
          animation: CompoundTransitionAnimation<double>(
              compound: CompoundTransitionAnimation.compoundOpacity,
              animation: animation,
              forwardAnimatable: _fadeInTransition,
              reverseAnimatable: _fadeOutTransition),
        ),
        DualTransitionAnimation<double>(
          compound: CompoundTransitionAnimation.compoundScale,
          animation: CompoundTransitionAnimation<double>(
            compound: CompoundTransitionAnimation.compoundScale,
            animation: animation,
            forwardAnimatable: _scaleInTransition,
          ),
        ),
      ],
      builder: (context, animations, child) => Animations.scale(
        scale: animations[1] as DualTransitionAnimation<double>,
        sliver: sliver,
        inherit: inherit,
        child: Animations.fade(
          opacity: animations[0] as DualTransitionAnimation<double>,
          sliver: sliver,
          inherit: inherit,
          child: child,
        ),
      ),
    );
  }
}
