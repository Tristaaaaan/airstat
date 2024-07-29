import 'package:airstat/services/airstat_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AirstatSettingsAppBar extends ConsumerWidget {
  const AirstatSettingsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the settings from the provider
    final airstatSettings = ref.watch(airstatSettingsProviderStream);

    return airstatSettings.when(
        data: (data) {
          return Row(
            children: [
              Row(
                children: [
                  const Text(
                    "Sampling: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${data.sampling}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Row(
                children: [
                  const Text(
                    "Delay: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${data.delay}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Row(
                children: [
                  const Text(
                    "Units: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data.unit,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(width: 25),
            ],
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator());
  }
}
