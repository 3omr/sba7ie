import 'package:get_it/get_it.dart';
import 'package:tasneem_sba7ie/feature/students/data/repos/student_repo.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit.dart';
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
}
