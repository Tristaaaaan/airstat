import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/main/settings/add_space_definition.dart';
import 'package:airstat/main/settings/edit_space_definition.dart';
import 'package:airstat/models/space_definition_model.dart';
import 'package:airstat/notifiers/loading_state_notifiers.dart';
import 'package:airstat/provider/database_provider.dart';
import 'package:airstat/services/space_definitions_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedItemNotifier extends StateNotifier<Configuration?> {
  SelectedItemNotifier() : super(null);

  void selectItem(Configuration config) {
    if (state != null && state!.id == config.id) {
      state = null; // Deselect if the same item is clicked again
    } else {
      state = config; // Select the new item
    }
  }

  void clearSelection() {
    state = null; // Clear the selection
  }
}

final selectedItemProvider =
    StateNotifierProvider<SelectedItemNotifier, Configuration?>((ref) {
  return SelectedItemNotifier();
});

class SpaceDefinitionList extends ConsumerWidget {
  const SpaceDefinitionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectedItemProvider);
    final airstatSpaceDefinitionStream =
        ref.watch(airstatSpaceDefinitionProviderStream);
    final airstatSpaceDefinition = ref.watch(airstatSpaceDefinitionProvider);
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
              child: airstatSpaceDefinitionStream.when(data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Text(
                      "There are no space definitions available as of the moment",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Row(
                        children: [
                          IDHolder(
                            definition: "ID1",
                            textColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IDHolder(
                            definition: "ID2",
                            textColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IDHolder(
                            definition: "ID3",
                            textColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IDHolder(
                            definition: "ID4",
                            textColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final Configuration definition = data[index];
                            final isSelected =
                                definition.id == selectedItem?.id;
                            return InkWell(
                              onTap: () {
                                ref
                                    .read(selectedItemProvider.notifier)
                                    .selectItem(definition);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                // decoration: BoxDecoration(
                                //   color: isSelected
                                //       ? Theme.of(context).colorScheme.primary
                                //       : Theme.of(context).colorScheme.background,
                                // ),
                                child: Row(
                                  children: [
                                    IDHolder(
                                      definition: definition.id1,
                                      textColor: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .background
                                          : Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                      backgroundColor: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                    ),
                                    IDHolder(
                                      definition: definition.id2,
                                      textColor: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .background
                                          : Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                      backgroundColor: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                    ),
                                    IDHolder(
                                      definition: definition.id3,
                                      textColor: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .background
                                          : Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                      backgroundColor: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                    ),
                                    IDHolder(
                                      definition: definition.id4,
                                      textColor: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .background
                                          : Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                      backgroundColor: isSelected
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }, loading: () {
                return const CircularProgressIndicator();
              }, error: (error, stackTrace) {
                return Text(error.toString());
              }),
            )
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
            Row(
              children: [
                RegularButton(
                  withLoading: true,
                  onTap: () async {
                    final isLoading = ref.read(isLoadingProvider.notifier);
                    final delete = ref.watch(selectedItemProvider);

                    isLoading.setLoading("deleteSpaceDefinition", true);
                    if (delete != null) {
                      print("Deleting $delete");
                      await airstatSpaceDefinition.deleteConfiguration(delete);

                      await Future.delayed(const Duration(seconds: 1));
                      if (context.mounted) {
                        informationSnackBar(context, Icons.check,
                            "Space definition has been deleted");
                      }
                      isLoading.setLoading("deleteSpaceDefinition", false);
                    } else {
                      informationSnackBar(context, Icons.warning,
                          "There is no space definition selected to delete");
                      isLoading.setLoading("deleteSpaceDefinition", false);
                    }
                  },
                  width: 100,
                  buttonText: "Delete",
                  buttonKey: "deleteSpaceDefinition",
                ),
                const SizedBox(
                  width: 5,
                ),
                RegularButton(
                  onTap: () {
                    final edit = ref.watch(selectedItemProvider);

                    if (edit != null) {
                      print("Edit ${edit.mode}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditSpaceDefinition(config: edit);
                          },
                        ),
                      );
                    } else {
                      informationSnackBar(context, Icons.warning,
                          "There is no space definition selected to edit");
                    }
                  },
                  width: 100,
                  buttonText: "Edit",
                  buttonKey: "editSpaceDefinition",
                ),
                const SizedBox(
                  width: 5,
                ),
                RegularButton(
                  onTap: () {
                    ref.read(selectedItemProvider.notifier).clearSelection();
                    ref.read(readingModeProvider.notifier).state = null;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddSpaceDefinition();
                    }));
                  },
                  width: 100,
                  buttonText: "Add",
                  buttonKey: "addSpaceDefinition",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IDHolder extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String definition;
  const IDHolder({
    super.key,
    required this.definition,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          definition,
          style: TextStyle(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
