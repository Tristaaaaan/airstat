import 'package:airstat/components/container/settings_container.dart';
import 'package:airstat/components/container/settings_container_one.dart';
import 'package:airstat/components/container/settings_container_two.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
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
            RegularTextField(
              category: "User / Test ID",
              hinttext: "username",
            ),
            RegularTextField(
              category: "Cloud Folder",
              hinttext: "folder name",
            ),
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
            Container(
              width: 100,
              padding: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: Text(
                "Save",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
