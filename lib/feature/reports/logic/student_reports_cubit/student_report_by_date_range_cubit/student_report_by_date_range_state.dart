import 'package:tasneem_sba7ie/feature/reports/data/models/student_payment.dart';

class StudentReportByDateRangeState {}

class StudentReportByDateRangeInitial extends StudentReportByDateRangeState {}

class StudentReportByDateRangeLoading extends StudentReportByDateRangeState {}

class StudentReportByDateRangeLoaded extends StudentReportByDateRangeState {
  final List<StudentPayment> studentPayments;
  StudentReportByDateRangeLoaded(this.studentPayments);
}

class StudentReportByDateRangeError extends StudentReportByDateRangeState {
  final String error;
  StudentReportByDateRangeError(this.error);
}

class StudentReportByDateRangeEmpty extends StudentReportByDateRangeState {}
