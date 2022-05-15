import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefreshCounterPod extends StateNotifier<int> {
  RefreshCounterPod() : super(0);

  static void refreshContext(BuildContext context) =>
      ProviderScope.containerOf(context).read(RefreshCounterPod.provider.notifier).refresh();

  static final provider = StateNotifierProvider<RefreshCounterPod, int>(
    (_) => RefreshCounterPod(),
    name: 'RefreshCounterPod',
  );

  static final providerFamily = StateNotifierProvider.family<RefreshCounterPod, int, dynamic>(
    (_, dynamic __) => RefreshCounterPod(),
    name: 'RefreshCounterPod',
  );

  int refresh() => state += 1;
}
