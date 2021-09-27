import 'package:flutter/widgets.dart';

typedef CollectionAttachmentCoordinatorBuilder = Widget
    Function(int index, int position, CollectionAttachmentCoordinator coordinator);

@immutable
class CollectionAttachmentCoordinator {
  CollectionAttachmentCoordinator({
    required this.offset,
    required this.spacing,
    required CollectionAttachmentCoordinatorBuilder attachmentBuilder,
    required CollectionAttachmentCoordinatorBuilder builder,
    bool enabled = true,
  })  : _attachmentBuilder = attachmentBuilder,
        _builder = builder,
        _preferEnabled = enabled;

  static bool globalToggle = true;

  final int offset;
  final int spacing;
  final CollectionAttachmentCoordinatorBuilder _builder;
  final CollectionAttachmentCoordinatorBuilder _attachmentBuilder;
  final bool _preferEnabled;

  bool get enabled => _preferEnabled && globalToggle;

  /// Get the lists child count factoring in attachments.
  int childCount(int length) {
    assert(offset >= 0 && offset <= spacing);
    if (!enabled) return length;
    final wrappedOffset = -offset % (spacing + 1);
    final offsetLength =
        wrappedOffset == spacing || (offset <= length && length < spacing && wrappedOffset > length) ? 1 : 0;
    return length + length ~/ spacing + offsetLength;
  }

  /// Get the index of an original list item factoring in attachments.
  int childIndex(int i) => i - (i + 1) ~/ spacing;

  /// Return true, if this `i` should belong to an attachment widget.
  bool isAttachmentPosition(int i) {
    assert(offset >= 0 && offset <= spacing);
    if (!enabled) return false;

    final pageLength = spacing + 1;
    final wrappedOffset = -offset % pageLength;
    final position = i + 1 + wrappedOffset;

    return (position % pageLength) == 0;
  }

  /// Child builder that shows attachments every [offset] items or returns null,
  /// if no attachment needs to be built at this index.
  Widget? maybeBuild(int i) {
    assert(offset >= 0 && offset <= spacing);
    if (!enabled) return null;

    final pageLength = spacing + 1;
    final wrappedOffset = -offset % pageLength;
    final position = i + 1 + wrappedOffset;
    final attachmentIndex = position ~/ pageLength;

    return (position % pageLength) == 0 ? _attachmentBuilder(i, attachmentIndex - 1, this) : null;
  }

  /// Child builder that shows attachment widgets every [offset]
  /// items or builds a regular widget.
  Widget build(BuildContext _, int i) {
    if (!enabled) return _builder(i, i, this);

    final pageLength = spacing + 1;
    final wrappedOffset = -offset % pageLength;
    final position = i + 1 + wrappedOffset;
    final attachmentIndex = position ~/ pageLength;

    return (position % pageLength) == 0
        ? _attachmentBuilder(i, attachmentIndex - 1, this)
        : _builder(i, i - attachmentIndex, this);
  }
}
