import 'package:tasneem_sba7ie/feature/reports/data/models/student_payment.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_report.dart';

sealed class StudentReportsState {}

final class StudentReportsInitial extends StudentReportsState {}

final class StudentReportsLoading extends StudentReportsState {}

final class StudentReportsLoaded extends StudentReportsState {
  final List<StudentReport> reports;

  StudentReportsLoaded(this.reports);
}

final class StudentReportsPaymentsLoaded extends StudentReportsState {
  final List<StudentPayment> payments;

  StudentReportsPaymentsLoaded(this.payments);
}

final class StudentReportsError extends StudentReportsState {
  final String message;

  StudentReportsError(this.message);
}

final class StudentReportsEmpty extends StudentReportsState {}

enum StudentReportsType { teacher, dateRange }
