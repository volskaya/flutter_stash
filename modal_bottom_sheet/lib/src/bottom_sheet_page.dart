import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/src/bottom_sheet.dart';
import 'package:modal_bottom_sheet/src/bottom_sheet_route.dart';

class ModalBottomSheetPage extends Page {
  const ModalBottomSheetPage({
    LocalKey? key,
    required this.containerBuilder,
    required this.builder,
    this.expanded = false,
  }) : super(key: key);

  final ModalBottomSheetContainerBuilder containerBuilder;
  final WidgetBuilder builder;
  final bool expanded;

  @override
  Route createRoute(BuildContext context) => ModalBottomSheetRoute(
        expanded: expanded,
        settings: this,
        containerBuilder: containerBuilder,
        builder: builder,
      );
}
