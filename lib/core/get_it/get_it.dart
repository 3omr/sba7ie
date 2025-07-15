import 'package:get_it/get_it.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_management_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit/teacher_cubit.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_cubit.dart';
import 'package:tasneem_sba7ie/core/database/db.dart';

GetIt getIt = GetIt.instance;
void getItSetup() {
  // DB
  getIt.registerLazySingleton<Db>(() => Db());

  // Registering the TeacherRepo as a singleton
  getIt.registerLazySingleton<TeacherRepo>(() => TeacherRepo(getIt<Db>()));
  getIt.registerFactory<TeacherCubit>(
    () => TeacherCubit(getIt<TeacherRepo>()),
  );

  // Registering the TeacherManagementRepo as a singleton
  getIt.registerLazySingleton<TeacherManagementRepo>(
    () => TeacherManagementRepo(getIt<Db>()),
  );

  // Registering the TeacherManagementCubit as a singleton
  getIt.registerFactory<TeacherManagementCubit>(
    () => TeacherManagementCubit(getIt<TeacherManagementRepo>()),
  );
}
