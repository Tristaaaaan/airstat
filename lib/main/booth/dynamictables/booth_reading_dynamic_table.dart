import 'package:airstat/components/container/box_data_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Provider for the SelectedBoxNotifier
final selectedBoothReadingBoxProvider = StateNotifierProvider<
    SelectedBoothReadingBoxNotifier, Map<String, dynamic>>((ref) {
  return SelectedBoothReadingBoxNotifier();
});

// StateNotifier to manage selected box
class SelectedBoothReadingBoxNotifier
    extends StateNotifier<Map<String, dynamic>> {
  SelectedBoothReadingBoxNotifier()
      : super({
          'selectedBox': {'row': null, 'col': null},
          'values': {}
        });

  void selectBox(int row, int col) {
    state = {
      ...state,
      'selectedBox': {'row': row, 'col': col}
    };
  }

  void updateSelectedBoxValue(String value) {
    // Generate a new random value

    final row = state['selectedBox']['row'];
    final col = state['selectedBox']['col'];

    if (row != null && col != null) {
      state = {
        ...state,
        'values': {...state['values'], '$row-$col': value}
      };
    }
  }

  String? getValue(int row, int col) {
    return state['values']['$row-$col'];
  }

  Map<String, String> getAllValues() {
    return Map<String, String>.from(state['values']);
  }

  void clearValues() {
    state = {...state, 'values': {}};
  }
}

class BoothReadingDynamicTable extends ConsumerWidget {
  final int rows;
  final int columns;

  const BoothReadingDynamicTable(
      {super.key, required this.rows, required this.columns});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBox = ref.watch(selectedBoothReadingBoxProvider);

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
                width: 80,
                height: 30,
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
                  height: 30,
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    '${rowIndex + 1}',
                  ),
                ),
                // Data columns
                ...List.generate(
                  columns,
                  (colIndex) {
                    bool isSelected =
                        rowIndex == selectedBox['selectedBox']['row'] &&
                            colIndex == selectedBox['selectedBox']['col'];
                    String value = ref
                            .read(selectedBoothReadingBoxProvider.notifier)
                            .getValue(rowIndex, colIndex) ??
                        '';
                    return BoxDataContainer(
                      value: value,
                      isSelected: isSelected,
                      onTap: () {
                        ref
                            .read(selectedBoothReadingBoxProvider.notifier)
                            .selectBox(rowIndex, colIndex);
                      },
                    );
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
