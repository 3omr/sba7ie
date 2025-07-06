import 'package:get/get.dart';
import 'package:tasneem_sba7ie/models/student_model.dart';
import 'package:tasneem_sba7ie/models/subscription_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/repository/student_repo.dart';
import 'package:tasneem_sba7ie/repository/subscription_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_repo.dart';
import 'package:tasneem_sba7ie/sql_database/db.dart';

class DataService extends GetxService {
  // Lists
  List<Teacher> teachersList = [];
  List<Student> studentsList = [];
  List<Subscription> subscriptionsList = [];

  TeacherRepo teacherRepo = TeacherRepo();
  StudentRepo studentRepo = StudentRepo();
  SubscriptionRepo subscriptionRepo = SubscriptionRepo();

  Db database = Db();

  getTeacherData() async {
    teachersList = [];
    List<Teacher> res = await teacherRepo.getTeachers();
    teachersList.addAll(res);
  }

  getStudentData() async {
    studentsList = [];
    List<Student> res = await studentRepo.getStudents();
    studentsList.addAll(res);
  }

  getSubscription() async {
    subscriptionsList = [];
    List<Subscription> res = await subscriptionRepo.getSubscription();
    subscriptionsList.addAll(res);
  }

  void getData() async {
    await getTeacherData();
    await getStudentData();
    await getSubscription();
  }

  @override
  void onReady() {
    //deleteDataBase();
    getData();
    super.onReady();
  }

  deleteDataBase() async {
    await database.dbDelete();
  }
}
