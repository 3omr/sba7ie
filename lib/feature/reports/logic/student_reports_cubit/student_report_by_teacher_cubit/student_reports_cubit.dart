import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/helper/app_settings.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_report.dart';
import 'package:tasneem_sba7ie/feature/reports/data/repos/student_reports_repo.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_teacher_cubit/student_reports_state.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_repo.dart';

class StudentReportsCubit extends Cubit<StudentReportsState> {
  StudentReportsCubit(this._studentReportsRepo, this._teacherRepo)
      : super(StudentReportsInitial()) {
    getTeachers();
    initializeMonths();
  }

  final StudentReportsRepo _studentReportsRepo;
  final TeacherRepo _teacherRepo;

  List<Teacher> teachers = [];
  int? _selectedTeacherId;
  List<StudentReport> studentReports = [];

  int? get selectedTeacherId => _selectedTeacherId;

  set selectedTeacherId(int? value) {
    _selectedTeacherId = value;

    AppSettings.APP_Working == StudentSubscriptionStatus.yearly
        ? getStudentReportsByTeacherID(_selectedTeacherId ?? 0)
        : emit(StudentReportsInitial());
  }

  Future<void> getTeachers() async {
    emit(StudentReportsLoading());
    final result = await _teacherRepo.getTeachers();
    result.when(
      success: (success) {
        teachers = success.data;
        emit(StudentReportsInitial());
      },
      failure: (error) {
        emit(StudentReportsError(error.error));
      },
    );
  }

  Future<void> getStudentReportsByTeacherID(int teacherId) async {
    emit(StudentReportsLoading());
    final result =
        await _studentReportsRepo.getStudentReportsByTeacherID(teacherId);
    result.when(
      success: (success) {
        studentReports = success.data;
        emit(studentReports.isEmpty
            ? StudentReportsEmpty()
            : StudentReportsLoaded(studentReports));
      },
      failure: (error) {
        emit(StudentReportsError(error.error));
      },
    );
  }

  Future<void> getStudentReportsByTeacherIdAndMonth(
      int teacherId, String month) async {
    emit(StudentReportsLoading());
    final result = await _studentReportsRepo
        .getStudentReportsByTeacherIdAndMonth(teacherId, month);
    result.when(
      success: (success) {
        studentReports = success.data;
        emit(studentReports.isEmpty
            ? StudentReportsEmpty()
            : StudentReportsLoaded(studentReports));
      },
      failure: (error) {
        emit(StudentReportsError(error.error));
      },
    );
  }

  String? _selectedMonth;

  List<Map<int, String>> months = [];

  set selectedMonth(int? value) {
    _selectedMonth =
        DateFormat('MM-yyyy', 'en').format(DateTime(2025, value! + 6));

    if (_selectedTeacherId != null) {
      getStudentReportsByTeacherIdAndMonth(
          _selectedTeacherId ?? 0, _selectedMonth ?? "07-2025");
    }
  }

  void initializeMonths() {
    for (int i = 1; i <= 12; i++) {
      months.add(
          {i: DateFormat('شهر M yyyy', 'ar').format(DateTime(2025, i + 6))});
    }
  }
}
