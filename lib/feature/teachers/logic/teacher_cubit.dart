import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_repo.dart';

part 'teacher_state.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit(this._teacherRepo) : super(TeacherInitial()) {
    getTeachers();
  }

  final TeacherRepo _teacherRepo;
  List<Teacher> teachers = [];

  /// Fetches the list of teachers from the repository and emits the appropriate state.
  /// If successful, emits [TeacherLoaded] with the list of teachers.
  /// If an error occurs, emits [TeacherError] with the error message.
  Future<void> getTeachers() async {
    emit(TeacherLoading());
    var resp = await _teacherRepo.getTeachers();
    resp.when(
        success: (success) {
          teachers = success.data;
          teachers.isEmpty
              ? emit(EmptyTeachers())
              : emit(TeacherLoaded(teachers));
        },
        failure: (e) => emit(TeacherError(e.toString())));
  }

  addTeacher(Teacher teacher) async {
    emit(TeacherLoading());
    try {
      await _teacherRepo.addTeacher(teacher);
      getTeachers(); // Refresh the list after adding
      emit(TeacherAdded());
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }

  updateTeacher(
      {required Teacher oldTeacherData,
      required Teacher newTeacherData}) async {
    emit(TeacherLoading());
    try {
      await _teacherRepo.updateTeacher(oldTeacherData, newTeacherData);
      int index = teachers.indexOf(oldTeacherData);
      teachers[index] = newTeacherData;
      emit(TeacherAdded());
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }

  deleteTeacher(Teacher teacher) async {
    try {
      await _teacherRepo.deleteTeacher(teacher.id!);
      teachers.remove(teacher);
      getTeachers(); // Refresh the list after deleting
      emit(TeacherLoaded(teachers));
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }
}
