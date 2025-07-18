import 'package:tasneem_sba7ie/core/database/db.dart';
import 'package:tasneem_sba7ie/core/helper/result.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_payment.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_report.dart';

class StudentReportsRepo {
  final Db _db;

  StudentReportsRepo(this._db);

  Future<Result<List<StudentReport>>> getStudentReportsByTeacherID(
      int teacherId) async {
    try {
      final res = await _db.getStudentReportByTeacherID(teacherId);
      final studentReports = res.map((e) => StudentReport.fromJson(e)).toList();
      return Success(studentReports);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<List<StudentPayment>>> getStudentPaymentsByDateRange(
      int studentId, DateTime startDate, DateTime endDate) async {
    try {
      final res = await _db.getStudentPaymentsByDateRange(
          studentId, startDate, endDate);
      final studentPayments =
          res.map((e) => StudentPayment.fromJson(e)).toList();
      return Success(studentPayments);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
