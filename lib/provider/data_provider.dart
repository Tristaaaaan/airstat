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

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});
