import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_management_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_details_state.dart';

class TeacherManagementCubit extends Cubit<TeacherManagementState> {
  TeacherManagementCubit(this._teacherRepo) : super(TeacherDetailsInitial());

  final TeacherManagementRepo _teacherRepo;

  Future<void> setTeacherAbsenceAndLateDays(
      Teacher teacher, String month) async {
    emit(TeacherDetailsLoading());
    try {
      await _teacherRepo.setTeacherAbsenceAndLateDays(
          teacher.id!, month, teacher.daysAbsent!, teacher.lateDays!);
      getTeacherAbsenceAndLateDays(teacher.id!, month);
      emit(TeacherDetailsLoaded(teacher));
    } catch (e) {
      emit(TeacherDetailsError(e.toString()));
    }
  }

  Future<void> getTeacherAbsenceAndLateDays(int teacherId, String month) async {
    emit(TeacherDetailsLoading());
    try {
      emit(TeacherDetailsLoaded(
          await _teacherRepo.getTeacherAbsenceAndLateDays(teacherId, month)));
    } catch (e) {
      emit(TeacherDetailsError(e.toString()));
    }
  }
}
