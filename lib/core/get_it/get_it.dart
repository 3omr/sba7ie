import 'package:get_it/get_it.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/repos/teacher_repo.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit.dart';

GetIt getIt = GetIt.instance;
void getItSetup() {
  // Registering the TeacherRepo as a singleton
  getIt.registerLazySingleton<TeacherRepo>(() => TeacherRepo());
  getIt.registerLazySingleton<TeacherCubit>(
    () => TeacherCubit(getIt<TeacherRepo>()),
  );
}
