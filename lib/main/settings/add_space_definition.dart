import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/constants/dropdown_labels.dart';
import 'package:airstat/provider/save_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final readingModeProvider = StateProvider<String?>((ref) {
  return null;
});

class AddSpaceDefinition extends ConsumerWidget {
  AddSpaceDefinition({super.key});

  // Text Controllers
  // Booth
  final TextEditingController boothSiteTextController = TextEditingController();
  final TextEditingController boothAreaTextController = TextEditingController();
  final TextEditingController boothFloorTextController =
      TextEditingController();
  final TextEditingController boothRoomTextController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saveConfiguration = ref.watch(saveDataConfigurationServicesProvider);

    final readingMode = ref.watch(readingModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Space Definition"),
        actions: const [AirstatSettingsAppBar()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Reading Mode",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 315,
                    child: DropdownMenu<ReadingModeLabels>(
                      dropdownMenuEntries: ReadingModeLabels.values
                          .map<DropdownMenuEntry<ReadingModeLabels>>(
                              (ReadingModeLabels label) {
                        return DropdownMenuEntry<ReadingModeLabels>(
                          value: label,
                          label: label.label,
                          style: MenuItemButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                          ),
                        );
                      }).toList(),
                      expandedInsets: const EdgeInsets.all(0),
                      onSelected: (value) {
                        ref.read(readingModeProvider.notifier).state =
                            value!.label;
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (readingMode == "Booth")
              Column(
                children: [
                  RegularTextField(
                    category: "Site",
                    controller: boothSiteTextController,
                  ),
                  RegularTextField(
                    category: "Shop / Area",
                    controller: boothAreaTextController,
                  ),
                  RegularTextField(
                    category: "Line / Floor",
                    controller: boothFloorTextController,
                  ),
                  RegularTextField(
                    category: "Zone / Room",
                    controller: boothRoomTextController,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Units",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: DropdownMenu<UnitLabels>(
                            dropdownMenuEntries: UnitLabels.values
                                .map<DropdownMenuEntry<UnitLabels>>(
                                    (UnitLabels color) {
                              return DropdownMenuEntry<UnitLabels>(
                                value: color,
                                label: color.label,
                                style: MenuItemButton.styleFrom(
                                  foregroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              );
                            }).toList(),
                            expandedInsets: const EdgeInsets.all(0),
                            onSelected: (value) {
                              print(value!.label);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rows",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 220,
                                child: DropdownMenu(
                                  dropdownMenuEntries: RowLabels.values
                                      .map<DropdownMenuEntry<RowLabels>>(
                                          (RowLabels label) {
                                    return DropdownMenuEntry<RowLabels>(
                                      value: label,
                                      label: label.label,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    );
                                  }).toList(),
                                  expandedInsets: const EdgeInsets.all(0),
                                  onSelected: (value) {
                                    print(value!.label);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("1 to 20",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Reading Per Row",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 220,
                                child: DropdownMenu(
                                  dropdownMenuEntries:
                                      ReadingPerRowLabels.values.map<
                                              DropdownMenuEntry<
                                                  ReadingPerRowLabels>>(
                                          (ReadingPerRowLabels label) {
                                    return DropdownMenuEntry<
                                        ReadingPerRowLabels>(
                                      value: label,
                                      label: label.label,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    );
                                  }).toList(),
                                  expandedInsets: const EdgeInsets.all(0),
                                  onSelected: (value) {
                                    print(value!.label);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("1 to 9",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Silhouette Width",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 220,
                                child: DropdownMenu(
                                  dropdownMenuEntries:
                                      SilhouetteWidthLabels.values.map<
                                              DropdownMenuEntry<
                                                  SilhouetteWidthLabels>>(
                                          (SilhouetteWidthLabels label) {
                                    return DropdownMenuEntry<
                                        SilhouetteWidthLabels>(
                                      value: label,
                                      label: label.label,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    );
                                  }).toList(),
                                  expandedInsets: const EdgeInsets.all(0),
                                  onSelected: (value) {
                                    print(value!.label);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("1 to 3",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Silhouette Height",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 220,
                                child: DropdownMenu(
                                  dropdownMenuEntries:
                                      SilhouetteHeightLabels.values.map<
                                              DropdownMenuEntry<
                                                  SilhouetteHeightLabels>>(
                                          (SilhouetteHeightLabels label) {
                                    return DropdownMenuEntry<
                                        SilhouetteHeightLabels>(
                                      value: label,
                                      label: label.label,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    );
                                  }).toList(),
                                  expandedInsets: const EdgeInsets.all(0),
                                  onSelected: (value) {
                                    print(value!.label);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("1 to 3",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const RegularTextField(category: "Target DD"),
                  const RegularTextField(category: "DD Delta"),
                  const RegularTextField(category: "Target Delta"),
                  const RegularTextField(category: "Target CD"),
                  const RegularTextField(category: "CD Delta"),
                ],
              ),
            if (readingMode == "OR" || readingMode == "All")
              const Column(
                children: [
                  RegularTextField(category: "Site"),
                  RegularTextField(category: "Shop / Area"),
                  RegularTextField(category: "Line / Floor"),
                  RegularTextField(category: "Zone / Room"),
                ],
              ),
            if (readingMode == "3D")
              Column(
                children: [
                  const RegularTextField(category: "Site"),
                  const RegularTextField(category: "Shop / Area"),
                  const RegularTextField(category: "Line / Floor"),
                  const RegularTextField(category: "Zone / Room"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Units",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: DropdownMenu<UnitLabels>(
                            dropdownMenuEntries: UnitLabels.values
                                .map<DropdownMenuEntry<UnitLabels>>(
                                    (UnitLabels color) {
                              return DropdownMenuEntry<UnitLabels>(
                                value: color,
                                label: color.label,
                                style: MenuItemButton.styleFrom(
                                  foregroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              );
                            }).toList(),
                            expandedInsets: const EdgeInsets.all(0),
                            onSelected: (value) {
                              print(value!.label);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "X Axis",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 220,
                                child: DropdownMenu(
                                  dropdownMenuEntries: RowLabels.values
                                      .map<DropdownMenuEntry<RowLabels>>(
                                          (RowLabels label) {
                                    return DropdownMenuEntry<RowLabels>(
                                      value: label,
                                      label: label.label,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    );
                                  }).toList(),
                                  expandedInsets: const EdgeInsets.all(0),
                                  onSelected: (value) {
                                    print(value!.label);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("1 to 12",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Y Axis",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 220,
                                child: DropdownMenu(
                                  dropdownMenuEntries:
                                      ReadingPerRowLabels.values.map<
                                              DropdownMenuEntry<
                                                  ReadingPerRowLabels>>(
                                          (ReadingPerRowLabels label) {
                                    return DropdownMenuEntry<
                                        ReadingPerRowLabels>(
                                      value: label,
                                      label: label.label,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    );
                                  }).toList(),
                                  expandedInsets: const EdgeInsets.all(0),
                                  onSelected: (value) {
                                    print(value!.label);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("1 to 9",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Z Axis",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 315,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 220,
                                child: DropdownMenu(
                                  dropdownMenuEntries:
                                      SilhouetteWidthLabels.values.map<
                                              DropdownMenuEntry<
                                                  SilhouetteWidthLabels>>(
                                          (SilhouetteWidthLabels label) {
                                    return DropdownMenuEntry<
                                        SilhouetteWidthLabels>(
                                      value: label,
                                      label: label.label,
                                      style: MenuItemButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    );
                                  }).toList(),
                                  expandedInsets: const EdgeInsets.all(0),
                                  onSelected: (value) {
                                    print(value!.label);
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("1 to 3",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
              onTap: () async {
                print("Site: ${boothSiteTextController.text}");
                print("Shop/Area: ${boothAreaTextController.text}");
                print("Line/Floor: ${boothFloorTextController.text}");
                print("Zone/Room: ${boothRoomTextController.text}");
                // await saveConfiguration.writeConfigurationContent(
                //     "configuration", "HAHAHAA");
                // ref.read(fileListProvider.notifier).refresh();
              },
              width: 100,
              buttonKey: "saveNewSpaceDefinition",
              buttonText: "Save",
            ),
          ],
        ),
      ),
    );
  }
}
