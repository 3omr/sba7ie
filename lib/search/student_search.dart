import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasneem_sba7ie/controllers/students/students_controller.dart';
import 'package:tasneem_sba7ie/models/student_model.dart';

import '../screens/subscription/student_subscription_screen.dart';
import '../widgets/list_tile_card.dart';

class StudentSearch extends SearchDelegate {
  StudentsController studentsController = Get.find();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
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
    List<Student> students = studentsController.allStudents;
    final List<Student> searchResults =
        students.where((item) => item.name!.contains(query)).toList();
    return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: searchResults.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Get.to(() => const StudentSubscriptionScreen(),
                        arguments: searchResults[index]);
                  },
                  child: ListTileCard(
                    number: index + 1,
                    title: "${searchResults[index].name}",
                    subTitle: studentsController
                        .getTeacherName(searchResults[index].idTeacher!)!,
                    onEdite: () {
                      studentsController.updateStudent(searchResults[index]);
                    },
                    onDelete: () {
                      studentsController
                          .deleteStudent(searchResults[index].id!);
                    },
                  ),
                )));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
