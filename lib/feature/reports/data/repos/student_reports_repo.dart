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

  Future<Result<List<StudentReport>>> getStudentReportsByTeacherIdAndMonth(
      int teacherId, String month) async {
    try {
      final res =
          await _db.getStudentReportsByTeacherIdAndMonth(teacherId, month);
      final studentReports = res.map((e) => StudentReport.fromJson(e)).toList();
      return Success(studentReports);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<List<StudentPayment>>> getStudentPaymentsByDateRange(
      DateTime startDate, DateTime endDate) async {
    try {
      final res = await _db.getStudentPaymentsByDateRange(startDate, endDate);
      final studentPayments = res.map((e) {
        final convertedMap = <String, dynamic>{
          'studentId': e['studentId'] as int,
          'studentName': e['studentName'] as String,
          'teacherName': e['teacherName'] as String,
          'moneyPaid': e['moneyPaid'] as int,
          'date': e['date'] as String,
        };
        return StudentPayment.fromJson(convertedMap);
      }).toList();
      return Success(studentPayments);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
