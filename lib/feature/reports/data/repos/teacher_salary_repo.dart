import 'package:tasneem_sba7ie/core/database/db.dart';
import 'package:tasneem_sba7ie/core/helper/result.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/teacher_salary_report_model.dart';

class TeacherSalaryRepo {
  final Db _db;

  TeacherSalaryRepo(this._db);

  Future<Result<List<TeacherSalaryReportModel>>> getTeacherSalaryReportForMonth(
      String monthYear) async {
    try {
      final res = await _db.getTeacherSalaryReportForMonth(monthYear);
      final salaryReports =
          res.map((e) => TeacherSalaryReportModel.fromMap(e)).toList();
      return Success(salaryReports);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
