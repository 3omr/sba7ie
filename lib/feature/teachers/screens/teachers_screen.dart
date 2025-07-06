import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit.dart';
import 'package:tasneem_sba7ie/widgets/list_tile_card.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المعلمون',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              context.pushNamed(Routers.addTeacher,
                  extra: context.read<TeacherCubit>());
            },
          ),
        ],
      ),
      body: BlocBuilder<TeacherCubit, TeacherState>(
        builder: (context, state) {
          List<Teacher> teachers = context.read<TeacherCubit>().teachers;
          if (state is TeacherError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return state is TeacherLoading
              ? const Center(child: CircularProgressIndicator())
              : state is TeacherLoaded || state is TeacherAdded
                  ? ListView.builder(
                      addRepaintBoundaries: false,
                      addAutomaticKeepAlives: false,
                      itemCount: teachers.length,
                      itemBuilder: (context, index) {
                        final teacher = teachers[index];
                        return ListTileCard(
                          title: teacher.name,
                          subTitle: 'المرتب: ${teacher.salary}',
                          onEdite: () {
                            context.pushNamed(
                              Routers.updateTeacher,
                              pathParameters: {'id': teacher.id.toString()},
                              extra: teacher,
                            );
                          },
                          onDelete: () => context
                              .read<TeacherCubit>()
                              .deleteTeacher(teacher),
                          number: index + 1,
                        );
                      },
                    )
                  : const Center(child: Text('لا يوجد معلمون متاحون'));
        },
      ),
    );
  }
}
