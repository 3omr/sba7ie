import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/teacher_salary_report_model.dart';
import 'package:tasneem_sba7ie/feature/reports/data/repos/teacher_salary_repo.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/teacher_reports_cubit/teacher_reports_state.dart';

class TeacherReportsCubit extends Cubit<TeacherReportsState> {
  TeacherReportsCubit(this._teacherSalaryRepo) : super(TeacherReportsInitial());
  final TeacherSalaryRepo _teacherSalaryRepo;

  DateTime? _currentDate;
  get currentDate => _currentDate;
  set currentDate(value) {
    _currentDate = value;
    emit(TeacherReportsInitial());
  }

  List<TeacherSalaryReportModel> teachersReport = [];

  Future<void> getTeacherSalaryReportForMonth(String monthYear) async {
    emit(TeacherReportsLoading());
    final result =
        await _teacherSalaryRepo.getTeacherSalaryReportForMonth(monthYear);
    result.when(
      success: (success) {
        teachersReport = success.data;
        teachersReport.isEmpty
            ? emit(TeacherReportsEmpty())
            : emit(TeacherReportsLoaded(success.data));
      },
      failure: (error) {
        emit(TeacherReportsError(error.error));
      },
    );
  }
}
