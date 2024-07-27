import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/container/settings_container.dart';
import 'package:airstat/components/container/settings_container_one.dart';
import 'package:airstat/components/container/settings_container_two.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/models/settings_model.dart';
import 'package:airstat/services/airstat_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Settings extends ConsumerWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final serialComm = ref.watch(serialCommunicationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: const [
          Row(
            children: [
              Row(
                children: [
                  Text(
                    "Sampling: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sampling",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Row(
                children: [
                  Text(
                    "Delay: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sampling",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Row(
                children: [
                  Text(
                    "Units: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sampling",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 25,
              ),
            ],
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SettingsContainer(category: "General Sampling"),
            SettingsContainer(category: "Silhouette / Vents Sampling"),
            SettingsContainer(category: "General Delay"),
            SettingsContainer(category: "Silhouette / Vents Delay"),
            SettingsContainerTwo(category: "Units"),
            SettingsContainerOne(category: "Spaces Configuration"),
            RegularTextField(category: "User / Test ID", hinttext: "username"),
            RegularTextField(category: "Cloud Folder", hinttext: "folder name"),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.settings,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
            RegularButton(
              buttonText: "Save",
              textColor: Theme.of(context).colorScheme.background,
              backgroundColor: Theme.of(context).colorScheme.primary,
              width: 100,
              onTap: () async {
                AirstatSettingsModel settings = AirstatSettingsModel(
                  delay: 1,
                  sampling: 20,
                  unit: "ft/min",
                );

                AirstatSettingsConfiguration config =
                    AirstatSettingsConfiguration();
                final dataBefore = await config.getAirstatSettingsDatabase();
                print("Before Settings: $dataBefore");
                await config.updateAirstatSettingsDatabase(settings);

                final dataAfter = await config.getAirstatSettingsDatabase();
                print("After Settings: $dataAfter");
              },
            ),
          ],
        ),
      ),
    );
  }
}
