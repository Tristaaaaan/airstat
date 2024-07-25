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
    // For your reference print the AppDoc directory
    print('Directory path: ${directory.path}');
    return directory.path;
  }

  Future<File> get _localFile async {
    final fileName = DateTime.now()
        .toIso8601String(); // Use ISO 8601 format for the file name
    final path = await _localPath;
    return File('$path/$fileName.csv'); // Corrected the file path construction
  }

  Future<File?> writeContent(
    String readingMode,
    DateTime currentDate,
    DateTime lastUpdate,
  ) async {
    try {
      final file = await _localFile;
      if (readingMode == 'continuous') {
        String csvContent =
            '''dateTime: $currentDate, lastUpdate: $lastUpdate''';
        // Write the file
        return await file.writeAsString(csvContent);
      } else {
        // Return the file without writing if not in continuous mode
        return file;
      }
    } catch (e) {
      print('Error writing file: $e');
      return null;
    }
  }

  Future<String> readContent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      // If there is an error reading, return a default String
      print('Error reading file: $e');
      return 'Error';
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
    print("Picked directory: $pickedDirectory");
    if (pickedDirectory != null) {
      try {
        for (String filePath in selectedFiles) {
          final fileContent = fileContentMap[filePath];
          if (fileContent != null) {
            // Prepare the data for CSV
            List<List<dynamic>> rows = [];

            // Add each file's content as a new row
            rows.add([fileContent]);

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
