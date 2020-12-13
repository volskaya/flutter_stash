import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';

/// Scaffold wrap of [EncapsulatedScaffold].
typedef EncapsulatedScaffoldCustomBuilder = Widget Function(BuildContext context, Scaffold scaffold);

/// Route aware capsule for [Scaffold] which exposes convenience methods for
/// easier deep links and reactions to created scaffolds troughout the app.
class EncapsulatedScaffold extends StatefulWidget {
  /// Creates [EncapsulatedScaffold].
  const EncapsulatedScaffold({
    Key key,
    this.scaffoldKey,
    this.appBar,
    this.bottomNavigationBar,
    this.body,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
    this.customBuilder,
    this.bottomInset = 0,
  }) : super(key: key);

  /// Optional key of the inner scaffold.
  final GlobalKey<ScaffoldState> scaffoldKey;

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget appBar;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  ///
  /// Snack bars slide from underneath the bottom navigation bar while bottom
  /// sheets are stacked on top.
  ///
  /// The [bottomNavigationBar] is rendered below the [persistentFooterButtons]
  /// and the [body].
  final Widget bottomNavigationBar;

  /// The primary content of the scaffold.
  ///
  /// Displayed below the [appBar], above the bottom of the ambient
  /// [MediaQuery]'s [MediaQueryData.viewInsets], and behind the
  /// [floatingActionButton] and [drawer]. If [resizeToAvoidBottomInset] is
  /// false then the body is not resized when the onscreen keyboard appears,
  /// i.e. it is not inset by `viewInsets.bottom`.
  ///
  /// The widget in the body of the scaffold is positioned at the top-left of
  /// the available space between the app bar and the bottom of the scaffold. To
  /// center this widget instead, consider putting it in a [Center] widget and
  /// having that be the body. To expand this widget instead, consider
  /// putting it in a [SizedBox.expand].
  ///
  /// If you have a column of widgets that should normally fit on the screen,
  /// but may overflow and would in such cases need to scroll, consider using a
  /// [ListView] as the body of the scaffold. This is also a good choice for
  /// the case where your body is a scrollable list.
  final Widget body;

  /// If true, and [bottomNavigationBar] or [persistentFooterButtons]
  /// is specified, then the [body] extends to the bottom of the Scaffold,
  /// instead of only extending to the top of the [bottomNavigationBar]
  /// or the [persistentFooterButtons].
  ///
  /// If true, a [MediaQuery] widget whose bottom padding matches the height
  /// of the [bottomNavigationBar] will be added above the scaffold's [body].
  ///
  /// This property is often useful when the [bottomNavigationBar] has
  /// a non-rectangular shape, like [CircularNotchedRectangle], which
  /// adds a [FloatingActionButton] sized notch to the top edge of the bar.
  /// In this case specifying `extendBody: true` ensures that that scaffold's
  /// body will be visible through the bottom navigation bar's notch.
  ///
  /// See also:
  ///
  ///  * [extendBodyBehindAppBar], which extends the height of the body
  ///    to the top of the scaffold.
  final bool extendBody;

  /// If true, and an [appBar] is specified, then the height of the [body] is
  /// extended to include the height of the app bar and the top of the body
  /// is aligned with the top of the app bar.
  ///
  /// This is useful if the app bar's [AppBar.backgroundColor] is not
  /// completely opaque.
  ///
  /// This property is false by default. It must not be null.
  ///
  /// See also:
  ///
  ///  * [extendBody], which extends the height of the body to the bottom
  ///    of the scaffold.
  final bool extendBodyBehindAppBar;

  /// Responsible for determining where the [floatingActionButton] should go.
  ///
  /// If null, the [ScaffoldState] will use the default location, [FloatingActionButtonLocation.endFloat].
  final FloatingActionButtonLocation floatingActionButtonLocation;

  /// A button displayed floating above [body], in the bottom right corner.
  ///
  /// Typically a [FloatingActionButton].
  final Widget floatingActionButton;

  /// If true the [body] and the scaffold's floating widgets should size
  /// themselves to avoid the onscreen keyboard whose height is defined by the
  /// ambient [MediaQuery]'s [MediaQueryData.viewInsets] `bottom` property.
  ///
  /// For example, if there is an onscreen keyboard displayed above the
  /// scaffold, the body can be resized to avoid overlapping the keyboard, which
  /// prevents widgets inside the body from being obscured by the keyboard.
  ///
  /// Defaults to true.
  final bool resizeToAvoidBottomInset;

  /// Optional builder which passess [Scaffold] as child.
  final EncapsulatedScaffoldCustomBuilder customBuilder;

  /// The height of the navigation bar. This will inset encapsulated notifications, when the
  /// scaffold is in foreground.
  final double bottomInset;

  @override
  EncapsulatedScaffoldState createState() => EncapsulatedScaffoldState();
}

/// Public state of [EncapsulatedScaffold].
///
/// [EncapsulatedScaffold] is added/removed from [EncapsulatedScaffoldStore] as
/// it's built or destroyed.
class EncapsulatedScaffoldState extends State<EncapsulatedScaffold> {
  /// User defined bottom inset of this scaffold. Usually the height of the navigation bar.
  double get bottomInset => widget.bottomInset;

  EncapsulatedScaffoldStore _store;
  bool _capsuleWasUpdated = false;

  @override
  void initState() {
    _store = EncapsulatedScaffoldStore.of(context);
    _capsuleWasUpdated = _store.capsules.add(this);
    super.initState();
  }

  @override
  void dispose() {
    _detatchCapsule();
    super.dispose();
  }

  void _detatchCapsule() {
    if (_capsuleWasUpdated) {
      final removed = _store.capsules.remove(this);
      if (removed) _capsuleWasUpdated = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      key: widget.scaffoldKey,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      extendBody: widget.extendBody,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButton: widget.floatingActionButton,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      bottomNavigationBar: widget.bottomNavigationBar,
      appBar: widget.appBar,
      body: widget.body,
    );

    return WillPopScope(
      onWillPop: () async {
        // Remove the capsule early so the observers can react as before the route animation.
        _detatchCapsule();
        return true;
      },
      child: widget.customBuilder?.call(context, scaffold) ?? scaffold,
    );
  }
}
