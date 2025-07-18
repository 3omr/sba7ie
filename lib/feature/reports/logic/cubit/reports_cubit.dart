import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/feature/reports/data/repos/reports_repo.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/cubit/reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this._reportsRepo) : super(ReportsInitial()) {
    getFinancialSummary();
  }

  final ReportsRepo _reportsRepo;

  void getFinancialSummary() async {
    emit(ReportsLoading());
    final result = await _reportsRepo.getFinancialSummary();
    result.when(
      success: (summary) {
        log("totalStudentSubscription: ${summary.data.totalStudentSubscription}");
        log("totalMoneyFromSubscriptions: ${summary.data.totalMoneyFromSubscriptions}");
        log("remain: ${summary.data.remain}");
        emit(ReportsLoaded(summary.data));
      },
      failure: (error) => emit(ReportsError(error.error)),
    );
  }
}
