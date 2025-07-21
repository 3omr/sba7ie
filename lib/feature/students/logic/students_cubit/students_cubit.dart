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
  List<Student> _allStudents = []; // Keep original list for filtering
  List<Teacher> teachers = [];
  int? _selectedTeacherId; // Current filter

  int? get selectedTeacherId => _selectedTeacherId;

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
        _allStudents = success.data;
        _applyFilter();
        emit(StudentsLoaded(students));
      },
      failure: (failure) {
        emit(StudentsError(failure.error));
      },
    );
  }

  void filterByTeacher(int? teacherId) {
    _selectedTeacherId = teacherId;
    _applyFilter();
    emit(StudentsLoaded(students));
  }

  void clearFilter() {
    _selectedTeacherId = null;
    _applyFilter();
    emit(StudentsLoaded(students));
  }

  void _applyFilter() {
    if (_selectedTeacherId == null) {
      students = List.from(_allStudents);
    } else {
      students = _allStudents
          .where((student) => student.idTeacher == _selectedTeacherId)
          .toList();
    }
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
        int allIndex = _allStudents.indexOf(oldStudentData);
        if (allIndex != -1) {
          _allStudents[allIndex] = newStudentData;
        }
        
        int filteredIndex = students.indexOf(oldStudentData);
        if (filteredIndex != -1) {
          students[filteredIndex] = newStudentData;
        }
        
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
        _allStudents.remove(student);
        students.remove(student);
        emit(StudentsLoaded(students));
      },
      failure: (failure) {
        emit(StudentsError(failure.error));
      },
    );
  }
}