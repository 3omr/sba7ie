import 'package:get/get.dart';
import 'package:tasneem_sba7ie/models/student_model.dart';
import 'package:tasneem_sba7ie/models/teacher_model.dart';
import 'package:tasneem_sba7ie/repository/student_repo.dart';
import 'package:tasneem_sba7ie/screens/students/add_student_screen.dart';
import 'package:tasneem_sba7ie/screens/students/update_student_screen.dart';
import '../../services/data_service.dart';
import '../../utl/contant.dart';

class StudentsController extends GetxController {
  DataService dataService = Get.find();

  List<Student> allStudents = [];
  bool loading = true;

  @override
  void onReady() {
    super.onReady();
    getAllStudents();
  }

  getAllStudents() async {
    allStudents = dataService.studentsList;
    loading = false;
    update();
  }

  reloadData() async {
    await dataService.getStudentData();
    allStudents = dataService.studentsList;
    loading = false;
    update();
  }

  addStudent() {
    Get.to(() => const AddStudentScreen());
  }

  updateStudent(Student student) {
    Get.to(() => const UpdateStudentScreen(), arguments: student);
  }

  deleteStudent(int studentId) {
    Utl.dialogWindow(
        onPressed: () async {
          StudentRepo studentRepo = StudentRepo();
          studentRepo.deleteStudent(studentId);
          await reloadData();
          allStudents.removeWhere((element) => studentId == element.id);
          update();
          Get.back();
        },
        title: "حذف",
        buttonText: "موافق",
        msg: "هل تريد حذف الطالب");
  }

  String? getTeacherName(int? teacherId) {
    List<Teacher> names = dataService.teachersList
        .where((element) => element.id == teacherId)
        .toList();
    if (names.isEmpty) {
      return "بدون معلم";
    }
    return names[0].name;
  }
}
