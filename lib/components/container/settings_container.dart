import 'package:airstat/components/container/values_container.dart';
import 'package:airstat/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsContainer extends ConsumerWidget {
  final String category;
  const SettingsContainer({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.watch(
      category == "General Sampling"
          ? generalSamplingProvider.notifier
          : category == "Silhouette / Vents Sampling"
              ? silhouetteSamplingProvider.notifier
              : category == "General Delay"
                  ? generalDelayProvider.notifier
                  : silhouetteDelayProvider.notifier,
    );
    final settingsState = ref.watch(
      category == "General Sampling"
          ? generalSamplingProvider
          : category == "Silhouette / Vents Sampling"
              ? silhouetteSamplingProvider
              : category == "General Delay"
                  ? generalDelayProvider
                  : silhouetteDelayProvider,
    );
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
              for (var value in ['1', '5', '10', '20'])
                ContainerValues(
                  value: value,
                  state: settingsState,
                  notifier: settingsNotifier,
                ),
            ],
          )
        ],
      ),
    );
  }
}
