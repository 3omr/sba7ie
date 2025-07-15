// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tasneem_sba7ie/controllers/students/add_student_controller.dart';
// import 'package:tasneem_sba7ie/utl/text_management.dart';

// class AddStudentScreen extends StatelessWidget {
//   const AddStudentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     AddStudentController addStudentController = Get.put(AddStudentController());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('إضافة طالب جديد', style: GoogleFonts.cairo()),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: addStudentController.formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: addStudentController.nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'الاسم',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'من فضلك أدخل اسم الطالب';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: addStudentController.phoneNumberController,
//                 decoration: const InputDecoration(
//                   labelText: 'رقم المحمول',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'من فضلك أدخل رقم المحمول';
//                   } else if (value.length != 11 || value[0] != "0") {
//                     return 'ادخل رقم محمول صحيح';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: addStudentController.subscriptionController,
//                 decoration: const InputDecoration(
//                   labelText: 'الاشتراك',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'من فضلك أدخل قيمة الاشتراك';
//                   }
//                   if (int.tryParse(value) == null) {
//                     return 'يجب إدخال أرقام فقط';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               GetBuilder<AddStudentController>(builder: (context) {
//                 return DropdownButtonFormField(
//                   decoration: const InputDecoration(
//                     labelText: "اختار اسم المعلم",
//                     border: OutlineInputBorder(),
//                   ),
//                   items: addStudentController.dataService.teachersList.map((e) {
//                     return DropdownMenuItem(
//                       value: e.id,
//                       child: Text(e.name!),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     addStudentController.getIdTeacher(value);
//                   },
//                   validator: (value) {
//                     if (value == null || value == 0) {
//                       return 'من فضلك اختار المعلم';
//                     }
//                     return null;
//                   },
//                 );
//               }),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (addStudentController.formKey.currentState!.validate()) {
//                     await addStudentController.addStudentButton();
//                   }
//                 },
//                 child: Text('إضافة', style: TextManagement.cairoS05W500White),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
