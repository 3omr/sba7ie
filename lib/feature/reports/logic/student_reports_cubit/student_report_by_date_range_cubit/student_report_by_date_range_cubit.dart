import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_payment.dart';
import 'package:tasneem_sba7ie/feature/reports/data/repos/student_reports_repo.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_date_range_cubit/student_report_by_date_range_state.dart';

class StudentReportByDateRangeCubit
    extends Cubit<StudentReportByDateRangeState> {
  StudentReportByDateRangeCubit(this._studentReportsRepo)
      : super(StudentReportByDateRangeInitial());

  final StudentReportsRepo _studentReportsRepo;

  // Date Range
  DateTime? _startDate;
  DateTime? _endDate;

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  set startDate(DateTime? value) {
    _startDate = value;
    emit(StudentReportByDateRangeInitial());
  }

  set endDate(DateTime? value) {
    _endDate = value;
    emit(StudentReportByDateRangeInitial());
  }

  List<StudentPayment> studentPayments = [];

  Future<void> getStudentPaymentsByDateRange(
      DateTime startDate, DateTime endDate) async {
    emit(StudentReportByDateRangeLoading());
    final result = await _studentReportsRepo.getStudentPaymentsByDateRange(
        startDate, endDate);
    result.when(
      success: (success) {
        studentPayments = success.data;
        emit(studentPayments.isEmpty
            ? StudentReportByDateRangeEmpty()
            : StudentReportByDateRangeLoaded(studentPayments));
      },
      failure: (error) {
        emit(StudentReportByDateRangeError(error.error));
      },
    );
  }
}
