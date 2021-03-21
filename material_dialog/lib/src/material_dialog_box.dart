import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';

const _kHeaderHeight = 64.0;
const _kFooterHeight = 52.0;
const _kLandscapeHeaderWidth = 168.0;

/// Lays out a material design dialog, with header & footer being panited
/// after the content.
class MaterialDialogBox extends StatelessWidget {
  const MaterialDialogBox({
    Key? key,
    required this.content,
    this.header,
    this.footer,
    this.orientation = Orientation.portrait,
    this.divider,
  }) : super(key: key);

  final Widget content;
  final Widget? header;
  final Widget? footer;
  final Orientation orientation;
  final Widget? divider;

  @override
  Widget build(BuildContext context) => CustomBoxy(
        delegate: _Delegate(
          orientation,
          divider,
          showFooter: footer != null,
          showHeader: header != null,
        ),
        children: [
          LayoutId(id: 'content', child: content),
          if (footer != null) LayoutId(id: 'footer', child: footer!),
          if (header != null) LayoutId(id: 'header', child: header!),
        ],
      );
}

class _Delegate extends BoxyDelegate {
  _Delegate(
    this.orientation,
    this.dividerWidget, {
    this.showFooter = false,
    this.showHeader = false,
  });

  final Orientation orientation;
  final Widget? dividerWidget;
  final bool showFooter;
  final bool showHeader;

  @override
  Size layout() {
    final content = getChild('content')!;
    final header = showHeader ? getChild('header') : null;
    final footer = showFooter ? getChild('footer') : null;

    switch (orientation) {
      case Orientation.portrait:
        final contentConstraints = constraints.copyWith(
          minHeight: 0.0,
          maxHeight:
              constraints.maxHeight - (header != null ? _kHeaderHeight : 0.0) - (footer != null ? _kFooterHeight : 0.0),
        );
        final contentSize = content.layout(contentConstraints);
        content.position(Offset(0, header != null ? _kHeaderHeight : 0.0));

        final showDividers = contentSize.height >= contentConstraints.maxHeight && dividerWidget != null;

        if (showDividers) {
          if (footer != null) inflate(dividerWidget!, id: 'footerDivider');
          if (header != null) inflate(dividerWidget!, id: 'headerDivider');
        }

        final headerDivider = getChild('headerDivider');
        final footerDivider = getChild('footerDivider');

        if (footerDivider != null && footer != null) {
          footerDivider.layout(constraints.copyWith(maxHeight: 1, minHeight: 1));
          footerDivider.position(Offset(0.0, content.rect.bottom));
        }

        if (footer != null) {
          footer.layout(constraints.copyWith(maxHeight: _kFooterHeight, minHeight: _kFooterHeight));
          footer.position(Offset(0.0, content.rect.bottom));
        }

        if (header != null) {
          header.layout(constraints.copyWith(maxHeight: _kHeaderHeight, minHeight: _kHeaderHeight));
          header.position(Offset.zero);
        }

        if (headerDivider != null && header != null) {
          headerDivider.layout(constraints.copyWith(maxHeight: 1, minHeight: 1));
          headerDivider.position(const Offset(0.0, _kHeaderHeight - 1.0));
        }

        return Size(
          constraints.maxWidth,
          contentSize.height + (header != null ? _kHeaderHeight : 0.0) + (footer != null ? _kFooterHeight : 0.0),
        );
      case Orientation.landscape:
        final headerWidth = header != null ? _kLandscapeHeaderWidth : 0.0;
        final contentWidth = constraints.maxWidth - headerWidth;

        final contentConstraints = constraints.copyWith(
          minWidth: contentWidth,
          maxWidth: contentWidth,
          minHeight: _kHeaderHeight,
          maxHeight: constraints.maxHeight - (footer != null ? _kFooterHeight : 0.0),
        );

        final contentSize = content.layout(contentConstraints);
        content.position(Offset(headerWidth, 0.0));

        final showDividers = contentSize.height >= contentConstraints.maxHeight && dividerWidget != null;

        // Header divider is always used, since it's vertical.
        if (header != null && dividerWidget != null) inflate(dividerWidget!, id: 'headerDivider');
        if (showDividers && footer != null) inflate(dividerWidget!, id: 'footerDivider');

        final headerDivider = getChild('headerDivider');
        final footerDivider = getChild('footerDivider');

        final headerConstraints = constraints.copyWith(
          minWidth: headerWidth,
          maxWidth: headerWidth,
          minHeight: _kHeaderHeight,
          maxHeight: contentSize.height + (footer != null ? _kFooterHeight : 0.0),
        );

        if (footerDivider != null && footer != null) {
          footerDivider.layout(contentConstraints.copyWith(maxHeight: 1, minHeight: 1));
          footerDivider.position(Offset(headerWidth, content.rect.bottom));
        }

        if (footer != null) {
          footer.layout(contentConstraints.copyWith(maxHeight: _kFooterHeight, minHeight: _kFooterHeight));
          footer.position(Offset(headerWidth, content.rect.bottom));
        }

        if (header != null) {
          header.layout(headerConstraints);
          header.position(Offset.zero);
        }

        if (headerDivider != null && header != null) {
          final headerDividerSize = headerDivider.layout(constraints.copyWith(maxWidth: 1, minWidth: 1));
          headerDivider.position(Offset(headerWidth - headerDividerSize.width, 0.0));
        }

        return Size(
          constraints.maxWidth,
          contentSize.height + (footer != null ? _kFooterHeight : 0.0),
        );
    }
  }

  @override
  bool shouldRelayout(_Delegate old) =>
      old.orientation != orientation || old.showFooter != showFooter || old.showHeader || showHeader;
}
