import 'package:fancy_switcher/fancy_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Material chip that builds a text field, while it has focus.
class EditableChip extends StatefulWidget {
  /// Creates [EditableChip].
  const EditableChip({
    Key key,
    this.controller,
    this.focusNode,
    this.hasError = false,
    this.avatar,
    this.breakPoint = ',',
    this.onDeleted,
    this.onBreakPoint,
    this.onFocusLost,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.label,
  }) : super(key: key);

  /// Chip `label` override. While this is null, value defaults to the [TextEditingController.value].
  final Widget label;

  /// Overrides internal [TextEditingController].
  final TextEditingController controller;

  /// Overrides internal [FocusNode].
  final FocusNode focusNode;

  /// Whether to highligh the chip like an error.
  final bool hasError;

  /// Chip avatar.
  final Widget avatar;

  /// Breakpoint character, which, when detected, will automatically close the chip.
  final String breakPoint;

  /// Called when the chip delete button got pressed.
  final VoidCallback onDeleted;

  /// Called when the input field detected the [breakPoint] character.
  final VoidCallback onBreakPoint;

  /// Called when the focus is lost.
  final VoidCallback onFocusLost;

  /// Called when the chip is tapped.
  final VoidCallback onTap;

  /// Called when the text field is submitted.
  final ValueChanged<String> onSubmitted;

  /// Whether to allow editing this chip.
  final bool readOnly;

  @override
  EditableChipState createState() => EditableChipState();
}

/// [State] of [EditableChip].
class EditableChipState extends State<EditableChip> with TickerProviderStateMixin<EditableChip> {
  final _editableTextKey = GlobalKey<EditableTextState>();
  bool _editing = true;

  /// Internal [TextEditingController] of [EditableChip].
  TextEditingController controller;

  /// Internal [FocusNode] of [EditableChip].
  FocusNode focusNode;

  /// Calls `requestKeyboard` of the internal [EditableText].
  void requestKeyboard() => _editableTextKey.currentState?.requestKeyboard();

  void _handleEditableChanged(String val) {
    final value = val.split('');
    if (value.removeLast() == widget.breakPoint) {
      // _log.d('Breakpoint detected, spawn chip with previous value');
      widget.onBreakPoint?.call();
      controller.text = value.join('');
    }
  }

  void _ensureSelection() {
    if (controller.text.isNotEmpty) {
      controller.selection = controller.selection.copyWith(
        baseOffset: 0,
        extentOffset: controller.text.length,
      );
    }
  }

  void _handleFocusNodeChange() {
    if (!focusNode.hasFocus && _editing) {
      // Focus dropped, hide editable.
      setState(() {
        _editing = false;
        controller.text = controller.text.trim();
      });
      widget.onFocusLost?.call();
    } else if (focusNode.hasFocus && !_editing) {
      // Focus acquired, turn the chip into an editable.
      setState(() => _editing = true);
      _ensureSelection();
    }
  }

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    focusNode = (widget.focusNode ?? FocusNode())..addListener(_handleFocusNodeChange);

    // If an initial value was used, don't spawn the chip in an editable state.
    _editing = controller.text.isEmpty;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.removeListener(_handleFocusNodeChange);

    // Only disposed, if they weren't passed trough the widget props.
    if (widget.focusNode == null) focusNode.dispose();
    if (widget.controller == null) controller.dispose();
  }

  Widget _buildEditable(ThemeData theme) => TextField(
        key: _editableTextKey,
        style: theme.textTheme.subtitle1,
        focusNode: focusNode,
        controller: controller,
        maxLines: 1,
        onChanged: _handleEditableChanged,
        onSubmitted: widget.onSubmitted,
        readOnly: widget.readOnly,
        forceLine: false,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        decoration: null,
      );

  Widget _buildChip(ThemeData theme) => InputChip(
        key: const ValueKey(false),
        showCheckmark: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        label: widget.label ??
            AnimatedBuilder(
              animation: controller,
              builder: (_, __) => Text(controller.text),
            ),
        onDeleted: widget.onDeleted,
        onPressed: !widget.readOnly
            ? () => setState(() {
                  _editing = true;
                  _ensureSelection();

                  // Switcher hasn't built the input field, at this point.
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) focusNode.requestFocus();
                  });
                })
            : null,
        avatar: widget.avatar != null
            ? SizedBox.expand(
                child: Material(
                  type: MaterialType.circle,
                  color: theme.dividerColor,
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: IconTheme.merge(
                      data: const IconThemeData(size: 12),
                      child: widget.avatar,
                    ),
                  ),
                ),
              )
            : null,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 32, // Material chip height.
      child: RepaintBoundary(
        child: AnimatedSize(
          vsync: this,
          alignment: Alignment.centerLeft,
          clipBehavior: Clip.none,
          duration: const Duration(milliseconds: 250),
          curve: standardEasing,
          child: AnimatedBuilder(
            animation: focusNode,
            builder: (_, __) => FancySwitcher(
              alignment: Alignment.centerLeft,
              child: _editing || focusNode.hasFocus ? _buildEditable(theme) : _buildChip(theme),
            ),
          ),
        ),
      ),
    );
  }
}
