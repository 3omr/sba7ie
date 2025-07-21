import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit/students_cubit.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit/students_state.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/screens/widgets/student_card.dart';

class StudentSearch extends SearchDelegate {
  final StudentsCubit studentsCubit;

  StudentSearch({required this.studentsCubit});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider.value(
      value: studentsCubit,
      child: BlocBuilder<StudentsCubit, StudentsState>(
        builder: (context, state) {
          List<Student> students = studentsCubit.students;

          if (state is StudentsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'حدث خطأ: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      studentsCubit.getStudents();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (state is StudentsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Student> searchResults = students
              .where((student) =>
                  student.name?.toLowerCase().contains(query.toLowerCase()) ??
                  false)
              .toList();

          if (searchResults.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد نتائج للبحث',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final student = searchResults[index];
                return InkWell(
                  onTap: () {
                    context.pushNamed(
                      Routers.studentSubscription,
                      extra: student,
                    );
                  },
                  child: StudentCard(
                    student: student,
                    index: index,
                    studentsCubit: studentsCubit,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          'ابدأ بكتابة اسم الطالب للبحث',
          style: TextManagement.alexandria16BoldMainBlue,
        ),
      );
    }

    return BlocProvider.value(
      value: studentsCubit,
      child: BlocBuilder<StudentsCubit, StudentsState>(
        builder: (context, state) {
          List<Student> students = studentsCubit.students;

          final List<Student> suggestions = students
              .where((student) =>
                  student.name?.toLowerCase().contains(query.toLowerCase()) ??
                  false)
              .take(5)
              .toList();

          if (suggestions.isEmpty) {
            return Center(
              child: Text(
                'لا توجد اقتراحات',
                style: TextManagement.alexandria16BoldMainBlue,
              ),
            );
          }

          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final student = suggestions[index];
              return InkWell(
                onTap: () {
                  context.pushNamed(
                    Routers.studentSubscription,
                    extra: student,
                  );
                },
                child: StudentCard(
                  student: student,
                  index: index,
                  studentsCubit: studentsCubit,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
