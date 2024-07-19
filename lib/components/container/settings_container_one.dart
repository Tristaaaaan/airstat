import 'package:airstat/components/container/values_container.dart';
import 'package:airstat/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsContainerOne extends ConsumerWidget {
  final String category;
  const SettingsContainerOne({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.watch(unitsProvider.notifier);
    final settingsState = ref.watch(unitsProvider);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: const TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ContainerValues(
                value: "Manage space definitions",
                state: settingsState,
                notifier: settingsNotifier,
                width: 315,
              ),
            ],
          )
        ],
      ),
    );
  }
}