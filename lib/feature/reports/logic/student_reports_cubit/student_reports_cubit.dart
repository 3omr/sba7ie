import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_payment.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_report.dart';
import 'package:tasneem_sba7ie/feature/reports/data/repos/student_reports_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_repo.dart';
import 'student_reports_state.dart';

class StudentReportsCubit extends Cubit<StudentReportsState> {
  StudentReportsCubit(this._studentReportsRepo, this._teacherRepo)
      : super(StudentReportsInitial()) {
    getTeachers();
  }

  final StudentReportsRepo _studentReportsRepo;
  final TeacherRepo _teacherRepo;

  List<Teacher> teachers = [];
  List<StudentReport> studentReports = [];
  List<StudentPayment> studentPayments = [];

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

  Future<void> getStudentPaymentsByDateRange(
      int studentId, DateTime startDate, DateTime endDate) async {
    emit(StudentReportsLoading());
    final result = await _studentReportsRepo.getStudentPaymentsByDateRange(
        studentId, startDate, endDate);
    result.when(
      success: (success) {
        studentPayments = success.data;
        emit(studentPayments.isEmpty
            ? StudentReportsEmpty()
            : StudentReportsPaymentsLoaded(studentPayments));
      },
      failure: (error) {
        emit(StudentReportsError(error.error));
      },
    );
  }
}
