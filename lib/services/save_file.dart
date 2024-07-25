import 'dart:io';

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
}
