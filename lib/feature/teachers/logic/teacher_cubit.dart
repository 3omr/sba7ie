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
    try {
      teachers = await _teacherRepo.getTeachers();
      emit(TeacherLoaded(teachers));
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }

  addTeacher(Teacher teacher) async {
    emit(TeacherLoading());
    try {
      await _teacherRepo.addTeacher(teacher);
      teachers.add(teacher);
      emit(TeacherAdded());
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }

  updateTeacher(Teacher oldTeacherData, Teacher newTeacherData) async {
    emit(TeacherLoading());
    try {
      await _teacherRepo.updateTeacher(oldTeacherData, newTeacherData);
      int index = teachers.indexOf(oldTeacherData);
      teachers[index] = newTeacherData;
      emit(TeacherLoaded(teachers));
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }

  deleteTeacher(Teacher teacher) async {
    emit(TeacherLoading());
    try {
      await _teacherRepo.deleteTeacher(teacher.id!);
      teachers.remove(teacher);
      emit(TeacherLoaded(teachers));
    } catch (e) {
      emit(TeacherError(e.toString()));
    }
  }
}
