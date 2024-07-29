import 'package:airstat/models/settings_model.dart';
import 'package:airstat/provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AirstatSettingsAppBar extends ConsumerWidget {
  const AirstatSettingsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch the settings from the provider
    final airstatSettings = ref.watch(airstatDatabaseProvider);

    return FutureBuilder<AirstatSettingsModel>(
      future: airstatSettings.getAirstatSettingsDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Or any loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No data available');
        }

        final settings = snapshot.data!;

        return Row(
          children: [
            Row(
              children: [
                const Text(
                  "Sampling: ",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${settings.sampling}",
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
                  "${settings.delay}",
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
                  settings.unit,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 25),
          ],
        );
      },
    );
  }
}
