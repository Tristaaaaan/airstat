import 'dart:convert';
import 'dart:io';
import 'dart:math';

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

  Future<File> writeContent() async {
    try {
      final file = await _localFile;
      // Write the file
      return file.writeAsString('Hello Folks');
    } catch (e) {
      print('Error writing file: $e');
      return Future.error(e);
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

    if (selectedFiles.isEmpty) {
      // Handle the case where no files are selected
      return false;
    }

    // Generate random data for the CSV
    List<List<dynamic>> rows = generateRandomData();

    String csv = const ListToCsvConverter().convert(rows);

    if (!await FlutterFileDialog.isPickDirectorySupported()) {
      return false;
    }

    final pickedDirectory = await FlutterFileDialog.pickDirectory();
    print("Picked directory: $pickedDirectory");
    if (pickedDirectory != null) {
      try {
        for (String filePath in selectedFiles) {
          await FlutterFileDialog.saveFileToDirectory(
            directory: pickedDirectory,
            data: utf8.encode(csv), // Encode CSV string to bytes
            mimeType: "text/csv", // Set MIME type for CSV files
            fileName: filePath, // Set CSV file name
            replace: true,
          );
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

// Function to generate random data
  List<List<dynamic>> generateRandomData() {
    Random random = Random();
    List<List<dynamic>> rows = [];

    // Define the headers
    List<String> headers = ["ID", "Name", "Value"];
    rows.add(headers);

    // Generate 10 rows of random data
    for (int i = 0; i < 10; i++) {
      List<dynamic> row = [];
      row.add(i + 1); // ID
      row.add("Item ${i + 1}"); // Name
      row.add(random.nextInt(100)); // Random Value
      rows.add(row);
    }

    return rows;
  }
}
