import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/core/helper/date_helper.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_management_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_state.dart';

class TeacherManagementCubit extends Cubit<TeacherManagementState> {
  TeacherManagementCubit(this._teacherRepo) : super(TeacherDetailsInitial());

  final TeacherManagementRepo _teacherRepo;

  String _currentMonth = DateHelper.getCurrentMonthAndYear();
  late Teacher _teacher;

  String get currentMonth => _currentMonth;
  Teacher get teacher => _teacher;

  // Sets the teacher and fetches their absence and late days for the current month
  void setTeacher(Teacher teacher) {
    _teacher = teacher;
    getTeacherAbsenceAndLateDays(_teacher.id!, _currentMonth);
    emit(TeacherDetailsInitial());
  }

  setTeacherAbsenceAndLateDays(
      {int? absentDays, int? lateDays, String? month}) async {
    _teacher.daysAbsent = absentDays;
    _teacher.lateDays = lateDays;

    emit(TeacherDetailsLoading());
    var resp = await _teacherRepo.setTeacherAbsenceAndLateDays(_teacher.id!,
        month ?? _currentMonth, _teacher.daysAbsent!, _teacher.lateDays!);
    resp.when(
      success: (success) {
        getTeacherAbsenceAndLateDays(_teacher.id!, _currentMonth);
        emit(TeacherDetailsLoaded(teacher));
      },
      failure: (e) => emit(TeacherDetailsError(e.toString())),
    );
  }

  Future<void> changeMonth(String month) async {
    _currentMonth = month;
    await getTeacherAbsenceAndLateDays(
        _teacher.id!, DateHelper.getFormattedCurrentDate(month));

    emit(TeacherDetailsInitial());
  }

  Future<void> getTeacherAbsenceAndLateDays(int teacherId, String month) async {
    emit(TeacherDetailsLoading());
    var resp =
        await _teacherRepo.getTeacherAbsenceAndLateDays(teacherId, month);
    resp.when(
      success: (success) {
        _teacher.daysAbsent = success.data.daysAbsent;
        _teacher.lateDays = success.data.lateDays;
        emit(TeacherDetailsLoaded(success.data));
      },
      failure: (e) => emit(TeacherDetailsError(e.toString())),
    );
  }
}
