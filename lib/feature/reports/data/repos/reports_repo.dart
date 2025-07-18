import 'package:tasneem_sba7ie/core/database/db.dart';
import 'package:tasneem_sba7ie/core/helper/result.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/financial_summary.dart';

class ReportsRepo {
  final Db db;

  ReportsRepo(this.db);

  Future<Result<FinancialSummary>> getFinancialSummary() async {
    try {
      final summaryData = await db.getFinancialSummary();
      return Success(FinancialSummary.fromMap(summaryData));
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
