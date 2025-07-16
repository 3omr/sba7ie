import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/get_it/get_it.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/feature/home/screens/home_screen.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/logic/student_subscription_cubit/student_subscription_cubit.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit/students_cubit.dart';
import 'package:tasneem_sba7ie/feature/students/screens/add_update_student_screen.dart';
import 'package:tasneem_sba7ie/feature/students/screens/student_subscription_screen.dart';
import 'package:tasneem_sba7ie/feature/students/screens/students_screen.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit/teacher_cubit.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_cubit.dart';
import 'package:tasneem_sba7ie/feature/teachers/screens/add_update_teacher_screen.dart';
import 'package:tasneem_sba7ie/feature/teachers/screens/teacher_details.dart';
import 'package:tasneem_sba7ie/feature/teachers/screens/teachers_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routers.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      // Teachers Routes
      GoRoute(
        name: Routers.teachers,
        path: Routers.teachers,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => getIt<TeacherCubit>(),
            child: const TeachersScreen(),
          );
        },
      ),
      GoRoute(
        name: Routers.addTeacher,
        path: Routers.addTeacher,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider.value(
            value: state.extra as TeacherCubit,
            child: const AddUpdateTeacherScreen(),
          );
        },
      ),
      GoRoute(
        name: Routers.updateTeacher,
        path: Routers.updateTeacher,
        builder: (BuildContext context, GoRouterState state) {
          List extra = state.extra as List;
          return BlocProvider.value(
            value: extra[0] as TeacherCubit,
            child: AddUpdateTeacherScreen(
              teacher: extra[1] as Teacher,
            ),
          );
        },
      ),
      GoRoute(
        name: Routers.teacherDetails,
        path: Routers.teacherDetails,
        builder: (BuildContext context, GoRouterState state) {
          List extra = state.extra as List;
          return BlocProvider(
            create: (context) => getIt<TeacherManagementCubit>(),
            child: TeacherDetails(
              teacher: extra[1] as Teacher,
            ),
          );
        },
      ),

      // Students Routes
      GoRoute(
        name: Routers.students,
        path: Routers.students,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => getIt<StudentsCubit>(),
            child: const StudentsScreen(),
          );
        },
      ),
      GoRoute(
        name: Routers.addStudent,
        path: Routers.addStudent,
        builder: (BuildContext context, GoRouterState state) {
          List extra = state.extra as List;
          return BlocProvider.value(
            value: extra[0] as StudentsCubit,
            child: AddUpdateStudentScreen(
              teachersList: extra[1] as List<Teacher>,
            ),
          );
        },
      ),
      GoRoute(
        name: Routers.updateStudent,
        path: Routers.updateStudent,
        builder: (BuildContext context, GoRouterState state) {
          List extra = state.extra as List;
          return BlocProvider.value(
            value: extra[0] as StudentsCubit,
            child: AddUpdateStudentScreen(
              student: extra[1] as Student,
              teachersList: extra[2] as List<Teacher>,
            ),
          );
        },
      ),
      GoRoute(
        name: Routers.studentSubscription,
        path: Routers.studentSubscription,
        builder: (BuildContext context, GoRouterState state) {
          List extra = state.extra as List;
          return BlocProvider(
            create: (context) => getIt<StudentSubscriptionCubit>(),
            child: StudentSubscriptionScreen(
              student: extra[0] as Student,
              teacherName: extra[1] as String,
            ),
          );
        },
      ),
    ],
  );
}
