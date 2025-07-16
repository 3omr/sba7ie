import 'package:tasneem_sba7ie/core/helper/result.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/core/database/db.dart';

class TeacherManagementRepo {
  final Db _db;

  TeacherManagementRepo(this._db);

  // Gets all teachers along with their absence/late days for a specific month
  Future<Result<List<Teacher>>> getTeachersWithAbsenceForMonth(
      String monthYear) async {
    try {
      List<Map<String, dynamic>> resp =
          await _db.getTeachersWithAbsencesForMonth(monthYear);
      return Success(resp.map((e) => Teacher.fromJson(e)).toList());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  // Adds or updates absence and late days for a teacher for a given month
  Future<Result<int>> setTeacherAbsenceAndDiscounts(
      int teacherId, String month, int daysAbsent, int discounts) async {
    try {
      int result =
          await _db.setTeacherAbsence(teacherId, month, daysAbsent, discounts);
      return Success(result);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  // Retrieves absence and late days for a specific teacher and month
  Future<Result<Teacher>> getTeacherAbsenceAnddiscounts(
      int teacherId, String month) async {
    try {
      var resp = await _db.getTeacherAbsenceAndDiscounts(teacherId, month);
      return Success(Teacher.absenceFromJson(resp));
    } catch (e) {
      return Failure(e.toString());
    }
  }

  // Fetches all absence records for a specific teacher across all months
  Future<Result<List<Map>>> getAllTeacherAbsences(int teacherId) async {
    try {
      var resp = await _db.getAllTeacherAbsences(teacherId);
      return Success(resp);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<int>> deleteTeacherAbsences(
      {required int teacherId, String? month}) async {
    try {
      int result =
          await _db.deleteTeacherAbsences(teacherId: teacherId, month: month);
      return Success(result);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
