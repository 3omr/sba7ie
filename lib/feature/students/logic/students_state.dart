
 import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';

class StudentsState {}

 class StudentsInitial extends StudentsState {}

  class StudentsLoading extends StudentsState {}

  class StudentsLoaded extends StudentsState {
    final List<Student> students;
  
    StudentsLoaded(this.students);
  }
  class StudentsError extends StudentsState {
    final String message;
  
    StudentsError(this.message);
  }

class StudentsAdded extends StudentsState {}


