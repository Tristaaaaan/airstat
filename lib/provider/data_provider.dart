import 'package:hooks_riverpod/hooks_riverpod.dart';

// Define the provider
final serialDataProvider =
    StateNotifierProvider<SerialDataNotifier, List<String>>((ref) {
  return SerialDataNotifier();
});

// StateNotifier implementation
class SerialDataNotifier extends StateNotifier<List<String>> {
  SerialDataNotifier() : super([]);

  void addData(String data) {
    state = [...state, data];
  }

  void clearData() {
    state = [];
  }
}

// Define the provider
final toBeSavedDataProvider =
    StateNotifierProvider<SaveDataNotifier, List<List<String>>>((ref) {
  return SaveDataNotifier();
});

// StateNotifier implementation
class SaveDataNotifier extends StateNotifier<List<List<String>>> {
  SaveDataNotifier() : super([]);

  void addData(String data) {
    state = [
      ...state,
      [data]
    ];
  }

  void clearData() {
    state = [];
  }
}
