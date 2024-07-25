import 'package:airstat/components/container/row_dropdown_label_container.dart';
import 'package:airstat/components/textfield/regular_textfield.dart';
import 'package:airstat/constants/dropdown_labels.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddSpaceDefinition extends ConsumerWidget {
  const AddSpaceDefinition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                          print(value!.label);
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                              foregroundColor:
                                  Theme.of(context).colorScheme.inversePrimary,
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
              const RowDropDownLabel(
                category: "Rows",
              ),
              const RowDropDownLabel(
                category: "Reading Per Row",
              ),
              const RowDropDownLabel(
                category: "Silhoutte Width",
              ),
              const RowDropDownLabel(
                category: "Silhoutte Height",
              ),
              const RegularTextField(category: "Target DD"),
              const RegularTextField(category: "DD Delta"),
              const RegularTextField(category: "Target Delta"),
              const RegularTextField(category: "Target CD"),
              const RegularTextField(category: "CD Delta"),
            ],
          ),
        ),
      ),
    );
  }
}
