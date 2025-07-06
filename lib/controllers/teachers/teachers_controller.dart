import 'package:get/get.dart';
import 'package:tasneem_sba7ie/repository/teacher_repo.dart';
import 'package:tasneem_sba7ie/screens/teachers/update_teacher_screen.dart';
import 'package:tasneem_sba7ie/services/data_service.dart';
import 'package:tasneem_sba7ie/screens/teachers/add_teacher_screen.dart';
import 'package:tasneem_sba7ie/utl/contant.dart';
import '../../models/teacher_model.dart';

class TeachersController extends GetxController {
  DataService dataService = Get.find();

  List<Teacher> allTeachers = [];
  bool loading = true;

  @override
  void onReady() {
    super.onReady();
    getAllTeachers();
  }

  getAllTeachers() async {
    allTeachers = dataService.teachersList;
    loading = false;
    update();
  }

  reloadData() async {
    await dataService.getTeacherData();
    allTeachers = dataService.teachersList;
    loading = false;
    update();
  }

  addTeacher() {
    Get.to(() => const AddTeacherScreen());
  }

  updateTeacher(Teacher teacher) {
    Get.to(() => const UpdateTeacherScreen(), arguments: teacher);
  }

  deleteTeacher(int teacherId) {
    Utl.dialogWindow(
        onPressed: () {
          TeacherRepo teacherRepo = TeacherRepo();
          teacherRepo.deleteTeacher(teacherId);
          allTeachers.removeWhere((element) => teacherId == element.id);
          update();
          Get.back();
        },
        title: "حذف",
        buttonText: "موافق",
        msg: "هل تريد حذف المعلم");
  }
}
