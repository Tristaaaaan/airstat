import 'package:airstat/notifiers/file_list_notifier.dart';
import 'package:airstat/notifiers/selected_files_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedFilesProvider =
    StateNotifierProvider<SelectedFilesNotifier, List<String>>(
  (ref) => SelectedFilesNotifier(),
);

final fileListProvider = StateNotifierProvider<FileListNotifier, List<String>>(
  (ref) => FileListNotifier(),
);
