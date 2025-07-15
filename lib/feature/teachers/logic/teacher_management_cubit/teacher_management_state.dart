import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';

class TeacherManagementState {}

class TeacherDetailsInitial extends TeacherManagementState {}

class TeacherDetailsLoading extends TeacherManagementState {}

class TeacherDetailsError extends TeacherManagementState {
  final String message;

  TeacherDetailsError(this.message);
}

class TeacherDetailsLoaded extends TeacherManagementState {
  final Teacher teacher;

  TeacherDetailsLoaded(this.teacher);
}
