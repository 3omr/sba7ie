import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/helper/date_helper.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_management_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_state.dart';

class TeacherManagementCubit extends Cubit<TeacherManagementState> {
  TeacherManagementCubit(this._teacherRepo) : super(TeacherDetailsInitial());

  final TeacherManagementRepo _teacherRepo;

  // Month selection and info

  String _currentMonth = DateHelper.getCurrentMonthAndYear();

  String get currentMonth => _currentMonth;

  Future<void> changeMonth(String month) async {
    _currentMonth = month;
    await getTeacherAbsenceAndDiscounts(_teacher.id!,
        DateHelper.getFormattedCurrentDate(DateFormat("MM-yyyy").parse(month)));

    emit(TeacherDetailsInitial());
  }

  late Teacher _teacher;

  Teacher get teacher => _teacher;

  // Sets the teacher and fetches their absence and late days for the current month
  void setTeacher(Teacher teacher) {
    _teacher = teacher;
    getTeacherAbsenceAndDiscounts(_teacher.id!, _currentMonth);
    emit(TeacherDetailsInitial());
  }

  setTeacherAbsenceAndDiscounts(
      {int? absentDays, int? discounts, String? month}) async {
    _teacher.daysAbsent = absentDays;
    _teacher.discounts = discounts;

    emit(TeacherDetailsLoading());
    var resp = await _teacherRepo.setTeacherAbsenceAndDiscounts(_teacher.id!,
        month ?? _currentMonth, _teacher.daysAbsent!, _teacher.discounts!);
    resp.when(
      success: (success) {
        getTeacherAbsenceAndDiscounts(_teacher.id!, _currentMonth);
        emit(TeacherDetailsLoaded(teacher));
      },
      failure: (e) => emit(TeacherDetailsError(e.toString())),
    );
  }

  Future<void> getTeacherAbsenceAndDiscounts(
      int teacherId, String month) async {
    emit(TeacherDetailsLoading());
    var resp =
        await _teacherRepo.getTeacherAbsenceAnddiscounts(teacherId, month);
    resp.when(
      success: (success) {
        _teacher.daysAbsent = success.data.daysAbsent;
        _teacher.discounts = success.data.discounts;
        emit(TeacherDetailsLoaded(success.data));
      },
      failure: (e) => emit(TeacherDetailsError(e.toString())),
    );
  }

  Future<void> deleteTeacherAbsences({required bool isAllMonths}) async {
    emit(TeacherDetailsLoading());
    var resp = await _teacherRepo.deleteTeacherAbsences(
        teacherId: _teacher.id!,
        month: isAllMonths == true ? null : _currentMonth);
    resp.when(
      success: (success) {
        if (isAllMonths) {
          _teacher.daysAbsent = 0;
          _teacher.discounts = 0;
        } else {
          _teacher.daysAbsent = null;
          _teacher.discounts = null;
        }
        emit(TeacherDetailsLoaded(_teacher));
      },
      failure: (e) => emit(TeacherDetailsError(e.toString())),
    );
  }
}
