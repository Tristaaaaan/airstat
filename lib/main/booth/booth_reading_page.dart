import 'package:airstat/components/appbar/airstats_settings_appbar.dart';
import 'package:airstat/components/button/regular_button.dart';
import 'package:airstat/components/snackbar/information_snackbar.dart';
import 'package:airstat/functions/request_data.dart';
import 'package:airstat/main/booth/booth_page.dart';
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
    ['matrix1-13', '13', '', ''],
    ['matrix1-14', '14', '', ''],
    ['matrix1-15', '15', '', ''],
    ['matrix1-16', '16', '', ''],
    ['matrix1-17', '17', '', ''],
    ['matrix1-18', '18', '', ''],
    ['matrix1-19', '19', '', ''],
    ['matrix1-20', '20', '', ''],
    ['matrix2-1', '21', '', ''],
    ['matrix2-2', '22', '', ''],
    ['matrix2-3', '23', '', ''],
    ['matrix2-4', '24', '', ''],
    ['matrix2-5', '25', '', ''],
    ['matrix2-6', '26', '', ''],
    ['matrix2-7', '27', '', ''],
    ['matrix2-8', '28', '', ''],
    ['matrix2-9', '29', '', ''],
    ['matrix2-10', '30', '', ''],
    ['matrix2-11', '31', '', ''],
    ['matrix2-12', '32', '', ''],
    ['matrix2-13', '33', '', ''],
    ['matrix2-14', '34', '', ''],
    ['matrix2-15', '35', '', ''],
    ['matrix2-16', '36', '', ''],
    ['matrix2-17', '37', '', ''],
    ['matrix2-18', '38', '', ''],
    ['matrix2-19', '39', '', ''],
    ['matrix2-20', '40', '', ''],
    ['matrix3-1', '41', '', ''],
    ['matrix3-2', '42', '', ''],
    ['matrix3-3', '43', '', ''],
    ['matrix3-4', '44', '', ''],
    ['matrix3-5', '45', '', ''],
    ['matrix3-6', '46', '', ''],
    ['matrix3-7', '47', '', ''],
    ['matrix3-8', '48', '', ''],
    ['matrix3-9', '49', '', ''],
    ['matrix3-10', '50', '', ''],
    ['matrix3-11', '51', '', ''],
    ['matrix3-12', '52', '', ''],
    ['matrix3-13', '53', '', ''],
    ['matrix3-14', '54', '', ''],
    ['matrix3-15', '55', '', ''],
    ['matrix3-16', '56', '', ''],
    ['matrix3-17', '57', '', ''],
    ['matrix3-18', '58', '', ''],
    ['matrix3-19', '59', '', ''],
    ['matrix3-20', '60', '', ''],
    ['matrix4-1', '61', '', ''],
    ['matrix4-2', '62', '', ''],
    ['matrix4-3', '63', '', ''],
    ['matrix4-4', '64', '', ''],
    ['matrix4-5', '65', '', ''],
    ['matrix4-6', '66', '', ''],
    ['matrix4-7', '67', '', ''],
    ['matrix4-8', '68', '', ''],
    ['matrix4-9', '69', '', ''],
    ['matrix4-10', '70', '', ''],
    ['matrix4-11', '71', '', ''],
    ['matrix4-12', '72', '', ''],
    ['matrix4-13', '73', '', ''],
    ['matrix4-14', '74', '', ''],
    ['matrix4-15', '75', '', ''],
    ['matrix4-16', '76', '', ''],
    ['matrix4-17', '77', '', ''],
    ['matrix4-18', '78', '', ''],
    ['matrix4-19', '79', '', ''],
    ['matrix4-20', '80', '', ''],
    ['matrix5-1', '81', '', ''],
    ['matrix5-2', '82', '', ''],
    ['matrix5-3', '83', '', ''],
    ['matrix5-4', '84', '', ''],
    ['matrix5-5', '85', '', ''],
    ['matrix5-6', '86', '', ''],
    ['matrix5-7', '87', '', ''],
    ['matrix5-8', '88', '', ''],
    ['matrix5-9', '89', '', ''],
    ['matrix5-10', '90', '', ''],
    ['matrix5-11', '91', '', ''],
    ['matrix5-12', '92', '', ''],
    ['matrix5-13', '93', '', ''],
    ['matrix5-14', '94', '', ''],
    ['matrix5-15', '95', '', ''],
    ['matrix5-16', '96', '', ''],
    ['matrix5-17', '97', '', ''],
    ['matrix5-18', '98', '', ''],
    ['matrix5-19', '99', '', ''],
    ['matrix5-20', '100', '', ''],
    ['matrix6-1', '101', '', ''],
    ['matrix6-2', '102', '', ''],
    ['matrix6-3', '103', '', ''],
    ['matrix6-4', '104', '', ''],
    ['matrix6-5', '105', '', ''],
    ['matrix6-6', '106', '', ''],
    ['matrix6-7', '107', '', ''],
    ['matrix6-8', '108', '', ''],
    ['matrix6-9', '109', '', ''],
    ['matrix6-10', '110', '', ''],
    ['matrix6-11', '111', '', ''],
    ['matrix6-12', '112', '', ''],
    ['matrix6-13', '113', '', ''],
    ['matrix6-14', '114', '', ''],
    ['matrix6-15', '115', '', ''],
    ['matrix6-16', '116', '', ''],
    ['matrix6-17', '117', '', ''],
    ['matrix6-18', '118', '', ''],
    ['matrix6-19', '119', '', ''],
    ['matrix6-20', '120', '', ''],
    ['matrix7-1', '121', '', ''],
    ['matrix7-2', '122', '', ''],
    ['matrix7-3', '123', '', ''],
    ['matrix7-4', '124', '', ''],
    ['matrix7-5', '125', '', ''],
    ['matrix7-6', '126', '', ''],
    ['matrix7-7', '127', '', ''],
    ['matrix7-8', '128', '', ''],
    ['matrix7-9', '129', '', ''],
    ['matrix7-10', '130', '', ''],
    ['matrix7-11', '131', '', ''],
    ['matrix7-12', '132', '', ''],
    ['matrix7-13', '133', '', ''],
    ['matrix7-14', '134', '', ''],
    ['matrix7-15', '135', '', ''],
    ['matrix7-16', '136', '', ''],
    ['matrix7-17', '137', '', ''],
    ['matrix7-18', '138', '', ''],
    ['matrix7-19', '139', '', ''],
    ['matrix7-20', '140', '', ''],
    ['matrix8-1', '141', '', ''],
    ['matrix8-2', '142', '', ''],
    ['matrix8-3', '143', '', ''],
    ['matrix8-4', '144', '', ''],
    ['matrix8-5', '145', '', ''],
    ['matrix8-6', '146', '', ''],
    ['matrix8-7', '147', '', ''],
    ['matrix8-8', '148', '', ''],
    ['matrix8-9', '149', '', ''],
    ['matrix8-10', '150', '', ''],
    ['matrix8-11', '151', '', ''],
    ['matrix8-12', '152', '', ''],
    ['matrix8-13', '153', '', ''],
    ['matrix8-14', '154', '', ''],
    ['matrix8-15', '155', '', ''],
    ['matrix8-16', '156', '', ''],
    ['matrix8-17', '157', '', ''],
    ['matrix8-18', '158', '', ''],
    ['matrix8-19', '159', '', ''],
    ['matrix8-20', '160', '', ''],
    ['matrix9-1', '161', '', ''],
    ['matrix9-2', '162', '', ''],
    ['matrix9-3', '163', '', ''],
    ['matrix9-4', '164', '', ''],
    ['matrix9-5', '165', '', ''],
    ['matrix9-6', '166', '', ''],
    ['matrix9-7', '167', '', ''],
    ['matrix9-8', '168', '', ''],
    ['matrix9-9', '169', '', ''],
    ['matrix9-10', '170', '', ''],
    ['matrix9-11', '171', '', ''],
    ['matrix9-12', '172', '', ''],
    ['matrix9-13', '173', '', ''],
    ['matrix9-14', '174', '', ''],
    ['matrix9-15', '175', '', ''],
    ['matrix9-16', '176', '', ''],
    ['matrix9-17', '177', '', ''],
    ['matrix9-18', '178', '', ''],
    ['matrix9-19', '179', '', ''],
    ['matrix9-20', '180', '', ''],
  ];

  BoothReadingTableDataNotifier() : super(TableDataState(_initialData));

  // Function to clear data
  void clearData() {
    state = TableDataState(_initialData);
  }

  void updateTableData(
    int col,
    int row,
    List<String> values,
  ) {
    // Adjust row and column to match the data structure's 1-based indexing
    row += 1;
    col += 1;

    // Ensure row and column are within valid range
    if (row < 1 || row > 9 || col < 1 || col > 20) {
      print('Invalid row or column value: row=$row, col=$col');
      return;
    }

    // Convert the row and column to the correct index in the list of lists
    int dataIndex = (col - 1) + (row - 1) * 20;
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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              BoothReadingDynamicTable(
                  rows: ref.watch(boothRowsProvider),
                  columns: ref.watch(boothColumnsProvider)),
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
