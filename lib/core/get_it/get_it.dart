import 'package:get_it/get_it.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit.dart';
import 'package:tasneem_sba7ie/sql_database/db.dart';

GetIt getIt = GetIt.instance;
void getItSetup() {
  // DB
  getIt.registerLazySingleton<Db>(() => Db());
  // Registering the TeacherRepo as a singleton
  getIt.registerLazySingleton<TeacherRepo>(() => TeacherRepo(getIt<Db>()));
  getIt.registerFactory<TeacherCubit>(
    () => TeacherCubit(getIt<TeacherRepo>()),
  );
}
