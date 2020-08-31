import 'package:flutter/material.dart';
import 'package:encapsulated_scaffold/src/encapsulated_scaffold_store.dart';

typedef EncapsulatedScaffoldCustomBuilder = Widget Function(BuildContext context, Scaffold scaffold);

/// Base class to extend for [EncapsulatedScaffoldData] data.
abstract class EncapsulatedScaffoldDataBase {
  /// Creates [EncapsulatedScaffoldDataBase].
  const EncapsulatedScaffoldDataBase();
}

/// Route aware capsule for [Scaffold] which exposes convenience methods for
/// easier deep links and reactions to created scaffolds troughout the app.
class EncapsulatedScaffold extends StatefulWidget {
  /// Creates [EncapsulatedScaffold].
  const EncapsulatedScaffold({
    Key key,
    this.scaffoldKey,
    this.tag,
    this.appBar,
    this.bottomNavigationBar,
    this.body,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
    this.cargo,
    this.customBuilder,
  }) : super(key: key);

  /// Optional key of the inner scaffold.
  final GlobalKey<ScaffoldState> scaffoldKey;

  /// Optional [EncapsulatedScaffoldTag] tag.
  ///
  /// Defaults to named ruote name.
  final String tag;

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

  /// Optional cargo to conveniently reference elsewhere in the code, trough
  /// [EncapsulatedScaffoldState].
  final dynamic cargo;

  /// Optional builder which passess [Scaffold] as child.
  final EncapsulatedScaffoldCustomBuilder customBuilder;

  /// Get arguments from [ModalRoute] as [T].
  static T dataOf<T>(BuildContext context) => ModalRoute.of(context).settings.arguments as T;

  @override
  EncapsulatedScaffoldState createState() => EncapsulatedScaffoldState<EncapsulatedScaffoldDataBase>();
}

/// Public state of [EncapsulatedScaffold].
///
/// [EncapsulatedScaffold] is added/removed from [EncapsulatedScaffoldStore] as
/// it's built or destroyed.
class EncapsulatedScaffoldState<T extends EncapsulatedScaffoldDataBase> extends State<EncapsulatedScaffold> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  EncapsulatedScaffoldStore _store;

  /// [ModalRoute] where this [EncapsulatedScaffoldState] is built in.
  ModalRoute route;

  /// [ScaffoldState] of [Scaffold] built by this [EncapsulatedScaffold].
  ScaffoldState get scaffold => (widget.scaffoldKey ?? _scaffoldKey).currentState;
  bool _capsuleWasUpdated = false;

  /// Cargo of [EncapsulatedScaffold] that built this [EncapsulatedScaffoldState].
  dynamic get cargo => widget.cargo;

  /// [EncapsulatedScaffold] tag or named route name, if tag is not set.
  String get tag => widget.tag ?? route.settings.name;

  /// [EncapsulatedScaffoldState] arguments. Cast as [T].
  T get arguments {
    if (route?.settings?.arguments == null) return null;
    assert(
      route.settings.arguments is T,
      'Encapsulated scaffold route holds unrecognized data',
    );
    return route.settings.arguments as T;
  }

  @override
  void initState() {
    _store = EncapsulatedScaffoldStore.of<T>(context);

    // Defer to a post frame callback, to ensure route is ready, when
    // the _store.capsule observer fires
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      route = ModalRoute.of(context);
      _store.capsules.add(this);
      _capsuleWasUpdated = true;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_capsuleWasUpdated) _store.capsules.remove(this);
  }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      key: widget.scaffoldKey ?? _scaffoldKey,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      extendBody: widget.extendBody,
      appBar: widget.appBar,
      body: widget.body,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButton: widget.floatingActionButton,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
    );
    return widget.customBuilder?.call(context, scaffold) ?? scaffold;
  }
}
