import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/main/settings/add_space_definition.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditSpaceDefinition extends ConsumerWidget {
  const EditSpaceDefinition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Space Definition"),
        actions: const [
          AirstatSettingsAppBar(),
        ],
      ),
      body: const Center(
        child: Column(
          children: [],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
            RegularButton(
              onTap: () {
                ref.read(readingModeProvider.notifier).state = null;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddSpaceDefinition();
                }));
              },
              width: 100,
              buttonText: "Add",
              buttonKey: "addSpaceDefinition",
            ),
          ],
        ),
      ),
    );
  }
}
