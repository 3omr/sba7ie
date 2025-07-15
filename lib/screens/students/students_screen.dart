// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tasneem_sba7ie/controllers/students/students_controller.dart';
// import 'package:tasneem_sba7ie/screens/subscription/student_subscription_screen.dart';
// import 'package:tasneem_sba7ie/search/student_search.dart';
// import 'package:tasneem_sba7ie/widgets/list_tile_card.dart';

// class StudentScreen extends StatelessWidget {
//   const StudentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     StudentsController studentsController = Get.put(StudentsController());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('الطلاب', style: GoogleFonts.cairo()),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add_box_outlined),
//             onPressed: () {
//               studentsController.addStudent();
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.manage_search_outlined),
//             onPressed: () {
//               showSearch(context: context, delegate: StudentSearch());
//             },
//           ),
//         ],
//       ),
//       body: GetBuilder<StudentsController>(builder: (context) {
//         return ListView.builder(
//           itemCount: studentsController.allStudents.length,
//           itemBuilder: (context, index) {
//             return studentsController.loading == true
//                 ? const CircularProgressIndicator()
//                 : InkWell(
//                     onTap: () {
//                       Get.to(() => const StudentSubscriptionScreen(),
//                           arguments: studentsController.allStudents[index]);
//                     },
//                     child: ListTileCard(
//                       number: index + 1,
//                       title: "${studentsController.allStudents[index].name}",
//                       subTitle: studentsController.getTeacherName(
//                           studentsController.allStudents[index].idTeacher!)!,
//                       onEdite: () {
//                         studentsController.updateStudent(
//                             studentsController.allStudents[index]);
//                       },
//                       onDelete: () {
//                         studentsController.deleteStudent(
//                             studentsController.allStudents[index].id!);
//                       },
//                     ),
//                   );
//           },
//         );
//       }),
//     );
//   }
// }
