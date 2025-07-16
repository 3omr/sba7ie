part of 'student_subscription_cubit.dart';

class StudentSubscriptionState {}

class StudentSubscriptionInitial extends StudentSubscriptionState {}

class StudentSubscriptionLoading extends StudentSubscriptionState {}

class StudentSubscriptionLoaded extends StudentSubscriptionState {
  final List<Subscription> subscriptions;

  StudentSubscriptionLoaded(this.subscriptions);
}

class StudentSubscriptionError extends StudentSubscriptionState {
  final String error;

  StudentSubscriptionError(this.error);
}

class StudentSubscriptionEmpty extends StudentSubscriptionState {}
