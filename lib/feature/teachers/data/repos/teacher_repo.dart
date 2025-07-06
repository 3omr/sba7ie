import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/sql_database/db.dart';
import 'package:tasneem_sba7ie/sql_database/tabels_name.dart';

class TeacherRepo {
  Db db = Db();

  Future<List<Teacher>> getTeachers() async {
    List<Map> resp = await db.readData(teachersTable);
    return resp.map((e) => Teacher.fromJson(e)).toList();
  }

  Future<int> addTeacher(Teacher teacher) async {
    int resp = await db.insertData(teachersTable, teacher.toJson());
    return resp;
  }

  updateTeacher(Teacher oldTeacherData, Teacher newTeacherData) async {
    int resp = await db.updateData(
        teachersTable, newTeacherData.toJson(), "id = ${oldTeacherData.id}");
    return resp;
  }

  deleteTeacher(int teacherId) async {
    int resp = await db.deleteData(teachersTable, "id = $teacherId");
    return resp;
  }
}
