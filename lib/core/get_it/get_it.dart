import 'package:get_it/get_it.dart';
import 'package:tasneem_sba7ie/feature/reports/data/repos/reports_repo.dart';
import 'package:tasneem_sba7ie/feature/reports/data/repos/student_reports_repo.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/reports_cubit/reports_cubit.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_date_range_cubit/student_report_by_date_range_cubit.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_teacher_cubit/student_reports_cubit.dart';
import 'package:tasneem_sba7ie/feature/students/data/repos/student_repo.dart';
import 'package:tasneem_sba7ie/feature/students/data/repos/student_subscription_repo.dart';
import 'package:tasneem_sba7ie/feature/students/logic/student_subscription_cubit/student_subscription_cubit.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit/students_cubit.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_management_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit/teacher_cubit.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_cubit.dart';
import 'package:tasneem_sba7ie/core/database/db.dart';

GetIt getIt = GetIt.instance;
void getItSetup() {
  // DB
  getIt.registerLazySingleton<Db>(() => Db());

  // Teacher
  getIt.registerLazySingleton<TeacherRepo>(() => TeacherRepo(getIt<Db>()));

  getIt.registerFactory<TeacherCubit>(
    () => TeacherCubit(getIt<TeacherRepo>()),
  );

  getIt.registerLazySingleton<TeacherManagementRepo>(
    () => TeacherManagementRepo(getIt<Db>()),
  );

  getIt.registerFactory<TeacherManagementCubit>(
    () => TeacherManagementCubit(getIt<TeacherManagementRepo>()),
  );

  // student
  getIt.registerLazySingleton<StudentRepo>(() => StudentRepo(getIt<Db>()));
  getIt.registerFactory<StudentsCubit>(
      () => StudentsCubit(getIt<StudentRepo>(), getIt<TeacherRepo>()));

  getIt.registerLazySingleton<StudentSubscriptionRepo>(
      () => StudentSubscriptionRepo(getIt<Db>()));

  getIt.registerFactory<StudentSubscriptionCubit>(
      () => StudentSubscriptionCubit(getIt<StudentSubscriptionRepo>()));

  // reports
  getIt.registerLazySingleton<ReportsRepo>(() => ReportsRepo(getIt<Db>()));
  getIt.registerFactory<ReportsCubit>(() => ReportsCubit(getIt<ReportsRepo>()));

  // student reports
  getIt.registerLazySingleton<StudentReportsRepo>(
      () => StudentReportsRepo(getIt<Db>()));

  getIt.registerFactory<StudentReportsCubit>(() =>
      StudentReportsCubit(getIt<StudentReportsRepo>(), getIt<TeacherRepo>()));

  getIt.registerFactory<StudentReportByDateRangeCubit>(
      () => StudentReportByDateRangeCubit(getIt<StudentReportsRepo>()));
}
