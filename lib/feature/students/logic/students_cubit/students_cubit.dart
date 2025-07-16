import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/data/repos/student_repo.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit/students_state.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_repo.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit(this._studentRepo, this._teacherRepo)
      : super(StudentsInitial()) {
    getTeachers();
    getStudents();
  }

  final StudentRepo _studentRepo;
  final TeacherRepo _teacherRepo;

  List<Student> students = [];
  List<Teacher> teachers = [];

  Future<void> getTeachers() async {
    var resp = await _teacherRepo.getTeachers();
    resp.when(
        success: (success) {
          teachers = success.data;
          emit(StudentsInitial());
        },
        failure: (e) => emit(StudentsError(e.toString())));
  }

  String getTeacherNameById(int? id) {
    if (id == null) return '';
    final teacher = teachers.firstWhere((teacher) => teacher.id == id, orElse: () => Teacher());
    return teacher.name ?? '';
  }

  Future<void> getStudents() async {
    emit(StudentsLoading());

    final result = await _studentRepo.getStudents();
    result.when(
      success: (success) {
        students = success.data;
        emit(StudentsLoaded(students));
      },
      failure: (failure) {
        emit(StudentsError(failure.error));
      },
    );
  }

  Future<void> addStudent(Student student) async {
    emit(StudentsLoading());
    final result = await _studentRepo.addStudent(student.toJson());
    result.when(
      success: (success) async {
        await getStudents();
        emit(StudentsAdded());
      },
      failure: (failure) {
        emit(StudentsError(failure.error));
      },
    );
  }

  Future<void> updateStudent(
      {required Student oldStudentData, required Student newStudentData}) async {
    emit(StudentsLoading());
    final result = await _studentRepo.updateStudent(oldStudentData, newStudentData);
    result.when(
      success: (success) async {
        int index = students.indexOf(oldStudentData);
        students[index] = newStudentData;
        emit(StudentsAdded());
      },
      failure: (failure) {
        emit(StudentsError(failure.error));
      },
    );
  }

  Future<void> deleteStudent(Student student) async {
    emit(StudentsLoading());
    final result = await _studentRepo.deleteStudent(student.id!);
    result.when(
      success: (success) {
        students.remove(student);
        emit(StudentsLoaded(students));
      },
      failure: (failure) {
        emit(StudentsError(failure.error));
      },
    );
  }
}
