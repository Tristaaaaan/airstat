import 'dart:convert';
import 'dart:io';

import 'package:airstat/main/files/file_page.dart';
import 'package:airstat/provider/configure_files_provider.dart';
import 'package:csv/csv.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class SaveFiles {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    final DateTime now = DateTime.now();

    return File('$path/$fileName-$now.csv');
  }

  Future<File?> writeContent(
    String fileName,
    String unit,
    String readingMode,
    DateTime currentDate,
    DateTime lastUpdate,
    String data,
    String numSampling,
    String delay,
    String zoneId, // id 4
    String site, // id 1
    String shop, // id 2
    String line, // id 3
    String entranceSilhoutte,
    String boothReading,
    String exitSilhouette,
  ) async {
    try {
      final file = await _localFile(fileName);

      // CONTINUOUS
      if (readingMode == 'continuous') {
        String csvContent =
            '''datetime: 2021-03-06_01:02:31, lastupdate: 2021-03-06_01:02:31, filename: $fileName.csv, id1: --.--, id2: --.--, id3: --.--, id4: $zoneId, mode: $readingMode, type: --.-, reading_rows: --.-, readings_per_row: --.-, levels: --.-, sil_height: --.-, target_dd: --.-, target_side: --.-, var_dd: --.-, var_cd: --.-, user/identification: --.-, num_sampling: $numSampling, delay: $delay, unit: $unit, hash: --.-, asset: --.-, app_version: --.-, data: $data, notes: --.-''';

        return await file.writeAsString(csvContent);

        // RANDOM
      } else if (readingMode == 'random') {
        String csvContent =
            '''datetime: 2021-03-06_01:02:31, lastupdate: 2021-03-06_01:02:31, filename: $fileName.csv, id1: $site, id2: $shop, id3: $line, id4: $zoneId, mode: $readingMode, type: --.-, reading_rows: --.-, readings_per_row: --.-, levels: --.-, sil_height: --.-, target_dd: --.-, target_side: --.-, var_dd: --.-, var_cd: --.-, user/identification: --.-, num_sampling: $numSampling, delay: $delay, unit: $unit, hash: --.-, asset: --.-, app_version: --.-, data: $data, notes: --.-''';

        return await file.writeAsString(csvContent);

        // BOOTH
      } else if (readingMode == 'booth') {
        String csvContent =
            '''datetime: 2021-03-06_01:02:31, lastupdate: 2021-03-06_01:02:31, filename: $fileName.csv, id1: $site, id2: $shop, id3: $line, id4: $zoneId, mode: $readingMode, type: --.-, reading_rows: --.-, readings_per_row: --.-, levels: --.-, sil_height: --.-, target_dd: --.-, target_side: --.-, var_dd: --.-, var_cd: --.-, user/identification: --.-, num_sampling: $numSampling, delay: $delay, unit: $unit, hash: --.-, asset: --.-, app_version: --.-, data: [booth_reading: $boothReading, entrance_silhouette: $entranceSilhoutte,  exit_silhouette: $exitSilhouette], notes: --.-''';

        return await file.writeAsString(csvContent);
      } else {
        return file;
      }
    } catch (e) {
      print('Error writing file: $e');
      return null;
    }
  }

  Future<bool> exportCSV(WidgetRef ref) async {
    final selectedFiles = ref.read(selectedFilesProvider);
    final fileContentMap = ref.read(fileContentProvider);

    if (selectedFiles.isEmpty) {
      // Handle the case where no files are selected
      return false;
    }

    if (!await FlutterFileDialog.isPickDirectorySupported()) {
      return false;
    }

    final pickedDirectory = await FlutterFileDialog.pickDirectory();

    if (pickedDirectory != null) {
      try {
        for (String filePath in selectedFiles) {
          final fileContent = fileContentMap[filePath];
          String dataNotes = "";
          String data = "";
          String mode = "";
          String entranceSilhouette = "";
          String boothReading = "";
          String exitSilhouette = "";
          if (fileContent != null) {
            RegExp regExp = RegExp(r'mode:\s*([^,]+)');
            Match? match = regExp.firstMatch(fileContent);
            List<List<dynamic>> rows = [];
            if (match != null) {
              String modeValue = match.group(1)!.trim();
              mode = modeValue;
            } else {
              print('Mode not found');
            }

            // Split the content string into key-value pairs
            List<String> pairs = fileContent.split(", ");
            for (String pair in pairs) {
              int separatorIndex = pair.indexOf(": ");
              if (separatorIndex != -1) {
                String key = pair.substring(0, separatorIndex);
                String value = pair.substring(separatorIndex + 2);
                print("Key: $key, Value: $value");
                if (key != "data" &&
                    key != "notes" &&
                    key != "entrance_silhouette" &&
                    key != " exit_silhouette") {
                  rows.add([key, value]);
                } else if (key == "notes") {
                  dataNotes = value;
                }
              }
            }

            if (mode == "random" || mode == "continuous") {
              print("MODE: $mode");
              // Define a RegExp to match the 'data' field
              final RegExp dataRegExp = RegExp(r'data:\s*(\[\[.*?\]\])');

              // Search for the pattern in the csvContent
              final dataMatch = dataRegExp.firstMatch(fileContent);
              // Convert string to List<List<dynamic>>
              print("DATA: $dataMatch");
              if (match != null) {
                // Extract the data value from the match
                data = dataMatch!.group(1)!;
              } else {
                print("Data field not found.");
              }
              List<List<dynamic>> dataList = List<List<dynamic>>.from(
                  json.decode(data).map((item) => List<dynamic>.from(item)));

              // Create a new list with the condition applied
              List<List<dynamic>> newList = List.from(dataList);
              rows.add(['data_point', 'pos', 'dd', 'cd']);
              // Add new data with `data_point` equal to 'DefaultUser1'
              for (var data in newList) {
                rows.add(['DefaultUser1', data[0], data[1], data[2]]);
              }

              // Print the result to verify
              print("dataList: $dataList");

              print("Notes: $dataNotes");
              rows.add(['notes', '--.-']);
            } else if (mode == "booth") {
              print("MODE: $mode");
              // Define a RegExp to match the 'data' field
              final RegExp dataRegExp = RegExp(r'data:\s*(\[.*?\])');

              // Search for the pattern in the csvContent
              final dataMatch = dataRegExp.firstMatch(fileContent);
              // Convert string to List<List<dynamic>>
              print("DATA: $dataMatch");
              if (match != null) {
                // Extract the data value from the match
                data = dataMatch!.group(1)!;
              } else {
                print("Data field not found.");
              }

              // Regular expression to extract the data arrays
              RegExp boothReadingRegExp = RegExp(
                  r'booth_reading:\s*(\[\[.*?\]\](?=,|]))',
                  dotAll: true);
              RegExp exitSilhouetteRegExp = RegExp(
                  r'exit_silhouette:\s*(\[\[.*?\]\](?=,|]))',
                  dotAll: true);
              RegExp entranceSilhouetteRegExp = RegExp(
                  r'entrance_silhouette:\s*(\[\[.*?\]\](?=,|]))',
                  dotAll: true);

              // Extract the booth_reading data
              Match? boothReadingMatch =
                  boothReadingRegExp.firstMatch(fileContent);
              if (boothReadingMatch != null) {
                boothReading = boothReadingMatch.group(1)!;
              } else {
                print('Booth Reading not found');
              }

              // Extract the exit_silhouette data
              Match? exitSilhouetteMatch =
                  exitSilhouetteRegExp.firstMatch(fileContent);
              if (exitSilhouetteMatch != null) {
                exitSilhouette = exitSilhouetteMatch.group(1)!;
              } else {
                print('Exit Silhouette not found');
              }

              // Extract the entrance_silhouette data
              Match? entranceSilhouetteMatch =
                  entranceSilhouetteRegExp.firstMatch(fileContent);
              if (entranceSilhouetteMatch != null) {
                entranceSilhouette = entranceSilhouetteMatch.group(1)!;
              } else {
                print('Entrance Silhouette not found');
              }
              print("exitSilhouette: $exitSilhouette");

              // ENTRANCE SILHOUETTE
              String entranceSilhouetteDataString = entranceSilhouette
                  .substring(1, entranceSilhouette.length - 1);

              // Split string into individual rows based on the delimiter
              List<String> entranceSilhouetteRows = entranceSilhouetteDataString
                  .split(RegExp(r'\s*,\s*(?=\[)|\s*,\s*(?=\[)'));

              // Process each row
              List<List<dynamic>> entranceSilhouetteList =
                  entranceSilhouetteRows.map((row) {
                // Remove potential brackets and trim spaces
                row = row.replaceAll(RegExp(r'^\[|\]$'), '').trim();

                // Split row into cells
                List<dynamic> cells =
                    row.split(RegExp(r',\s*(?![^[]*\])')).map((cell) {
                  // Remove any extra spaces
                  cell = cell.trim();

                  // Convert empty strings to null
                  if (cell.isEmpty) {
                    return null;
                  }

                  // Convert numbers to int
                  var number = int.tryParse(cell);
                  if (number != null) {
                    return number;
                  }

                  // Return the cell as is for strings
                  return cell;
                }).toList();

                return cells;
              }).toList();

              // BOOTH READING

              String boothReadingDataString =
                  boothReading.substring(1, boothReading.length - 1);

              // Split string into individual rows based on the delimiter
              List<String> boothReadingRows = boothReadingDataString
                  .split(RegExp(r'\s*,\s*(?=\[)|\s*,\s*(?=\[)'));

              // Process each row
              List<List<dynamic>> boothReadingList =
                  boothReadingRows.map((row) {
                // Remove potential brackets and trim spaces
                row = row.replaceAll(RegExp(r'^\[|\]$'), '').trim();

                // Split row into cells
                List<dynamic> cells =
                    row.split(RegExp(r',\s*(?![^[]*\])')).map((cell) {
                  // Remove any extra spaces
                  cell = cell.trim();

                  // Convert empty strings to null
                  if (cell.isEmpty) {
                    return null;
                  }

                  // Convert numbers to int
                  var number = int.tryParse(cell);
                  if (number != null) {
                    return number;
                  }

                  // Return the cell as is for strings
                  return cell;
                }).toList();

                return cells;
              }).toList();

              // EXIT SILHOUETTE
              // Remove outer brackets
              String dataString =
                  exitSilhouette.substring(1, exitSilhouette.length - 1);

              // Split string into individual rows based on the delimiter
              List<String> rowss =
                  dataString.split(RegExp(r'\s*,\s*(?=\[)|\s*,\s*(?=\[)'));

              // Process each row
              List<List<dynamic>> exitSilhouetteList = rowss.map((row) {
                // Remove potential brackets and trim spaces
                row = row.replaceAll(RegExp(r'^\[|\]$'), '').trim();

                // Split row into cells
                List<dynamic> cells =
                    row.split(RegExp(r',\s*(?![^[]*\])')).map((cell) {
                  // Remove any extra spaces
                  cell = cell.trim();

                  // Convert empty strings to null
                  if (cell.isEmpty) {
                    return null;
                  }

                  // Convert numbers to int
                  var number = int.tryParse(cell);
                  if (number != null) {
                    return number;
                  }

                  // Return the cell as is for strings
                  return cell;
                }).toList();

                return cells;
              }).toList();

              for (var data in entranceSilhouetteList) {
                rows.add([data[0], data[1], data[2] ?? '', data[3] ?? '']);
              }

              for (var data in boothReadingList) {
                rows.add([data[0], data[1], data[2] ?? '', data[3] ?? '']);
              }

              for (var data in exitSilhouetteList) {
                rows.add([data[0], data[1], data[2] ?? '', data[3] ?? '']);
              }
              print("data: $exitSilhouetteList");
              rows.add(['notes', '--.-']);
            }
            // Convert the list of lists into CSV format
            String csv = const ListToCsvConverter().convert(rows);

            await FlutterFileDialog.saveFileToDirectory(
              directory: pickedDirectory,
              data: utf8.encode(csv), // Encode CSV string to bytes
              mimeType: "text/csv", // Set MIME type for CSV files
              fileName:
                  '${filePath.split('/').last}.csv', // Use the file's name with .csv extension
              replace: true,
            );
          }
        }
        return true;
      } catch (e) {
        print("Error exporting files: $e");
        return false;
      }
    } else {
      return false;
    }
  }
}
