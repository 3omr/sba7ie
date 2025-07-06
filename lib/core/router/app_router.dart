import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/get_it/get_it.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/feature/home/screens/home_screen.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit.dart';
import 'package:tasneem_sba7ie/feature/teachers/screens/teachers_screen.dart';
import 'package:tasneem_sba7ie/feature/teachers/screens/add_teacher_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routers.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
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
            child: const AddTeacherScreen(),
          );
        },
      ),
    ],
  );
}
