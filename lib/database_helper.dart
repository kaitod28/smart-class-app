import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static Database? _database;

  static Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {

    String path = join(await getDatabasesPath(), 'smart_class.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        await db.execute('''
        CREATE TABLE checkin(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          previousTopic TEXT,
          expectedTopic TEXT,
          mood TEXT,
          location TEXT,
          qr TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE finish(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          learned TEXT,
          feedback TEXT,
          location TEXT,
          qr TEXT
        )
        ''');

      },
    );
  }

  static Future<void> insertCheckin(Map<String, dynamic> data) async {

    final db = await database;

    await db.insert(
      "checkin",
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertFinish(Map<String, dynamic> data) async {

    final db = await database;

    await db.insert(
      "finish",
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}