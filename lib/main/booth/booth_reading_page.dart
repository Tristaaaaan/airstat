import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/functions/request_data.dart';
import 'package:airstat/main/booth/dynamictables/booth_reading_dynamic_table.dart';
import 'package:airstat/main/booth/dynamictables/exit_silhoutte_dynamic_table.dart';
import 'package:airstat/main/booth/entrance_silhouette_page.dart';
import 'package:airstat/main/booth/exit_silhouette_page.dart';
import 'package:airstat/main/settings/settings.dart';
import 'package:airstat/notifiers/loading_state_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Define the StateNotifier that manages the table data
class BoothReadingTableDataNotifier extends StateNotifier<TableDataState> {
  // Initial data for the table
  static final List<List<String>> _initialData = [
    // ROW 1
    ['matrix1-1', '1', '', ''],
    ['matrix1-2', '2', '', ''],
    ['matrix1-3', '3', '', ''],
    ['matrix1-4', '4', '', ''],
    ['matrix1-5', '5', '', ''],
    ['matrix1-6', '6', '', ''],
    ['matrix1-7', '7', '', ''],
    ['matrix1-8', '8', '', ''],
    ['matrix1-9', '9', '', ''],
    ['matrix1-10', '10', '', ''],
    ['matrix1-11', '11', '', ''],
    ['matrix1-12', '12', '', ''],
    ['matrix2-1', '13', '', ''],
    ['matrix2-2', '14', '', ''],
    ['matrix2-3', '15', '', ''],
    ['matrix2-4', '16', '', ''],
    ['matrix2-5', '17', '', ''],
    ['matrix2-6', '18', '', ''],
    ['matrix2-7', '19', '', ''],
    ['matrix2-8', '20', '', ''],
    ['matrix2-9', '21', '', ''],
    ['matrix2-10', '22', '', ''],
    ['matrix2-11', '23', '', ''],
    ['matrix2-12', '24', '', ''],
    ['matrix3-1', '25', '', ''],
    ['matrix3-2', '26', '', ''],
    ['matrix3-3', '27', '', ''],
    ['matrix3-4', '28', '', ''],
    ['matrix3-5', '29', '', ''],
    ['matrix3-6', '30', '', ''],
    ['matrix3-7', '31', '', ''],
    ['matrix3-8', '32', '', ''],
    ['matrix3-9', '33', '', ''],
    ['matrix3-10', '34', '', ''],
    ['matrix3-11', '35', '', ''],
    ['matrix3-12', '36', '', ''],
    ['matrix4-1', '37', '', ''],
    ['matrix4-2', '38', '', ''],
    ['matrix4-3', '39', '', ''],
    ['matrix4-4', '40', '', ''],
    ['matrix4-5', '41', '', ''],
    ['matrix4-6', '42', '', ''],
    ['matrix4-7', '43', '', ''],
    ['matrix4-8', '44', '', ''],
    ['matrix4-9', '45', '', ''],
    ['matrix4-10', '46', '', ''],
    ['matrix4-11', '47', '', ''],
    ['matrix4-12', '48', '', ''],
    ['matrix5-1', '49', '', ''],
    ['matrix5-2', '50', '', ''],
    ['matrix5-3', '51', '', ''],
    ['matrix5-4', '52', '', ''],
    ['matrix5-5', '53', '', ''],
    ['matrix5-6', '54', '', ''],
    ['matrix5-7', '55', '', ''],
    ['matrix5-8', '56', '', ''],
    ['matrix5-9', '57', '', ''],
    ['matrix5-10', '58', '', ''],
    ['matrix5-11', '59', '', ''],
    ['matrix5-12', '60', '', ''],
    ['matrix6-1', '61', '', ''],
    ['matrix6-2', '62', '', ''],
    ['matrix6-3', '63', '', ''],
    ['matrix6-4', '64', '', ''],
    ['matrix6-5', '65', '', ''],
    ['matrix6-6', '66', '', ''],
    ['matrix6-7', '67', '', ''],
    ['matrix6-8', '68', '', ''],
    ['matrix6-9', '69', '', ''],
    ['matrix6-10', '70', '', ''],
    ['matrix6-11', '71', '', ''],
    ['matrix6-12', '72', '', ''],
    ['matrix7-1', '73', '', ''],
    ['matrix7-2', '74', '', ''],
    ['matrix7-3', '75', '', ''],
    ['matrix7-4', '76', '', ''],
    ['matrix7-5', '77', '', ''],
    ['matrix7-6', '78', '', ''],
    ['matrix7-7', '79', '', ''],
    ['matrix7-8', '80', '', ''],
    ['matrix7-9', '81', '', ''],
    ['matrix7-10', '82', '', ''],
    ['matrix7-11', '83', '', ''],
    ['matrix7-12', '84', '', ''],
    ['matrix8-1', '85', '', ''],
    ['matrix8-2', '86', '', ''],
    ['matrix8-3', '87', '', ''],
    ['matrix8-4', '88', '', ''],
    ['matrix8-5', '89', '', ''],
    ['matrix8-6', '90', '', ''],
    ['matrix8-7', '91', '', ''],
    ['matrix8-8', '92', '', ''],
    ['matrix8-9', '93', '', ''],
    ['matrix8-10', '94', '', ''],
    ['matrix8-11', '95', '', ''],
    ['matrix8-12', '96', '', ''],
    ['matrix9-1', '97', '', ''],
    ['matrix9-2', '98', '', ''],
    ['matrix9-3', '99', '', ''],
    ['matrix9-4', '100', '', ''],
    ['matrix9-5', '101', '', ''],
    ['matrix9-6', '102', '', ''],
    ['matrix9-7', '103', '', ''],
    ['matrix9-8', '104', '', ''],
    ['matrix9-9', '105', '', ''],
    ['matrix9-10', '106', '', ''],
    ['matrix9-11', '107', '', ''],
    ['matrix9-12', '108', '', ''],
  ];

  BoothReadingTableDataNotifier() : super(TableDataState(_initialData));

  // Function to clear data
  void clearData() {
    state = TableDataState(_initialData);
  }

  void updateTableData(
    int row,
    int col,
    List<String> values,
  ) {
    // Ensure row and column are within valid range
    if (row < 0 || row >= 9 || col < 0 || col >= 12) {
      print('Invalid row or column value: row=$row, col=$col');
      return;
    }

    // Convert the row and column to the correct index in the list of lists
    int dataIndex = row * 12 + col;
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
final boothReadingTableDataProvider =
    StateNotifierProvider<BoothReadingTableDataNotifier, TableDataState>(
  (ref) => BoothReadingTableDataNotifier(),
);

class BoothReading extends ConsumerWidget {
  const BoothReading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              "Reading",
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
              BoothReadingDynamicTable(rows: 5, columns: 5),
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

                    final selectedBox =
                        ref.read(selectedBoothReadingBoxProvider);
                    final row = selectedBox['selectedBox']['row'];
                    final col = selectedBox['selectedBox']['col'];

                    // Check if the selected cell already has a value
                    if (row != null &&
                        col != null &&
                        ref
                                .read(selectedBoothReadingBoxProvider.notifier)
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
                          .read(selectedBoothReadingBoxProvider.notifier)
                          .updateSelectedBoxValue(
                              '${values[0]} | ${values[1]}');

                      ref
                          .read(boothReadingTableDataProvider.notifier)
                          .updateTableData(
                            row, // row index
                            col, // column index
                            values, // new values
                          );

                      print(
                          "DATA AFTER: ${ref.watch(boothReadingTableDataProvider).data}");
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
                    final allValues = ref
                        .read(selectedBoothReadingBoxProvider.notifier)
                        .getAllValues();
                    ref
                        .read(selectedExitSilhouetteBoxProvider.notifier)
                        .clearValues();
                    if (allValues.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ExitSilhouette();
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
