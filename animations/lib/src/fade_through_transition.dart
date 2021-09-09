// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:animations/src/animations.dart';
import 'package:animations/src/inherited_animation/inherited_animation.dart';
import 'package:flutter/material.dart';

// TODO(shihaohong): Remove DualTransitionBuilder once flutter/flutter's `stable`
// branch contains DualTransitionBuilder.
import 'dual_transition_builder.dart' as dual_transition_builder;

/// Used by [PageTransitionsTheme] to define a page route transition animation
/// in which the outgoing page fades out, then the incoming page fades in and
/// scale up.
///
/// This pattern is recommended for a transition between UI elements that do not
/// have a strong relationship to one another.
///
/// Scale is only applied to incoming elements to emphasize new content over
/// old.
///
/// The following example shows how the FadeThroughPageTransitionsBuilder can
/// be used in a [PageTransitionsTheme] to change the default transitions
/// of [MaterialPageRoute]s.
///
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     pageTransitionsTheme: PageTransitionsTheme(
///       builders: {
///         TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
///         TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(),
///       },
///     ),
///   ),
///   routes: {
///     '/': (BuildContext context) {
///       return Container(
///         color: Colors.red,
///         child: Center(
///           child: TextButton(
///             child: Text('Push route'),
///             onPressed: () {
///               Navigator.of(context).pushNamed('/a');
///             },
///           ),
///         ),
///       );
///     },
///     '/a' : (BuildContext context) {
///       return Container(
///         color: Colors.blue,
///         child: Center(
///           child: TextButton(
///             child: Text('Pop route'),
///             onPressed: () {
///               Navigator.of(context).pop();
///             },
///           ),
///         ),
///       );
///     },
///   },
/// );
/// ```
class FadeThroughPageTransitionsBuilder extends PageTransitionsBuilder {
  /// Creates a [FadeThroughPageTransitionsBuilder].
  const FadeThroughPageTransitionsBuilder({this.fillColor});

  /// The color to use for the background color during the transition.
  ///
  /// This defaults to the [Theme]'s [ThemeData.colorScheme.background].
  final Color? fillColor;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeThroughTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      fillColor: fillColor,
      child: child,
      inherit: true,
      paintInheritedAnimations: true,
    );
  }
}

/// Defines a transition in which outgoing elements fade out, then incoming
/// elements fade in and scale up.
///
/// The fade through pattern provides a transition animation between UI elements
/// that do not have a strong relationship to one another. As an example, the
/// [BottomNavigationBar] may use this animation to transition the currently
/// displayed content when a new [BottomNavigationBarItem] is selected.
///
/// Scale is only applied to incoming elements to emphasize new content over
/// old.
///
/// Consider using [FadeThroughPageTransitionsBuilder] within a
/// [PageTransitionsTheme] if you want to apply this kind of transition to
/// [MaterialPageRoute] transitions within a Navigator (see
/// [FadeThroughPageTransitionsBuilder] for some example code). Or use this transition
/// directly in a [PageTransitionSwitcher.transitionBuilder] to transition
/// from one widget to another as seen in the following example:
///
/// ```dart
///  int _selectedIndex = 0;
///
///  final List<Color> _colors = [Colors.blue, Colors.red, Colors.yellow];
///
///  @override
///  Widget build(BuildContext context) {
///    return Scaffold(
///      appBar: AppBar(
///        title: const Text('Switcher Sample'),
///      ),
///      body: PageTransitionSwitcher(
///        transitionBuilder: (
///          Widget child,
///          Animation<double> primaryAnimation,
///          Animation<double> secondaryAnimation,
///        ) {
///          return FadeThroughTransition(
///            child: child,
///            animation: primaryAnimation,
///            secondaryAnimation: secondaryAnimation,
///          );
///        },
///        child: Container(
///          key: ValueKey<int>(_selectedIndex),
///          color: _colors[_selectedIndex],
///        ),
///      ),
///      bottomNavigationBar: BottomNavigationBar(
///        items: const <BottomNavigationBarItem>[
///          BottomNavigationBarItem(
///            icon: Icon(Icons.home),
///            title: Text('Blue'),
///          ),
///          BottomNavigationBarItem(
///            icon: Icon(Icons.business),
///            title: Text('Red'),
///          ),
///          BottomNavigationBarItem(
///            icon: Icon(Icons.school),
///            title: Text('Yellow'),
///          ),
///        ],
///        currentIndex: _selectedIndex,
///        selectedItemColor: Colors.amber[800],
///        onTap: (int index) {
///          setState(() {
///            _selectedIndex = index;
///          });
///        },
///      ),
///    );
///  }
/// ```
class FadeThroughTransition extends StatelessWidget {
  /// Creates a [FadeThroughTransition].
  ///
  /// The [animation] and [secondaryAnimation] argument are required and must
  /// not be null.
  const FadeThroughTransition({
    Key? key,
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
    this.fillColor,
    this.onEnd,
    this.onStatusChanged,
    this.sliver = false,
    this.inherit = false,
    this.paintInheritedAnimations = false,
  })  : assert(!paintInheritedAnimations || inherit),
        super(key: key);

  /// Callback to be called when the animation ends.
  final VoidCallback? onEnd;

  /// Callback when the animation status changes.
  final ValueChanged<AnimationStatus>? onStatusChanged;

  /// The animation that drives the [child]'s entrance and exit.
  ///
  /// See also:
  ///
  ///  * [TransitionRoute.animate], which is the value given to this property
  ///    when the [FadeThroughTransition] is used as a page transition.
  final Animation<double> animation;

  /// The animation that transitions [child] when new content is pushed on top
  /// of it.
  ///
  /// See also:
  ///
  ///  * [TransitionRoute.secondaryAnimation], which is the value given to this
  //     property when the [FadeThroughTransition] is used as a page transition.
  final Animation<double> secondaryAnimation;

  /// The color to use for the background color during the transition.
  ///
  /// This defaults to the [Theme]'s [ThemeData.canvasColor].
  final Color? fillColor;

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

  @override
  Widget build(BuildContext context) {
    final Color fillColor = this.fillColor ?? Theme.of(context).colorScheme.background;

    Widget child = paintInheritedAnimations
        ? InheritedAnimation(
            fillColor: fillColor,
            child: this.child,
            opacity: true,
            scale: true,
          )
        : this.child;

    Widget _widget = _ZoomedFadeInFadeOut(
      animation: ReverseAnimation(secondaryAnimation),
      child: child,
      onEnd: onEnd,
      sliver: sliver,
      inherit: inherit,
    );

    if (!inherit && fillColor != Colors.transparent) {
      _widget = ColoredBox(color: fillColor, child: _widget);
    }

    return _ZoomedFadeInFadeOut(
      animation: animation,
      child: _widget,
      onEnd: onEnd,
      sliver: sliver,
      inherit: inherit,
    );
  }
}

class _ZoomedFadeInFadeOut extends StatelessWidget {
  const _ZoomedFadeInFadeOut({
    Key? key,
    required this.animation,
    required this.child,
    this.onEnd,
    this.onStatusChanged,
    this.sliver = false,
    this.inherit = false,
  }) : super(key: key);

  final Animation<double> animation;
  final Widget child;
  final VoidCallback? onEnd;
  final ValueChanged<AnimationStatus>? onStatusChanged;
  final bool sliver;
  final bool inherit;

  @override
  Widget build(BuildContext context) => dual_transition_builder.DualTransitionBuilder(
        animation: animation,
        onEnd: onEnd,
        onStatusChanged: onStatusChanged,
        forwardBuilder: (BuildContext context, Animation<double> animation, Widget child) => _ZoomedFadeIn(
          animation: animation,
          child: child,
          sliver: sliver,
          inherit: inherit,
        ),
        reverseBuilder: (BuildContext context, Animation<double> animation, Widget child) => _FadeOut(
          child: child,
          animation: animation,
          sliver: sliver,
          inherit: inherit,
        ),
        child: child,
      );
}

class _ZoomedFadeIn extends StatelessWidget {
  const _ZoomedFadeIn({
    required this.child,
    required this.animation,
    this.sliver = false,
    this.inherit = false,
  });

  final Widget child;
  final Animation<double> animation;
  final bool sliver;
  final bool inherit;

  static final CurveTween _inCurve = CurveTween(
    curve: const Cubic(0.0, 0.0, 0.2, 1.0),
  );
  static final TweenSequence<double> _scaleIn = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(0.92),
        weight: 6 / 20,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.92, end: 1.0).chain(_inCurve),
        weight: 14 / 20,
      ),
    ],
  );
  static final TweenSequence<double> _fadeInOpacity = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(0.0),
        weight: 6 / 20,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(_inCurve),
        weight: 14 / 20,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) => Animations.fade(
        opacity: _fadeInOpacity.animate(animation),
        sliver: sliver,
        inherit: inherit,
        child: Animations.scale(
          scale: _scaleIn.animate(animation),
          child: child,
          sliver: sliver,
          inherit: inherit,
        ),
      );
}

class _FadeOut extends StatelessWidget {
  const _FadeOut({
    required this.child,
    required this.animation,
    this.sliver = false,
    this.inherit = false,
  });

  final Widget child;
  final Animation<double> animation;
  final bool sliver;
  final bool inherit;

  static final CurveTween _outCurve = CurveTween(
    curve: const Cubic(0.4, 0.0, 1.0, 1.0),
  );
  static final TweenSequence<double> _fadeOutOpacity = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(_outCurve),
        weight: 6 / 20,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(0.0),
        weight: 14 / 20,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) => Animations.fade(
        opacity: _fadeOutOpacity.animate(animation),
        child: child,
        sliver: sliver,
        inherit: inherit,
      );
}
