import 'package:airstat/services/save_configuration.dart';
import 'package:airstat/services/save_file.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final saveDataServicesProvider = StateProvider.autoDispose<SaveFiles>((ref) {
  return SaveFiles();
});

final saveDataConfigurationServicesProvider =
    StateProvider.autoDispose<SaveConfiguration>((ref) {
  return SaveConfiguration();
});
