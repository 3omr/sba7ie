import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_management_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_state.dart';

class TeacherManagementCubit extends Cubit<TeacherManagementState> {
  TeacherManagementCubit(this._teacherRepo) : super(TeacherDetailsInitial());

  final TeacherManagementRepo _teacherRepo;

  Future<void> setTeacherAbsenceAndLateDays(
      Teacher teacher, String month) async {
    emit(TeacherDetailsLoading());
    var resp = await _teacherRepo.setTeacherAbsenceAndLateDays(
        teacher.id!, month, teacher.daysAbsent!, teacher.lateDays!);
    resp.when(
      success: (success) {
        getTeacherAbsenceAndLateDays(teacher.id!, month);
        emit(TeacherDetailsLoaded(teacher));
      },
      failure: (e) => emit(TeacherDetailsError(e.toString())),
    );
  }

  Future<void> getTeacherAbsenceAndLateDays(int teacherId, String month) async {
    emit(TeacherDetailsLoading());
    var resp =
        await _teacherRepo.getTeacherAbsenceAndLateDays(teacherId, month);
    resp.when(
      success: (success) => emit(TeacherDetailsLoaded(success.data)),
      failure: (e) => emit(TeacherDetailsError(e.toString())),
    );
  }
}
