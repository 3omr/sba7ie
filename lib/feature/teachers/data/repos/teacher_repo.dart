import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/sql_database/db.dart';
import 'package:tasneem_sba7ie/sql_database/tabels_name.dart'; // Make sure this contains your table names

class TeacherRepo {
  final Db _db;

  TeacherRepo(this._db);

  // --- Core Teacher CRUD Operations ---

  // Fetches basic teacher data (for a general list, likely without absence details)
  Future<List<Teacher>> getTeachers() async {
    List<Map> resp = await _db.readData(teachersTable);
    // Assuming Teacher.fromMap can handle cases where absence data isn't present
    // by defaulting to 0, or you might need a specific 'fromBasicMap' factory.
    return resp.map((e) => Teacher.fromJson(e)).toList();
  }

  Future<int> addTeacher(Teacher teacher) async {
    // Use the specific toMapForDb() method from the Teacher model
    int resp = await _db.insertData(teachersTable, teacher.toJson());
    return resp;
  }

  Future<int> updateTeacher(
      Teacher oldTeacherData, Teacher newTeacherData) async {
    // Use the specific toMapForDb() method from the Teacher model
    int resp = await _db.updateData(teachersTable, newTeacherData.toJson(),
        "id = ${oldTeacherData.id}");
    return resp;
  }

  Future<int> deleteTeacher(int teacherId) async {
    // Note: Due to ON DELETE CASCADE, deleting a teacher will automatically
    // delete all their associated absence records.
    int resp = await _db.deleteData(teachersTable, "id = $teacherId");
    return resp;
  }

  // --- Absence Management Operations (New Additions) ---

  // Gets all teachers along with their absence/late days for a specific month
  Future<List<Teacher>> getTeachersWithAbsenceForMonth(String monthYear) async {
    List<Map<String, dynamic>> resp =
        await _db.getTeachersWithAbsencesForMonth(monthYear);
    // Use Teacher.fromMap to populate the Teacher object with absence/late day info
    return resp.map((e) => Teacher.fromJson(e)).toList();
  }

  // Adds or updates absence and late days for a teacher for a given month
  Future<int> setTeacherAbsenceAndLateDays(
      int teacherId, String month, int daysAbsent, int lateDays) async {
    return await _db.setTeacherAbsence(teacherId, month, daysAbsent, lateDays);
  }

  // Retrieves absence and late days for a specific teacher and month
  Future<Map<String, int>> getTeacherAbsenceAndLateDays(
      int teacherId, String month) async {
    return await _db.getTeacherAbsenceAndLateDays(teacherId, month);
  }

  // Fetches all absence records for a specific teacher across all months
  Future<List<Map>> getAllTeacherAbsences(int teacherId) async {
    return await _db.getAllTeacherAbsences(teacherId);
  }

  // Deletes a specific absence record by its ID
  Future<int> deleteAbsenceRecord(int absenceId) async {
    return await _db.deleteAbsenceRecord(absenceId);
  }
}
