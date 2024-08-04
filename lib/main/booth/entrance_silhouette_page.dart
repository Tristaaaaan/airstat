import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/functions/request_data.dart';
import 'package:airstat/main/booth/booth_reading_page.dart';
import 'package:airstat/main/booth/dynamictables/booth_reading_dynamic_table.dart';
import 'package:airstat/main/booth/dynamictables/entrance_silhoutte_dynamic_table.dart';
import 'package:airstat/main/settings/settings.dart';
import 'package:airstat/notifiers/loading_state_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Define the state class for the table data
class TableDataState {
  final List<List<String>> data;

  TableDataState(this.data);

  TableDataState copyWith({List<List<String>>? data}) {
    return TableDataState(data ?? this.data);
  }
}

// Define the StateNotifier that manages the table data
class TableDataNotifier extends StateNotifier<TableDataState> {
  // Initial data for the table
  static final List<List<String>> _initialData = [
    // ROW 1
    ['en-sil-top', '1', '', ''],
    ['en-sil-top', '2', '', ''],
    ['en-sil-top', '3', '', ''],

    // ROW 2
    ['en-sil-middle', '1', '', ''],
    ['en-sil-middle', '2', '', ''],
    ['en-sil-middle', '3', '', ''],

    // ROW 3
    ['en-sil-bottom', '1', '', ''],
    ['en-sil-bottom', '2', '', ''],
    ['en-sil-bottom', '3', '', ''],
  ];

  TableDataNotifier() : super(TableDataState(_initialData));

  // Function to clear data
  void clearData() {
    state = TableDataState(_initialData);
  }

  // Function to update table data
  void updateTableData(
    int row,
    int col,
    List<String> values,
  ) {
    // Adjust row and column to match the data structure's 1-based indexing
    row += 1;
    col += 1;

    // Ensure row and column are within valid range
    if (row < 1 || row > 3 || col < 1 || col > 3) {
      print('Invalid row or column value: row=$row, col=$col');
      return;
    }

    // Convert the row and column to the correct index in the list of lists
    int dataIndex = (row - 1) * 3 + (col - 1);
    print('Updating data at index $dataIndex for row=$row, col=$col');

    // Ensure dataIndex is within the valid range of tableData
    if (dataIndex < 0 || dataIndex >= state.data.length) {
      print('Invalid data index: $dataIndex');
      return;
    }

    // Update values in the correct cells
    List<List<String>> updatedData = List.from(state.data);
    if (updatedData[dataIndex][2] == '') {
      updatedData[dataIndex][2] = values[0];
    }
    if (updatedData[dataIndex][3] == '') {
      updatedData[dataIndex][3] = values[1];
    }

    state = TableDataState(updatedData);
  }
}

// Define the provider for the TableDataNotifier
final tableDataProvider =
    StateNotifierProvider<TableDataNotifier, TableDataState>(
  (ref) => TableDataNotifier(),
);

class EntranceSilhouette extends HookConsumerWidget {
  const EntranceSilhouette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
// Function to initialize USB devices
    void initializeEntranceSilhouetteTableData() async {
      // updateTableDataHolder(entranceSilhouetteTableData);

      // print("DATA AFTER: $entranceSilhouetteTableData");
    }

    useEffect(() {
      initializeEntranceSilhouetteTableData();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booth",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              "Entrance Silhouette",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: const [
          AirstatSettingsAppBar(),
        ],
      ),
      body: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              DynamicTable(rows: 2, columns: 2),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/icons/Special_DD.png",
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                RegularButton(
                  buttonText: "Read",
                  buttonKey: "boothRead",
                  width: 100,
                  withLoading: true,
                  onTap: () async {
                    ref
                        .read(isLoadingProvider.notifier)
                        .setLoading("boothRead", true);

                    final List<String> values =
                        await readBoothData(ref, ref.watch(unitValueProvider));

                    final selectedBox = ref.read(selectedBoxProvider);
                    final row = selectedBox['selectedBox']['row'];
                    final col = selectedBox['selectedBox']['col'];

                    // Check if the selected cell already has a value
                    if (row != null &&
                        col != null &&
                        ref
                                .read(selectedBoxProvider.notifier)
                                .getValue(row, col) !=
                            null) {
                      ref
                          .read(isLoadingProvider.notifier)
                          .setLoading("boothRead", false);
                      if (context.mounted) {
                        informationSnackBar(
                            context, Icons.info, "Box already filled");
                      }
                      return; // Exit the function if the cell already has a value
                    } else {
                      ref
                          .read(selectedBoxProvider.notifier)
                          .updateSelectedBoxValue(
                              '${values[0]} | ${values[1]}');
                      ref.read(tableDataProvider.notifier).updateTableData(
                            row, // row index
                            col, // column index
                            values, // new values
                          );

                      print("DATA AFTER: ${ref.watch(tableDataProvider).data}");
                    }
                    ref
                        .read(isLoadingProvider.notifier)
                        .setLoading("boothRead", false);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                RegularButton(
                  buttonText: "Next",
                  buttonKey: "boothNext",
                  width: 100,
                  onTap: () {
                    final allValues =
                        ref.read(selectedBoxProvider.notifier).getAllValues();
                    ref
                        .read(selectedBoothReadingBoxProvider.notifier)
                        .clearValues();
                    allValues.forEach((key, value) {
                      print('Box $key: $value');
                    });

                    if (allValues.isNotEmpty) {
                      print("${ref.watch(tableDataProvider).data}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const BoothReading();
                          },
                        ),
                      );
                    } else {
                      if (context.mounted) {
                        informationSnackBar(
                            context, Icons.info, "The table is empty");
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
