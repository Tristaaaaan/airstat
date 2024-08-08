import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/main/settings/space_defintion_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SpaceDefinitionMain extends ConsumerWidget {
  SpaceDefinitionMain({super.key});
  final TextEditingController fileNameController = TextEditingController();
  final TextEditingController spaceController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Space Definition"),
        actions: const [
          AirstatSettingsAppBar(),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            RegularTextField(
              category: "File Name",
              controller: fileNameController,
            ),
            RegularTextField(
              category: "Spaces",
              controller: spaceController,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
            RegularButton(
              onTap: () {},
              width: 100,
              buttonKey: "backupSpaceDefinition",
              buttonText: "Backup",
            ),
            RegularButton(
              onTap: () {},
              width: 100,
              buttonText: "Restore",
              buttonKey: "restoreSpaceDefinition",
            ),
            RegularButton(
              onTap: () {
                ref.read(selectedItemProvider.notifier).clearSelection();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SpaceDefinitionList();
                }));
              },
              width: 100,
              buttonText: "Edit",
              buttonKey: "editSpaceDefinition",
            ),
            RegularButton(
              width: 100,
              onTap: () {},
              buttonText: "Delete",
              buttonKey: "deleteSpaceDefinition",
            ),
          ],
        ),
      ),
    );
  }
}
