import 'package:airstat/models/space_definition_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SpaceDefinitionsDatabase {
  Database? _spaceDefinitionDataBase;

  Future<Database> get spaceDefinitionDb async {
    if (_spaceDefinitionDataBase != null) {
      return _spaceDefinitionDataBase!;
    }
    _spaceDefinitionDataBase = await initializeDatabase();
    return _spaceDefinitionDataBase!;
  }

  Future<String> get localPath async {
    const name = 'space_definitions.db';
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
    await createSpaceDefinitionsTable(db);
  }

  Future<void> createSpaceDefinitionsTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS spaceDefinitions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ID1 TEXT,
        ID2 TEXT,
        ID3 TEXT,
        ID4 TEXT,
        Units TEXT,
        Mode TEXT,
        Type TEXT,
        X_Rows INTEGER,
        Y_ReadPerRow INTEGER,
        Z_Sil_Width INTEGER,
        Sil_Height INTEGER,
        Target_DD INTEGER,
        Target_side INTEGER,
        Var_DD INTEGER,
        Var_CD INTEGER,
        tbd1 INTEGER,
        tbd2 INTEGER
      )
    ''');
  }

  Future<int> insertConfiguration(Configuration config) async {
    final db = await spaceDefinitionDb;
    return await db.insert('spaceDefinitions', config.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Configuration>> getAllConfigurations() async {
    final db = await spaceDefinitionDb;
    final List<Map<String, dynamic>> maps = await db.query('spaceDefinitions');

    return List.generate(maps.length, (i) {
      return Configuration.fromMap(maps[i]);
    });
  }

  Future<bool> checkConfigurationReadingModeSpecific(
      String readingMode,
      String id1,
      String id2,
      String id3,
      String id4,
      bool edit,
      int? id) async {
    final db = await spaceDefinitionDb;
    if (edit) {
      // Query the database with a WHERE clause to filter by readingMode
      final List<Map<String, dynamic>> maps = await db.query(
        'spaceDefinitions',
        where: 'Mode = ?', // The WHERE clause
        whereArgs: [readingMode], // The arguments for the WHERE clause
      );

      // Generate a list of Configuration objects from the query results
      final List<Configuration> configurations =
          List.generate(maps.length, (i) {
        return Configuration.fromMap(maps[i]);
      });

      // Check if any configuration matches the provided id1, id2, id3, id4
      for (var config in configurations) {
        if (config.id1 == id1 &&
            config.id2 == id2 &&
            config.id3 == id3 &&
            config.id4 == id4 &&
            config.id != id) {
          return true; // Return true if a match is found
        }
      }
    } else {
      // Query the database with a WHERE clause to filter by readingMode
      final List<Map<String, dynamic>> maps = await db.query(
        'spaceDefinitions',
        where: 'Mode = ?', // The WHERE clause
        whereArgs: [readingMode], // The arguments for the WHERE clause
      );

      // Generate a list of Configuration objects from the query results
      final List<Configuration> configurations =
          List.generate(maps.length, (i) {
        return Configuration.fromMap(maps[i]);
      });

      // Check if any configuration matches the provided id1, id2, id3, id4
      for (var config in configurations) {
        if (config.id1 == id1 &&
            config.id2 == id2 &&
            config.id3 == id3 &&
            config.id4 == id4) {
          return true; // Return true if a match is found
        }
      }
    }

    return false; // Return false if no match is found
  }

  Future<Configuration?> getConfiguration(Configuration config) async {
    final db = await spaceDefinitionDb;
    final List<Map<String, dynamic>> maps = await db.query(
      'spaceDefinitions',
      where: 'id = ?',
      whereArgs: [config.id],
    );

    if (maps.isNotEmpty) {
      return Configuration.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateConfiguration(Configuration config) async {
    final db = await spaceDefinitionDb;
    return await db.update(
      'spaceDefinitions',
      config.toMap(),
      where: 'id = ?',
      whereArgs: [config.id],
    );
  }

  Future<int> deleteConfiguration(Configuration config) async {
    final db = await spaceDefinitionDb;
    return await db.delete(
      'spaceDefinitions',
      where: 'id = ?',
      whereArgs: [config.id],
    );
  }

  Stream<List<Configuration>> getAirstatSpaceDefinitionStream() async* {
    final db = await spaceDefinitionDb;

    // Define a polling interval
    const interval = Duration(seconds: 1);

    while (true) {
      try {
        // Fetch the latest settings from the database
        final List<Map<String, dynamic>> maps =
            await db.query('spaceDefinitions');

        if (maps.isNotEmpty) {
          yield maps.map((map) => Configuration.fromMap(map)).toList();
        } else {
          yield [];
        }
      } catch (e) {
        print('Error fetching space definitions: $e');
        yield [];
      }

      // Wait for the next poll
      await Future.delayed(interval);
    }
  }
}

final airstatSpaceDefinitionProviderStream =
    StreamProvider<List<Configuration>>((ref) {
  return SpaceDefinitionsDatabase().getAirstatSpaceDefinitionStream();
});
