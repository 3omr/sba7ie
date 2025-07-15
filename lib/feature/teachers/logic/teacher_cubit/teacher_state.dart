part of 'teacher_cubit.dart';

class TeacherState {}

class TeacherInitial extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherLoaded extends TeacherState {
  final List<Teacher> teachers;

  TeacherLoaded(this.teachers);
}

class TeacherError extends TeacherState {
  final String message;

  TeacherError(this.message);
}

class EmptyTeachers extends TeacherState {}

class TeacherAdded extends TeacherState {}
