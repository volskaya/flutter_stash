import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:material_dialog/src/material_dialog_attachment_delegate.dart';
import 'package:material_dialog/src/material_dialog_box.dart';
import 'package:material_dialog/src/material_dialog_divider.dart';
import 'package:refresh_storage/refresh_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MaterialDialogSimpleContainer extends StatelessWidget {
  const MaterialDialogSimpleContainer({
    Key key,
    @required this.text,
    this.buttons = const <Widget>[],
  }) : super(key: key);

  final Widget text;
  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialDialogContainer(
      buttons: buttons,
      content: Padding(
        padding: const EdgeInsets.all(24),
        child: DefaultTextStyle(
          child: text,
          style: theme.textTheme.bodyText1,
        ),
      ),
    );
  }
}

class MaterialDialogContainer extends StatelessWidget {
  const MaterialDialogContainer({
    Key key,
    @required this.content,
    this.title,
    this.buttons = const <Widget>[],
    this.overlapsContent = false,
    this.showFullWidth = false,
    this.showFullHeight = false,
    this.attachment,
  }) : super(key: key);

  final Widget title;
  final List<Widget> buttons;
  final Widget content;
  final bool overlapsContent;
  final bool showFullWidth;
  final bool showFullHeight;
  final MaterialDialogAttachmentDelegate attachment;

  static ShapeBorder shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0)));

  // Constraints taken from the material design spec.
  static const constraintsPortrait = BoxConstraints(maxWidth: 280, maxHeight: 560);
  static const constraintsLandscape = BoxConstraints(maxWidth: 560, maxHeight: 560);

  static Future<bool> askQuestion(
    BuildContext context, {
    @required String question,
    String cancelText,
    String continueText,
    Color continueTextColor,
  }) =>
      showModal<bool>(
        context: context,
        builder: (context) {
          final strings = MaterialLocalizations.of(context);
          return MaterialDialogSimpleContainer(
            text: Text(question),
            buttons: [
              TextButton(
                child: Text(cancelText ?? strings.cancelButtonLabel ?? 'CANCEL', layoutTwice: true),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text(continueText ?? strings.continueButtonLabel ?? 'CONTINUE', layoutTwice: true),
                onPressed: () => Navigator.pop(context, true),
                style: continueTextColor != null ? TextButton.styleFrom(primary: continueTextColor) : null,
              ),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    BoxConstraints constraints;
    Color headerBackgroundColor;
    Color headerTextColor;

    switch (mediaQuery.orientation) {
      case Orientation.portrait:
        constraints = BoxConstraints(
          maxHeight: !showFullHeight ? constraintsPortrait.maxHeight : double.infinity,
          maxWidth: !showFullWidth ? constraintsPortrait.maxWidth : double.infinity,
        );
        break;
      case Orientation.landscape:
        constraints = BoxConstraints(
          maxHeight: !showFullHeight ? constraintsLandscape.maxHeight : double.infinity,
          maxWidth: !showFullWidth ? constraintsLandscape.maxWidth : double.infinity,
        );
        break;
    }

    switch (theme.brightness) {
      case Brightness.dark:
        headerBackgroundColor = theme.colorScheme.background;
        headerTextColor = theme.colorScheme.onBackground;
        break;
      case Brightness.light:
        headerBackgroundColor = theme.colorScheme.background;
        headerTextColor = theme.colorScheme.onBackground;
        break;
    }

    final footer = buttons.isNotEmpty
        ? ColoredBox(
            color: theme.colorScheme.background,
            child: ButtonBar(children: buttons),
          )
        : null;
    final header = title != null
        ? ColoredBox(
            color: headerBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: DefaultTextStyle(
                  child: title,
                  style: theme.textTheme.headline6.apply(color: headerTextColor),
                ),
              ),
            ),
          )
        : null;

    final material = ConstrainedBox(
      constraints: constraints,
      child: Material(
        color: theme.colorScheme.background,
        elevation: 24,
        shape: MaterialDialogContainer.shape,
        clipBehavior: Clip.antiAlias,
        child: MaterialDialogBox(
          orientation: mediaQuery.orientation,
          header: header,
          content: content,
          footer: footer,
          divider: MaterialDialogDivider(
            padding: EdgeInsets.zero,
            width: 1,
            axis: Axis.values[mediaQuery.orientation.index],
            color: theme.dividerColor,
          ),
        ),
      ),
    );

    final body = attachment?.widget != null
        ? MaterialDialogAttachmentContainer(
            child: material,
            attachment: RefreshStorage.wrapProvider(
              state: attachment.storage,
              child: attachment.widget,
            ),
          )
        : material;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0) + mediaQuery.padding,
        child: body,
      ),
    );
  }
}

class MaterialDialogAttachmentContainer extends StatelessWidget {
  const MaterialDialogAttachmentContainer({
    Key key,
    @required this.attachment,
    @required this.child,
  }) : super(key: key);

  final Widget child;
  final Widget attachment;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final mediaQuery = MediaQuery.of(context);
          switch (mediaQuery.orientation) {
            case Orientation.portrait:
              const aspectRatioCap = 7 / 9; // Paper aspect ratio.
              return mediaQuery.size.aspectRatio > aspectRatioCap
                  ? child
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RepaintBoundary(child: attachment),
                        Flexible(child: RepaintBoundary(child: child)),
                      ],
                    );
            case Orientation.landscape:
              return mediaQuery.size.width < MaterialDialogContainer.constraintsLandscape.maxWidth
                  ? child
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RepaintBoundary(child: attachment),
                        Flexible(child: RepaintBoundary(child: child)),
                      ],
                    );
            default:
              throw UnimplementedError();
          }
        },
      );
}
