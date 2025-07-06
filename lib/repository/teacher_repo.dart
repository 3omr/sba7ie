import 'package:tasneem_sba7ie/models/teacher_model.dart';
import 'package:tasneem_sba7ie/sql_database/db.dart';
import 'package:tasneem_sba7ie/sql_database/tabels_name.dart';

class TeacherRepo {
  Db db = Db();

  Future<List<Teacher>> getTeachers() async {
    List<Teacher> teachersList = [];
    List<Map<dynamic, dynamic>> resp = await db.readData(teachersTable);
    teachersList.addAll(resp.map((e) => Teacher.fromJson(e)));
    return teachersList;
  }

  Future<int> addTeacher(Map<String, Object?> teacher) async {
    int resp = await db.insertData(teachersTable, teacher);
    return resp;
  }

  updateTeacher(
      Teacher oldTeacherData, Map<String, Object?> newTeacherData) async {
    int resp = await db.updateData(
        teachersTable, newTeacherData, "id = ${oldTeacherData.id}");
    return resp;
  }

  deleteTeacher(int teacherId) async {
    int resp = await db.deleteData(teachersTable, "id = $teacherId");
    return resp;
  }
}
