import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    }
    return _db;
  }

  initialDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Tasneem.db');
    Database db = await openDatabase(path, onCreate: _onCreate, version: 2);
    return db;
  }

  _onCreate(Database db, int version) {
    Batch batch = db.batch();

    // Teacher Table
    batch.execute('''
    CREATE TABLE teachers(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    salary INTEGER NOT NULL
    );
    ''');

    // Student Table
    batch.execute('''
    CREATE TABLE students(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    subscription INTEGER NOT NULL,
    phoneNumber TEXT NOT NULL,
    idTeacher INTEGER NOT NULL,
    FOREIGN KEY (idTeacher) REFERENCES `teachers`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
    );
    ''');

    // Subscriptions Table
    batch.execute('''
     CREATE TABLE subscriptions(
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     idStudent INTEGER NOT NULL,
     money INTEGER NOT NULL,
     date TEXT NOT NULL,
     FOREIGN KEY (idStudent) REFERENCES `students`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
     );
    ''');

    batch.commit();
  }

  dbDelete() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Tasneem.db');
    await deleteDatabase(path);
  }

  Future<List<Map>> readData(String tableName) async {
    Database? data = await db;
    List<Map<String, Object?>> res = await data!.query(tableName);
    return res;
  }

  Future<int> insertData(
      String tableName, Map<String, Object?> dateInserted) async {
    Database? data = await db;
    int res = await data!.insert(tableName, dateInserted);
    return res;
  }

  Future<int> updateData(
      String tableName, Map<String, Object?> dateUpdated, String where) async {
    Database? data = await db;
    int res = await data!.update(tableName, dateUpdated, where: where);
    return res;
  }

  Future<int> deleteData(String tableName, String where) async {
    Database? data = await db;
    int res = await data!.delete(tableName, where: where);
    return res;
  }

  readSql(String sql) async {
    Database? data = await db;
    List<Map<String, Object?>> res = await data!.rawQuery(sql);
    return res;
  }
}
