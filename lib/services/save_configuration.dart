import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SaveConfiguration {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    final DateTime now = DateTime.now();

    return File('$path/$fileName-$now.csv');
  }

  Future<File?> writeConfigurationContent(
      String fileName, String content) async {
    String csvContent = '''HAHAHAHAHA''';
    final DateTime now = DateTime.now();
    fileName = now.toString();
    final file = await _localFile(fileName);
    return file.writeAsString(csvContent);
  }
}
