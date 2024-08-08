import 'package:airstat/services/airstat_database.dart';
import 'package:airstat/services/space_definitions_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final airstatDatabaseProvider =
    StateProvider<AirstatSettingsConfiguration>((ref) {
  return AirstatSettingsConfiguration();
});

final airstatSpaceDefinitionProvider =
    StateProvider<SpaceDefinitionsDatabase>((ref) {
  return SpaceDefinitionsDatabase();
});
