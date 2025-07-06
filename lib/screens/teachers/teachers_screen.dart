import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasneem_sba7ie/controllers/teachers/teachers_controller.dart';
import 'package:tasneem_sba7ie/widgets/list_tile_card.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TeachersController teachersController = Get.put(TeachersController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المعلمون',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {
              teachersController.addTeacher();
            },
          ),
        ],
      ),
      body: GetBuilder<TeachersController>(builder: (context) {
        return ListView.builder(
          itemCount: teachersController.allTeachers.length,
          itemBuilder: (context, index) {
            return teachersController.loading == true
                ? const CircularProgressIndicator()
                : ListTileCard(
                    number: index + 1,
                    title: "${teachersController.allTeachers[index].name}",
                    subTitle:
                        "المرتب: ${teachersController.allTeachers[index].salary} جنيه",
                    onEdite: () {
                      teachersController
                          .updateTeacher(teachersController.allTeachers[index]);
                    },
                    onDelete: () {
                      teachersController.deleteTeacher(
                          teachersController.allTeachers[index].id!);
                    },
                  );
          },
        );
      }),
    );
  }
}
