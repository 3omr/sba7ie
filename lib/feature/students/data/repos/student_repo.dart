import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/sql_database/tabels_name.dart';

import '../../../../sql_database/db.dart';

class StudentRepo {
  Db db = Db();

  Future<List<Student>> getStudents() async {
    List<Student> studentsList = [];
    List<Map<dynamic, dynamic>> resp = await db.readData(studentsTable);
    studentsList.addAll(resp.map((e) => Student.fromJson(e)));
    return studentsList;
  }

  Future<int> addStudent(Map<String, Object?> student) async {
    int resp = await db.insertData(studentsTable, student);
    return resp;
  }

  updateStudent(Student oldStudentData, Student newStudentData) async {
    int resp = await db.updateData(
        studentsTable, newStudentData.toJson(), "id = ${oldStudentData.id}");
    return resp;
  }

  deleteStudent(int studentId) async {
    int resp = await db.deleteData(studentsTable, "id = $studentId");
    return resp;
  }
}
