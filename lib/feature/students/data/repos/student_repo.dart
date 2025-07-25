import 'package:tasneem_sba7ie/core/helper/result.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/core/database/tabels_name.dart';
import 'package:tasneem_sba7ie/core/database/db.dart';

class StudentRepo {
  final Db _db;

  StudentRepo(this._db);

  Future<Result<List<Student>>> getStudents() async {
    try {
      List<Student> studentsList = [];
      List<Map<dynamic, dynamic>> resp = await _db.readData(studentsTable);
      studentsList.addAll(resp.map((e) => Student.fromJson(e)));
      return Success(studentsList);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<int>> addStudent(Map<String, Object?> student) async {
    try {
      int resp = await _db.insertData(studentsTable, student);
      return Success(resp);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<int>> updateStudent(
      Student oldStudentData, Student newStudentData) async {
    try {
      int resp = await _db.updateData(
          studentsTable, newStudentData.toJson(), "id = ${oldStudentData.id}");
      return Success(resp);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<int>> deleteStudent(int studentId) async {
    try {
      int resp = await _db.deleteData(studentsTable, "id = $studentId");
      await _db.deleteAllStudentSubscriptions(studentId);
      return Success(resp);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
