import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/core/database/tabels_name.dart';
import 'package:tasneem_sba7ie/core/database/db.dart';

class StudentRepo {
  final Db _db;

  StudentRepo(this._db);

  Future<List<Student>> getStudents() async {
    List<Student> studentsList = [];
    List<Map<dynamic, dynamic>> resp = await _db.readData(studentsTable);
    studentsList.addAll(resp.map((e) => Student.fromJson(e)));
    return studentsList;
  }

  Future<int> addStudent(Map<String, Object?> student) async {
    int resp = await _db.insertData(studentsTable, student);
    return resp;
  }

  updateStudent(Student oldStudentData, Student newStudentData) async {
    int resp = await _db.updateData(
        studentsTable, newStudentData.toJson(), "id = ${oldStudentData.id}");
    return resp;
  }

  deleteStudent(int studentId) async {
    int resp = await _db.deleteData(studentsTable, "id = $studentId");
    return resp;
  }
}
