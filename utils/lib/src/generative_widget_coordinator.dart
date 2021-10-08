import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utils/src/collection_attachment_coordinator.dart';

part 'generative_widget_coordinator.freezed.dart';

typedef GenerativeWidgetCoordinatorPaginatedBuilder = Widget
    Function(int index, int position, CollectionAttachmentCoordinator? attachmentCoordinator);

typedef GenerativeWidgetCoordinatorSubscribedBuilder = Widget Function(int index, int position);

@freezed
class GenerativeWidgetCoordinatorAttachment with _$GenerativeWidgetCoordinatorAttachment {
  const factory GenerativeWidgetCoordinatorAttachment({
    required int offset,
    required int spacing,
    required bool enabled,
    required GenerativeWidgetCoordinatorPaginatedBuilder builder,
  }) = _GenerativeWidgetCoordinatorAttachment;

  const GenerativeWidgetCoordinatorAttachment._();
}

@freezed
class GenerativeWidgetCoordinatorBuilders with _$GenerativeWidgetCoordinatorBuilders {
  const factory GenerativeWidgetCoordinatorBuilders({
    required GenerativeWidgetCoordinatorPaginatedBuilder paginated,
    GenerativeWidgetCoordinatorSubscribedBuilder? subscribed,
    GenerativeWidgetCoordinatorAttachment? attachment,
  }) = _GenerativeWidgetCoordinatorBuilders;
}

class GenerativeWidgetCoordinator {
  GenerativeWidgetCoordinator({required this.builders})
      : attachmentCoordinator = builders.attachment != null
            ? CollectionAttachmentCoordinator(
                builder: builders.paginated,
                attachmentBuilder: builders.attachment!.builder,
                offset: builders.attachment!.offset,
                spacing: builders.attachment!.spacing,
                enabled: builders.attachment!.enabled,
              )
            : null;

  final GenerativeWidgetCoordinatorBuilders builders;
  final CollectionAttachmentCoordinator? attachmentCoordinator;

  final paginatedWidgets = <Widget>[];
  final subscribedWidgets = <Widget>[];

  int attachments = 0;

  Widget preparePaginatedWidget(int position) {
    assert(position <= paginatedWidgets.length, '$position < ${paginatedWidgets.length}');

    // Build widgets until no attachment is built.
    while (true) {
      final effectivePosition = position + attachments;
      final attachment = attachmentCoordinator?.maybeBuild(effectivePosition);

      if (attachment != null) {
        attachments += 1;
        paginatedWidgets.add(attachment);
      } else {
        return builders.paginated(effectivePosition, position, attachmentCoordinator)..addTo(paginatedWidgets);
      }
    }
  }

  void prepareSubscribedWidget(int position) {
    assert(builders.subscribed == null || position < subscribedWidgets.length);
    builders.subscribed?.call(position, position).addTo(subscribedWidgets);
  }

  void moveSubscribedWidgetsToPaginated() {
    paginatedWidgets.insertAll(0, subscribedWidgets);
    subscribedWidgets.clear();
  }
}

extension _BuilderExtension on Widget {
  void addTo(List<Widget> widgets) => widgets.add(this);
}
