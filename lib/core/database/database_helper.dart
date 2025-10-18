import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../errors/exceptions.dart';
import '../shared/app_config.dart';
import 'app_database.dart';

class DatabaseHelper {
  static AppDatabase? _database;
  static final String _dbName = AppConfig.dbName;

  static AppDatabase get database {
    _database ??= _initDB();
    return _database!;
  }

  static AppDatabase _initDB() {
    try {
      return AppDatabase();
    } catch (e) {
      throw DatabaseConnectionException(
        message: 'Failed to initialize database: $e',
      );
    }
  }

  static Future<void> closeDB() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }

  static Future<void> deleteDB() async {
    try {
      await closeDB();
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, _dbName));
      if (await file.exists()) {
        await file.delete();
      }
      _database = null;
    } catch (e) {
      throw DatabaseDeletionException(
        message: 'Failed to delete database: $e',
      );
    }
  }

  static Future<void> resetDatabase() async {
    await closeDB();
    await deleteDB();
    _database = null;
  }
}