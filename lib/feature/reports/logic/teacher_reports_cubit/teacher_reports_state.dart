import 'package:tasneem_sba7ie/feature/reports/data/models/teacher_salary_report_model.dart';

class TeacherReportsState {}

class TeacherReportsInitial extends TeacherReportsState {}

class TeacherReportsLoading extends TeacherReportsState {}

class TeacherReportsError extends TeacherReportsState {
  final String error;
  TeacherReportsError(this.error);
}

class TeacherReportsEmpty extends TeacherReportsState {}

class TeacherReportsLoaded extends TeacherReportsState {
  final List<TeacherSalaryReportModel> teacherReports;
  TeacherReportsLoaded(this.teacherReports);
}
