import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class FileListNotifier extends StateNotifier<List<String>> {
  FileListNotifier() : super([]) {
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final List<String> csvFiles = [];

    final directoryFiles = Directory(directory.path).listSync();
    for (var file in directoryFiles) {
      if (file is File && file.path.endsWith('.csv')) {
        csvFiles.add(file.path);
      }
    }
    state = csvFiles;
  }

  Future<void> refresh() async {
    await _loadFiles();
  }

  Future<void> deleteFiles(List<String> filesToDelete) async {
    for (var filePath in filesToDelete) {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await refresh(); // Refresh the list after deletion
  }
}
