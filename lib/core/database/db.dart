import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tasneem_sba7ie/core/database/tabels_name.dart';

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

    // Absences Table
    batch.execute('''
    CREATE TABLE absences(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    teacherId INTEGER NOT NULL,
    month TEXT NOT NULL,
    daysAbsent INTEGER NOT NULL DEFAULT 0,
    discounts INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (teacherId) REFERENCES `teachers`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
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

  // --------------- subscriptions CRUD -------------------------
  Future<int> setStudentSubscription(
      int studentId, int money, String date) async {
    Database? data = await db;

    return await data!.insert(
      subscriptionsTable,
      {'idStudent': studentId, 'money': money, 'date': date},
    );
  }

  Future<List<Map>> getStudentSubscriptionsById(int studentId) async {
    Database? data = await db;
    List<Map<String, Object?>> res = await data!.query(
      'subscriptions',
      where: 'idStudent = ?',
      whereArgs: [studentId],
      orderBy: 'date DESC',
    );
    return res;
  }

  Future<List<Map>> getAllStudentSubscriptions() async {
    Database? data = await db;
    List<Map<String, Object?>> res = await data!.query(
      'subscriptions',
      orderBy: 'date DESC',
    );
    return res;
  }

  Future<int> deleteAllStudentSubscriptions(int studentId) async {
    Database? data = await db;
    int res = await data!.delete(
      'subscriptions',
      where: 'idStudent = ?',
      whereArgs: [studentId],
    );
    return res;
  }

  Future<int> deleteStudentSubscriptionByDate(
      int studentId, String date) async {
    Database? data = await db;
    int res = await data!.delete(
      'subscriptions',
      where: 'idStudent = ? AND date = ?',
      whereArgs: [studentId, date],
    );
    return res;
  }

  //--------------- absences CRUD -------------------------

  Future<int> setTeacherAbsence(
      int teacherId, String month, int daysAbsent, int discounts) async {
    Database? data = await db;
    List<Map<String, Object?>> existingAbsence = await data!.query(
      'absences',
      where: 'teacherId = ? AND month = ?',
      whereArgs: [teacherId, month],
    );

    if (existingAbsence.isNotEmpty) {
      return await data.update(
        'absences',
        {'daysAbsent': daysAbsent, 'discounts': discounts},
        where: 'teacherId = ? AND month = ?',
        whereArgs: [teacherId, month],
      );
    } else {
      return await data.insert(
        'absences',
        {
          'teacherId': teacherId,
          'month': month,
          'daysAbsent': daysAbsent,
          'discounts': discounts
        },
      );
    }
  }

  Future<List<Map>> getAllTeacherAbsences(int teacherId) async {
    Database? data = await db;
    List<Map<String, Object?>> res = await data!.query(
      'absences',
      where: 'teacherId = ?',
      whereArgs: [teacherId],
      orderBy: 'month DESC',
    );
    return res;
  }

  Future<int> deleteTeacherAbsences({
    required int teacherId,
    String? month, // Make month optional
  }) async {
    Database? data = await db;
    int rowsDeleted = 0;

    if (month != null && month.isNotEmpty) {
      // Delete for a specific month
      rowsDeleted = await data!.delete(
        'absences',
        where: 'teacherId = ? AND month = ?',
        whereArgs: [teacherId, month],
      );
    } else {
      // Delete all absences for the teacher
      rowsDeleted = await data!.delete(
        'absences',
        where: 'teacherId = ?',
        whereArgs: [teacherId],
      );
    }
    return rowsDeleted;
  }

  Future<List<Map<String, dynamic>>> getTeachersWithAbsencesForMonth(
      String monthYear) async {
    Database? data = await db;
    List<Map<String, Object?>> res = await data!.rawQuery('''
      SELECT
        t.id,
        t.name,
        t.salary,
        IFNULL(a.daysAbsent, 0) AS daysAbsent,
        IFNULL(a.discounts, 0) AS discounts
      FROM
        teachers t
      LEFT JOIN
        absences a ON t.id = a.teacherId AND a.month = ?
    ''', [monthYear]);

    return res.map((e) => e.map((key, value) => MapEntry(key, value))).toList();
  }

  Future<Map<String, int>> getTeacherAbsenceAndDiscounts(
      int teacherId, String month) async {
    Database? data = await db;
    List<Map<String, Object?>> res = await data!.query(
      'absences',
      columns: ['daysAbsent', 'discounts'],
      where: 'teacherId = ? AND month = ?',
      whereArgs: [teacherId, month],
    );
    if (res.isNotEmpty) {
      return {
        'daysAbsent': res.first['daysAbsent'] as int,
        'discounts': res.first['discounts'] as int,
      };
    }
    return {'daysAbsent': 0, 'discounts': 0};
  }
}
