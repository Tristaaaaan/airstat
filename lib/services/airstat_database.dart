import 'package:airstat/models/settings_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AirstatSettingsConfiguration {
  Database? _airstatDataBase;

  Future<Database> get airstatDb async {
    if (_airstatDataBase != null) {
      return _airstatDataBase!;
    }
    _airstatDataBase = await initializeDatabase();
    return _airstatDataBase!;
  }

  Future<String> get localPath async {
    const name = 'airstat_settings.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> initializeDatabase() async {
    final path = await localPath;

    // Delete the existing database file during development
    // await deleteDatabase(path);

    return await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
  }

  Future<void> create(Database db, int version) async {
    await createAirstatSettingsTable(db);
  }

  Future<void> createAirstatSettingsTable(Database database) async {
    await database.execute(
        'CREATE TABLE IF NOT EXISTS settings (delay INTEGER, sampling INTEGER, unit TEXT, username TEXT, vent_delay INTEGER, vent_sampling INTEGER)');

    await database.insert('settings', {
      'sampling': 10,
      'vent_sampling': 10,
      'delay': 5,
      'vent_delay': 5,
      'unit': 'ft/min',
      'username': 'DefaultUser1',
    });
  }

  Future<void> insertAirstatSettingsDatabase(
      AirstatSettingsModel settings) async {
    final db = await airstatDb;
    await db.insert('settings', settings.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateAirstatSettingsDatabase(
      AirstatSettingsModel settings) async {
    final db = await airstatDb;
    await db.update(
      'settings',
      settings.toMap(),
    );
  }

  Future<AirstatSettingsModel> getAirstatSettingsDatabase() async {
    final db = await airstatDb;
    final maps = await db.query('settings');
    if (maps.isNotEmpty) {
      return AirstatSettingsModel.fromMap(maps.first);
    } else {
      return AirstatSettingsModel(
        delay: 5,
        sampling: 10,
        unit: 'f/min',
        ventDelay: 5,
        ventSampling: 10,
        username: 'DefaultUser1',
      );
    }
  }

  Stream<AirstatSettingsModel> getAirstatSettingsStream() async* {
    final db = await airstatDb;

    // Define a polling interval
    const interval = Duration(seconds: 1);

    while (true) {
      // Fetch the latest settings from the database
      final List<Map<String, dynamic>> maps = await db.query('settings');

      if (maps.isNotEmpty) {
        yield AirstatSettingsModel.fromMap(maps.first);
      }

      // Wait for the next poll
      await Future.delayed(interval);
    }
  }
}

final airstatSettingsProviderStream =
    StreamProvider<AirstatSettingsModel>((ref) {
  return AirstatSettingsConfiguration().getAirstatSettingsStream();
});
