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
              ContainerValues(
                value: "1",
                state: settingsState,
                notifier: settingsNotifier,
              ),
              const SizedBox(
                width: 5,
              ),
              ContainerValues(
                value: "5",
                state: settingsState,
                notifier: settingsNotifier,
              ),
              const SizedBox(
                width: 5,
              ),
              ContainerValues(
                value: "10",
                state: settingsState,
                notifier: settingsNotifier,
              ),
              const SizedBox(
                width: 5,
              ),
              ContainerValues(
                value: "20",
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
