import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedFilesNotifier extends StateNotifier<List<String>> {
  SelectedFilesNotifier() : super([]);

  void toggleSelection(String filePath) {
    if (state.contains(filePath)) {
      state = state.where((path) => path != filePath).toList();
    } else {
      state = [...state, filePath];
    }
  }

  void clearSelection() {
    state = [];
  }
}
