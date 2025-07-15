// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tasneem_sba7ie/controllers/students/update_student_controller.dart';
// import 'package:tasneem_sba7ie/utl/text_management.dart';

// class UpdateStudentScreen extends StatelessWidget {
//   const UpdateStudentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     UpdateStudentController updateStudentController =
//         Get.put(UpdateStudentController());
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'إضافة طالب جديد',
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: updateStudentController.formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: updateStudentController.nameController,
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
//                 controller: updateStudentController.phoneNumberController,
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
//                 controller: updateStudentController.subscriptionController,
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
//               GetBuilder<UpdateStudentController>(builder: (context) {
//                 return DropdownButtonFormField(
//                   decoration: const InputDecoration(
//                     labelText: "اختار اسم المعلم",
//                     border: OutlineInputBorder(),
//                   ),
//                   items:
//                       updateStudentController.dataService.teachersList.map((e) {
//                     return DropdownMenuItem(
//                       value: e.id,
//                       child: Text(e.name!),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     updateStudentController.getIdTeacher(value);
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
//                   if (updateStudentController.formKey.currentState!
//                       .validate()) {
//                     await updateStudentController.updateStudentButton();
//                   }
//                 },
//                 child: Text('تعديل', style: TextManagement.cairoS05W500White),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
