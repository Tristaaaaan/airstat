import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/main/settings/add_space_definition.dart';
import 'package:airstat/models/space_definition_model.dart';
import 'package:airstat/services/space_definitions_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditSpaceDefinition extends ConsumerWidget {
  const EditSpaceDefinition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airstatSpaceDefinition =
        ref.watch(airstatSpaceDefinitionProviderStream);
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
            Expanded(
                child: airstatSpaceDefinition.when(data: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final Configuration definition = data[index];
                  return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          IDHolder(definition: definition.id1),
                          IDHolder(definition: definition.id2),
                          IDHolder(definition: definition.id3),
                          IDHolder(definition: definition.id4),
                        ],
                      ));
                },
              );
            }, loading: () {
              return const CircularProgressIndicator();
            }, error: (error, stackTrace) {
              return Text(error.toString());
            }))
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

class IDHolder extends StatelessWidget {
  const IDHolder({
    super.key,
    required this.definition,
  });

  final String definition;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          definition,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
