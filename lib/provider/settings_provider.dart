import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsState {
  final String selectedValue;

  SettingsState(this.selectedValue);
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState(""));

  void selectValue(String value) {
    state = SettingsState(value);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
