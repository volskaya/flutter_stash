import 'dart:collection';

import 'package:chip_text_form_field/src/editable_chip.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ChipTextFormFieldChipBuilder = Widget Function(
  BuildContext context,
  GlobalKey<EditableChipState> key,
  TextEditingController controller,
  VoidCallback addChip,
  VoidCallback removeChip,
  VoidCallback loseFocus,
);

typedef ChipTextFormFieldAddCallback = Future<String> Function(BuildContext context, List<String> value);

/// Material text form field of chips that can convert into editable texts, when tapped.
class ChipTextFormField extends FormField<List<String>> {
  /// Creates [ChipTextFormField].
  ChipTextFormField({
    Key key,
    String labelText,
    String helperText,
    FormFieldSetter<List<String>> onSaved,
    FormFieldValidator<List<String>> validator,
    ValueChanged<List<String>> onChanged,
    List<String> initialValue = const <String>[],
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool enabled = true,
    InputDecoration decoration,
    int max,
    ChipTextFormFieldChipBuilder chipBuilder,
    ChipTextFormFieldAddCallback onAddPresed,
    bool allowUserInput = true,
  })  : assert((max ?? 1) >= 1),
        super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          enabled: enabled,
          builder: (state) => _Widget(
            state: state,
            labelText: labelText,
            helperText: helperText,
            inputDecoration: decoration,
            onChanged: onChanged,
            max: max,
            chipBuilder: chipBuilder,
            onAddPressed: onAddPresed,
            allowUserInput: allowUserInput,
          ),
        );
}

class _Widget extends StatefulWidget {
  const _Widget({
    Key key,
    @required this.state,
    this.chipBuilder,
    this.labelText,
    this.helperText,
    this.inputDecoration,
    this.onChanged,
    this.max,
    this.onAddPressed,
    this.allowUserInput = true,
  }) : super(key: key);

  final FormFieldState<List<String>> state;
  final ChipTextFormFieldChipBuilder chipBuilder;
  final String labelText;
  final String helperText;
  final InputDecoration inputDecoration;
  final ValueChanged<List<String>> onChanged;
  final int max;
  final ChipTextFormFieldAddCallback onAddPressed;
  final bool allowUserInput;

  @override
  ChipTextFormFieldWidgetState createState() => ChipTextFormFieldWidgetState();
}

/// [State] of [ChipTextFormField] widget.
class ChipTextFormFieldWidgetState extends State<_Widget> {
  final _scrollController = ScrollController();
  final _items = <GlobalKey<EditableChipState>>[];
  final _controllers = HashMap<GlobalKey<EditableChipState>, TextEditingController>();
  final _focuses = HashMap<GlobalKey<EditableChipState>, bool>();

  bool _isFocused = false;
  bool get _isEmpty => _items.isEmpty;
  bool get _maxReached => widget.max != null ? _items.length >= widget.max : false;

  void _handleChange() {
    final value = _controllers.values.map((controller) => controller.text).toList(growable: false);
    assert(value.length <= widget.max);
    widget.state.didChange(value);
    widget.onChanged?.call(value);
  }

  void _handleFieldTap() {
    assert(widget.allowUserInput);
    if (_items.isEmpty) {
      addChip(); // FIXME: Allow disabling this behavior.
    } else if (_items.last.currentState?.controller?.text?.isEmpty == true) {
      _items.last.currentState?.focusNode?.requestFocus();
    } else {
      // If a chip is empty and without focus, it is deleted.
      // Spawn a new chip, when tapping the input field without
      // any focused chips.
      for (final item in _items) {
        if (item.currentState?.focusNode?.hasFocus == true) {
          // _log.v('Focus node has focus, not reacting to tap');
          item.currentState?.requestKeyboard();
          return;
        }
      }

      if (!_maxReached) addChip();
    }
  }

  void _checkIsFocused() {
    var isFocused = false;
    for (final state in _focuses.values) {
      if (state) {
        isFocused = true;
        break;
      }
    }
    if (_isFocused != isFocused) setState(() => _isFocused = isFocused);
  }

  /// Add a new chip to the form field with [initialValue].
  void addChip([String initialValue]) {
    setState(() {
      assert(!_maxReached, 'Adding too many chips');
      final key = GlobalKey<EditableChipState>();
      _items.add(key);
      _controllers[key] = TextEditingController(text: initialValue ?? '');

      // Focus change animates the [EditableChip] from text field to a chip.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        key.currentState?.focusNode?.requestFocus();

        // Focus node listener to handle focused state of the input decoration.
        key.currentState?.focusNode?.addListener(() {
          final hasFocus = key.currentState?.focusNode?.hasFocus ?? false;
          if (hasFocus != _focuses[key]) {
            _focuses[key] = hasFocus;
            _checkIsFocused();
          }
        });

        // Value controller to notify change to the state.
        key.currentState?.controller?.addListener(_handleChange);
        _handleChange();

        // Needs another frame for the correct scroll extent.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          // NOTE: Duration and Curve copied from [EditableText] _caretAnimation...
          // FIXME: Doesn't work, if the chips use size animation.
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: standardEasing,
          );
        });
      });
    });

    // Outside of `setState`.
    // _handleChange();
  }

  /// NOTE: Removing key must also remove the editable field.
  void _removeChip(GlobalKey key, {bool touchState = true}) {
    _items.remove(key);
    _controllers.remove(key);

    // NOTE: `_removeChip` is called from dispose.
    if (touchState) _handleChange();
  }

  @override
  void initState() {
    widget.state.value.forEach(addChip);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    while (_items.isNotEmpty) {
      _removeChip(_items.last, touchState: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final suffixIconCallback = !_maxReached
        ? widget.onAddPressed != null
            ? () async {
                final value = await widget.onAddPressed(context, widget.state.value);
                if (value != null && mounted) addChip(value);
              }
            : addChip
        : null;
    final suffixIcon = IconButton(
      icon: const Icon(Icons.add),
      onPressed: suffixIconCallback,
    );

    final container = SizedBox(
      height: 72,
      child: InputDecorator(
        isFocused: _isFocused,
        isEmpty: _isEmpty,
        child: ClipRect(
          child: SizedBox(
            height: double.infinity,
            child: CustomScrollView(
              clipBehavior: Clip.none,
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              // Compensate for the edge of chip container, so the [EditableText]
              // can be mounted and handle scrollview scrolling, when typing.
              cacheExtent: 64, // FIXME: Doesn't work.
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    List<Widget>.generate(
                      _items.length,
                      (index) {
                        final key = _items[index];
                        return Padding(
                          key: ObjectKey(key),
                          padding: EdgeInsets.only(
                            left: index != 0 ? 4.0 : 0.0,
                            right: index != _items.length - 1 ? 4.0 : 0.0,
                          ),
                          child: widget.chipBuilder?.call(
                                context,
                                key,
                                _controllers[key],
                                addChip,
                                () => _removeChip(key),
                                () => (key.currentState?.controller?.text?.trim() ?? '').isEmpty
                                    ? _removeChip(key)
                                    : null,
                              ) ??
                              EditableChip(
                                key: key,
                                controller: _controllers[key],
                                onBreakPoint: addChip,
                                onDeleted: () => _removeChip(key),
                                onFocusLost: () => (key.currentState?.controller?.text?.trim() ?? '').isEmpty
                                    ? _removeChip(key)
                                    : null,
                              ),
                        );
                      },
                      growable: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        decoration: widget.inputDecoration?.copyWith(
              errorText: widget.state.hasError ? widget.state.errorText : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              suffixIcon: suffixIcon,
            ) ??
            InputDecoration(
              errorText: widget.state.hasError ? widget.state.errorText : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              suffixIcon: suffixIcon,
            ),
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.allowUserInput ? _handleFieldTap : suffixIconCallback,
      child: container,
    );
  }
}
