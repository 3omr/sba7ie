import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/data/repos/student_repo.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit(this._studentRepo) : super(StudentsInitial());

  final StudentRepo _studentRepo;

  List<Student> students = [];

  Future<void> getStudents() async {
    emit(StudentsLoading());
    try {
      students = await _studentRepo.getStudents();
      emit(StudentsLoaded(students));
    } catch (e) {
      emit(StudentsError(e.toString()));
    }
  }

  Future<void> addStudent(Map<String, Object?> student) async {
    try {
      await _studentRepo.addStudent(student);
      await getStudents(); // Refresh the list after adding
      emit(StudentsAdded());
    } catch (e) {
      emit(StudentsError(e.toString()));
    }
  }

  Future<void> updateStudent(
      {required Student oldStudent, required Student newStudentData}) async {
    try {
      await _studentRepo.updateStudent(oldStudent, newStudentData);
      int index = students.indexOf(oldStudent);
      students[index] = newStudentData;
      emit(StudentsAdded());
    } catch (e) {
      emit(StudentsError(e.toString()));
    }
  }

  Future<void> deleteStudent(Student student) async {
    try {
      await _studentRepo.deleteStudent(student.id!);
      students.remove(student);
      emit(StudentsLoaded(students));
    } catch (e) {
      emit(StudentsError(e.toString()));
    }
  }
}
