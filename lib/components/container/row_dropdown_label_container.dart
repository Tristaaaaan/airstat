import 'package:airstat/constants/dropdown_labels.dart';
import 'package:flutter/material.dart';

class RowDropDownLabel extends StatelessWidget {
  final String category;
  const RowDropDownLabel({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(
            width: 315,
            child: Row(
              children: [
                SizedBox(
                  width: 220,
                  child: DropdownMenu(
                    dropdownMenuEntries: RowLabels.values
                        .map<DropdownMenuEntry<RowLabels>>((RowLabels label) {
                      return DropdownMenuEntry<RowLabels>(
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
                const SizedBox(
                  width: 10,
                ),
                const Text("1 to 12", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
