import 'package:airstat/components/container/box_data_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicTable extends ConsumerWidget {
  final int rows;
  final int columns;

  const DynamicTable({super.key, required this.rows, required this.columns});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBox = ref.watch(selectedBoxProvider);

    // Function to get Y header label based on row index
    String getYHeaderLabel(int index) {
      switch (index) {
        case 0:
          return 'Top';
        case 1:
          return 'Middle';
        case 2:
          return 'Bottom';
        default:
          return '';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // X header row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(columns + 1, (colIndex) {
              if (colIndex == 0) {
                return const SizedBox(width: 50); // Empty corner cell
              }
              return Container(
                margin: const EdgeInsets.all(5),
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  '$colIndex',
                  textAlign: TextAlign.center,
                ),
              );
            }),
          ),
          // Table rows with Y header
          ...List.generate(rows, (rowIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Y header column
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    getYHeaderLabel(rowIndex),
                  ),
                ),
                // Data columns
                ...List.generate(columns, (colIndex) {
                  String value = "";
                  bool isSelected = rowIndex == selectedBox['row'] &&
                      colIndex == selectedBox['col'];
                  return BoxDataContainer(
                    value: value,
                    isSelected: isSelected,
                    onTap: () {
                      ref
                          .read(selectedBoxProvider.notifier)
                          .selectBox(rowIndex, colIndex);
                    },
                  );
                }),
              ],
            );
          }),
        ],
      ),
    );
  }
}
