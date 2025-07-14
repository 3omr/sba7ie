import 'package:tasneem_sba7ie/core/helper/result.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/sql_database/db.dart';
import 'package:tasneem_sba7ie/sql_database/tabels_name.dart'; // Make sure this contains your table names

class TeacherRepo {
  final Db _db;

  TeacherRepo(this._db);

  // Fetches basic teacher data (for a general list, likely without absence details)
  Future<Result<List<Teacher>>> getTeachers() async {
    // Assuming Teacher.fromMap can handle cases where absence data isn't present
    // by defaulting to 0, or you might need a specific 'fromBasicMap' factory.

    try {
      List<Map> resp = await _db.readData(teachersTable);
      return Success(resp.map((e) => Teacher.fromJson(e)).toList());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<int> addTeacher(Teacher teacher) async {
    // Use the specific toMapForDb() method from the Teacher model
    int resp = await _db.insertData(teachersTable, teacher.toJson());
    return resp;
  }

  Future<int> updateTeacher(
      Teacher oldTeacherData, Teacher newTeacherData) async {
    // Use the specific toMapForDb() method from the Teacher model
    int resp = await _db.updateData(
        teachersTable, newTeacherData.toJson(), "id = ${oldTeacherData.id}");
    return resp;
  }

  Future<int> deleteTeacher(int teacherId) async {
    // Note: Due to ON DELETE CASCADE, deleting a teacher will automatically
    // delete all their associated absence records.
    int resp = await _db.deleteData(teachersTable, "id = $teacherId");
    return resp;
  }
}
