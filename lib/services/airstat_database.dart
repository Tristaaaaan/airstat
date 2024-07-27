import 'package:airstat/models/settings_model.dart';
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
        'CREATE TABLE IF NOT EXISTS settings (delay INTEGER, sampling INTEGER, unit TEXT)');
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

  Future<List<Map<String, dynamic>>> getAirstatSettingsDatabase() async {
    final db = await airstatDb;
    return await db.query('settings');
  }
}
