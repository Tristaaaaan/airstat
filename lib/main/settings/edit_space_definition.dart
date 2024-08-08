import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/constants/dropdown_labels.dart';
import 'package:airstat/main/settings/space_defintion_list.dart';
import 'package:airstat/models/space_definition_model.dart';
import 'package:airstat/provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditSpaceDefinition extends ConsumerWidget {
  final Configuration config;
  EditSpaceDefinition({
    super.key,
    required this.config,
  });

  // Text Controllers
  // Booth
  final TextEditingController boothSiteTextController = TextEditingController();
  final TextEditingController boothAreaTextController = TextEditingController();
  final TextEditingController boothFloorTextController =
      TextEditingController();
  final TextEditingController boothRoomTextController = TextEditingController();
  final TextEditingController targetDdTextController = TextEditingController();
  final TextEditingController targetCdTextController = TextEditingController();

  final TextEditingController ddDeltaTextController = TextEditingController();
  final TextEditingController cdDeltaTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airstatSpaceDefinition = ref.watch(airstatSpaceDefinitionProvider);
    boothSiteTextController.text = config.id1;
    boothAreaTextController.text = config.id2;
    boothFloorTextController.text = config.id3;
    boothRoomTextController.text = config.id4;
    String? unit;
    String? rows;
    String? readingPerRow;
    String? silhouetteWidth;
    String? silhouetteHeight;
    unit = config.units;
    rows = config.xRows.toString();
    readingPerRow = config.yReadPerRow.toString();
    silhouetteWidth = config.zSilWidth.toString();
    silhouetteHeight = config.silHeight.toString();
    targetDdTextController.text =
        config.targetDd.toString() == "null" ? "" : config.targetDd.toString();
    targetCdTextController.text = config.targetSide.toString() == "null"
        ? ""
        : config.targetSide.toString();
    ddDeltaTextController.text =
        config.varDd.toString() == "null" ? "" : config.varDd.toString();
    cdDeltaTextController.text =
        config.varCd.toString() == "null" ? "" : config.varCd.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Space Definition"),
        actions: const [AirstatSettingsAppBar()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (config.mode == "Booth")
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
                            initialSelection: UnitLabels.values.firstWhere(
                                (unitLabel) => unitLabel.label == unit),
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
                              unit = value!.label;
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
                                  initialSelection: RowLabels.values.firstWhere(
                                      (rowLabels) => rowLabels.label == rows),
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
                                    rows = value!.label;
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
                                  initialSelection: ReadingPerRowLabels.values
                                      .firstWhere((readingPerRowLabels) =>
                                          readingPerRowLabels.label ==
                                          readingPerRow),
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
                                    readingPerRow = value!.label;
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
                                  initialSelection: SilhouetteWidthLabels.values
                                      .firstWhere((silhouetteWidthLabels) =>
                                          silhouetteWidthLabels.label ==
                                          silhouetteWidth),
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
                                    silhouetteWidth = value!.label;
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
                                  initialSelection: SilhouetteHeightLabels
                                      .values
                                      .firstWhere((silhouetteHeightLabels) =>
                                          silhouetteHeightLabels.label ==
                                          silhouetteHeight),
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
                                    silhouetteHeight = value!.label;
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
                  RegularTextField(
                    category: "Target DD",
                    controller: targetDdTextController,
                    number: true,
                  ),
                  RegularTextField(
                    category: "Target CD",
                    controller: targetCdTextController,
                    number: true,
                  ),
                  RegularTextField(
                    category: "DD Delta",
                    controller: ddDeltaTextController,
                    number: true,
                  ),
                  RegularTextField(
                    category: "CD Delta",
                    controller: cdDeltaTextController,
                    number: true,
                  ),
                ],
              ),
            if (config.mode == "OR" || config.mode == "All")
              const Column(
                children: [
                  RegularTextField(category: "Site"),
                  RegularTextField(category: "Shop / Area"),
                  RegularTextField(category: "Line / Floor"),
                  RegularTextField(category: "Zone / Room"),
                ],
              ),
            if (config.mode == "3D")
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
                final selectedItems = ref.read(selectedItemProvider.notifier);
                if (config.mode == "Booth") {
                  print("Booth");
                  if (boothSiteTextController.text.isNotEmpty &&
                      boothAreaTextController.text.isNotEmpty &&
                      boothFloorTextController.text.isNotEmpty &&
                      boothRoomTextController.text.isNotEmpty &&
                      unit != null &&
                      rows != null &&
                      readingPerRow != null &&
                      silhouetteWidth != null &&
                      silhouetteHeight != null &&
                      targetDdTextController.text.isNotEmpty &&
                      ddDeltaTextController.text.isNotEmpty) {
                    print("Site: ${boothSiteTextController.text}");
                    print("Shop/Area: ${boothAreaTextController.text}");
                    print("Line/Floor: ${boothFloorTextController.text}");
                    print("Zone/Room: ${boothRoomTextController.text}");
                    print("Unit: $unit");
                    print("Rows: $rows");
                    print("Reading Per Row: $readingPerRow");
                    print("Silhouette Width: $silhouetteWidth");
                    print("Silhouette Height: $silhouetteHeight");
                    print("Target DD: ${targetDdTextController.text}");
                    print("Target CD: ${targetCdTextController.text}");
                    print("DD Delta: ${ddDeltaTextController.text}");
                    print("CD Delta: ${cdDeltaTextController.text}");

                    Configuration updateSpaceDefinition = Configuration(
                      id: config.id,
                      id1: boothSiteTextController.text,
                      id2: boothAreaTextController.text,
                      id3: boothFloorTextController.text,
                      id4: boothRoomTextController.text,
                      units: unit!,
                      mode: config.mode,
                      xRows: int.parse(rows!),
                      yReadPerRow: int.parse(readingPerRow!),
                      zSilWidth: int.parse(silhouetteWidth!),
                      silHeight: int.parse(silhouetteHeight!),
                      targetDd: int.parse(targetDdTextController.text),
                      targetSide: targetCdTextController.text == ""
                          ? null
                          : int.parse(targetCdTextController.text),
                      varDd: int.parse(ddDeltaTextController.text),
                      varCd: cdDeltaTextController.text == ""
                          ? null
                          : int.parse(cdDeltaTextController.text),
                    );

                    final int values = await airstatSpaceDefinition
                        .updateConfiguration(updateSpaceDefinition);

                    print("Updated $values rows");

                    if (context.mounted) {
                      selectedItems.clearSelection();
                      informationSnackBar(context, Icons.check,
                          "Space definition has been saved");
                      boothSiteTextController.text = "";
                      boothAreaTextController.text = "";
                      boothFloorTextController.text = "";
                      boothRoomTextController.text = "";
                      unit = null;
                      rows = null;
                      readingPerRow = null;
                      silhouetteWidth = null;
                      silhouetteHeight = null;
                      targetDdTextController.text = "";
                      targetCdTextController.text = "";
                      ddDeltaTextController.text = "";
                      cdDeltaTextController.text = "";

                      Navigator.of(context).pop();
                    }
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      informationSnackBar(
                          context, Icons.error, "Fill all fields");
                    });
                  }
                }
              },
              width: 100,
              buttonKey: "editNewSpaceDefinition",
              buttonText: "Save",
            ),
          ],
        ),
      ),
    );
  }
}
