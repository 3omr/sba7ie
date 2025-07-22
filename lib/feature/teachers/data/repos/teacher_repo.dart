import 'package:tasneem_sba7ie/core/helper/result.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/core/database/db.dart';
import 'package:tasneem_sba7ie/core/database/tabels_name.dart'; // Make sure this contains your table names

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

  Future<Result<int>> addTeacher(Teacher teacher) async {
    try {
      int resp = await _db.insertData(teachersTable, teacher.toJson());
      return Success(resp);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<int>> updateTeacher(
      Teacher oldTeacherData, Teacher newTeacherData) async {
    try {
      int resp = await _db.updateData(
          teachersTable, newTeacherData.toJson(), "id = ${oldTeacherData.id}");
      return Success(resp);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<int>> deleteTeacher(int teacherId) async {
    try {
      int resp = await _db.deleteData(teachersTable, "id = $teacherId");
      await _db.deleteAllTeacherAbsences(teacherId);
      return Success(resp);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
