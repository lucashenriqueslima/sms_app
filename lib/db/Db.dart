import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class Db {
  static Future<sql.Database> database(creteSql) async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'smsdata.db'),
      onCreate: (db, version) {
        return db.execute(creteSql);
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(
      String createTable, String query) async {
    final db = await Db.database(createTable);
    try {
      return db.rawQuery(query);
    } catch (_) {
      return [];
    }
  }

  static Future<void> insert(
      String createTable, String table, Map<String, dynamic> data) async {
    final db = await Db.database(createTable);
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteData(createTable, sql) async {
    final db = await Db.database(createTable);
    db.rawDelete(sql);
  }
}
