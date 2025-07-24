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

  Future<int> deleteTeacherAbsenceByMonth({
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

  Future<int> deleteAllTeacherAbsences(int teacherId) async {
    try {
      // This method reuses the logic from deleteTeacherAbsenceByMonth
      // by simply not providing a 'month' value.
      int rowsDeleted = await deleteTeacherAbsenceByMonth(
        teacherId: teacherId,
        month: null, // Explicitly pass null to delete all for the teacher
      );
      return rowsDeleted;
    } catch (e) {
      print('Error deleting all teacher absences: $e');
      return 0; // Return 0 rows deleted on error
    }
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

  //--------------- Financial Summary -------------------------

  Future<Map<String, int>> getFinancialSummary() async {
    Database? data = await db;

    // Get total subscription from students table
    List<Map<String, dynamic>> studentSubscriptionResult = await data!.rawQuery(
      'SELECT SUM(subscription) AS totalSubscription FROM students',
    );
    double totalStudentSubscription = studentSubscriptionResult.isNotEmpty
        ? (studentSubscriptionResult.first['totalSubscription'] as num?)
                ?.toDouble() ??
            0.0
        : 0.0;

    // Get total money from subscriptions table
    List<Map<String, dynamic>> moneySubscriptionResult = await data.rawQuery(
      'SELECT SUM(money) AS totalMoney FROM subscriptions',
    );
    double totalMoneyFromSubscriptions = moneySubscriptionResult.isNotEmpty
        ? (moneySubscriptionResult.first['totalMoney'] as num?)?.toDouble() ??
            0.0
        : 0.0;

    // Calculate the remain (unpaid subscriptions)
    double remain = totalStudentSubscription - totalMoneyFromSubscriptions;

    // Ensure remain is non-negative for pie chart
    if (remain < 0) {
      remain = 0.0; // Prevent negative values for visualization
    }

    return {
      'totalStudentSubscription': totalStudentSubscription.toInt(),
      'totalMoneyFromSubscriptions': totalMoneyFromSubscriptions.toInt(),
      'remain': remain.toInt(),
    };
  }

  Future<List<Map<String, dynamic>>> getStudentReportByTeacherID(
      int teacherId) async {
    Database? data = await db;
    List<Map<String, Object?>> res = await data!.rawQuery('''
      SELECT
        s.id,
        s.name,
        s.subscription,
        s.idTeacher,
        IFNULL(SUM(sub.money), 0) AS totalPaid,
        (s.subscription - IFNULL(SUM(sub.money), 0)) AS remaining
      FROM students AS s
      LEFT JOIN subscriptions AS sub
        ON s.id = sub.idStudent
      WHERE s.idTeacher = ?
      GROUP BY
        s.id,
        s.name,
        s.subscription,
        s.idTeacher;
    ''', [teacherId]);

    return res.map((e) => e.map((key, value) => MapEntry(key, value))).toList();
  }

  Future<List<Map<String, dynamic>>> getStudentPaymentsByDateRange(
      DateTime startDate, DateTime endDate) async {
    Database? data = await db;

    // Format dates as dd-MM-yyyy to match the database format
    String startDateStr =
        "${startDate.day.toString().padLeft(2, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.year}";
    String endDateStr =
        "${endDate.day.toString().padLeft(2, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.year}";

    List<Map<String, Object?>> res = await data!.rawQuery('''
    SELECT
      s.id AS studentId,
      s.name AS studentName,
      t.name AS teacherName,
      sub.money AS moneyPaid,
      sub.date
    FROM subscriptions AS sub
    JOIN students AS s ON sub.idStudent = s.id
    JOIN teachers AS t ON s.idTeacher = t.id
    WHERE 
      DATE(SUBSTR(sub.date, 7, 4) || '-' || SUBSTR(sub.date, 4, 2) || '-' || SUBSTR(sub.date, 1, 2)) 
      BETWEEN 
      DATE(SUBSTR(?, 7, 4) || '-' || SUBSTR(?, 4, 2) || '-' || SUBSTR(?, 1, 2))
      AND 
      DATE(SUBSTR(?, 7, 4) || '-' || SUBSTR(?, 4, 2) || '-' || SUBSTR(?, 1, 2))
    ORDER BY 
      DATE(SUBSTR(sub.date, 7, 4) || '-' || SUBSTR(sub.date, 4, 2) || '-' || SUBSTR(sub.date, 1, 2)) DESC;
  ''', [
      startDateStr,
      startDateStr,
      startDateStr,
      endDateStr,
      endDateStr,
      endDateStr,
    ]);

    return res.map((e) => e.map((key, value) => MapEntry(key, value))).toList();
  }

  Future<List<Map<String, dynamic>>> getTeacherSalaryReportForMonth(
      String monthYear) async {
    Database? data = await db;

    List<Map<String, Object?>> res = await data!.rawQuery('''
    SELECT
      t.id,
      t.name AS teacherName,
      t.salary,
      IFNULL(a.daysAbsent, 0) AS daysAbsent,
      IFNULL(a.discounts, 0) AS discounts
    FROM
      teachers t
    LEFT JOIN
      absences a ON t.id = a.teacherId AND a.month = ?
    ORDER BY t.name
  ''', [monthYear]);

    return res.map((e) => e.map((key, value) => MapEntry(key, value))).toList();
  }
}
