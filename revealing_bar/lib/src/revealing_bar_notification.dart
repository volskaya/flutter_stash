import 'package:freezed_annotation/freezed_annotation.dart';

part 'revealing_bar_notification.freezed.dart';

/// Notification sent out by [RevealingBarNotifier] to [RevealingBarController]s.
@freezed
class RevealingBarNotification with _$RevealingBarNotification {
  const factory RevealingBarNotification({
    required double maxExtent,
    double? localOffset,
    double? remoteOffset,
  }) = _RevealingBarNotification;
}
