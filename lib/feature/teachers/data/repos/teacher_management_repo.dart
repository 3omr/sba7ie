import 'dart:developer';

import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/sql_database/db.dart';

class TeacherManagementRepo {
  final Db _db;

  TeacherManagementRepo(this._db);

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
  Future<Teacher> getTeacherAbsenceAndLateDays(
      int teacherId, String month) async {
    var resp = await _db.getTeacherAbsenceAndLateDays(teacherId, month);
    log(resp.toString());
    // Use Teacher.fromMap to populate the Teacher object with absence/late day info
    return Teacher.absenceFromJson(resp);
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
