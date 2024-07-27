import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/constants/dropdown_labels.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final readingModeProvider = StateProvider<String?>((ref) {
  return null;
});

class AddSpaceDefinition extends ConsumerWidget {
  const AddSpaceDefinition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readingMode = ref.watch(readingModeProvider);
    return Scaffold(
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
          ],
        ),
      ),
    );
  }
}
