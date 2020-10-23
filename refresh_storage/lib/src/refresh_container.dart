import 'package:flutter/material.dart';
import 'package:refresh_storage/src/refresh_builder.dart';

/// Wrapper around [RefreshBuilder] & provider of [RefreshController], which holds
/// the counter of refreshes.
///
/// Wrap this around scrollables, to add a pull to refresh behavior to the
/// scroll view.
class RefreshContainer extends StatelessWidget {
  /// Creates the [RefreshContainer] without the support for [NestedScrollView].
  const RefreshContainer({
    Key key,
    @required this.child,
    @required this.bucket,
    this.enforceSafeArea = false,
  })  : _wrappedAroundNestedScrollview = false,
        super(key: key);

  /// Creates the [RefreshContainer] with support for [NestedScrollView].
  const RefreshContainer.nested({
    Key key,
    @required this.child,
    @required this.bucket,
    this.enforceSafeArea = false,
  })  : _wrappedAroundNestedScrollview = true,
        super(key: key);

  /// Transform the refresh indicator under the top safe area.
  final bool enforceSafeArea;

  /// Child should contain a scrollable, which will controll the scroll
  /// indicator in [RefreshContainer].
  // final Widget child;
  final Widget child;

  /// Page storage identifier, where this widget will preserve its refresh
  /// counter state.
  final String bucket;

  final bool _wrappedAroundNestedScrollview;

  @override
  Widget build(BuildContext context) => _wrappedAroundNestedScrollview
      ? RefreshBuilder.nested(
          builder: (_, __) => child,
          enforceSafeArea: enforceSafeArea,
          bucket: bucket,
        )
      : RefreshBuilder(
          builder: (_, __) => child,
          enforceSafeArea: enforceSafeArea,
          bucket: bucket,
        );
}
