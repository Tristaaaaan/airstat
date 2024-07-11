import 'package:airstat/components/container/settings_container.dart';
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
          ],
        ),
      ),
    );
  }
}
