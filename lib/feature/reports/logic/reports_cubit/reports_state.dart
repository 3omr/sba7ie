

 import 'package:tasneem_sba7ie/feature/reports/data/models/financial_summary.dart';

class ReportsState {}

 class ReportsInitial extends ReportsState {}

 class ReportsLoading extends ReportsState {}

 class ReportsLoaded extends ReportsState {
   final FinancialSummary summary;

   ReportsLoaded(this.summary);
 }

 class ReportsError extends ReportsState {
   final String message;

   ReportsError(this.message);
 }
