import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasneem_sba7ie/core/helper/app_settings.dart';
import 'package:tasneem_sba7ie/core/helper/date_helper.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/subscription_model.dart';
import 'package:tasneem_sba7ie/feature/students/data/repos/student_subscription_repo.dart';

part 'student_subscription_state.dart';

class StudentSubscriptionCubit extends Cubit<StudentSubscriptionState> {
  StudentSubscriptionCubit(this._studentSubscriptionRepo)
      : super(StudentSubscriptionInitial());

  final StudentSubscriptionRepo _studentSubscriptionRepo;

  late Student _student;
  Student get student => _student;

  set student(Student student) {
    _student = student;
    AppSettings.APP_Working == StudentSubscriptionStatus.yearly
        ? getStudentSubscriptionsById()
        : getStudentSubscriptionsByIdAndMonth();
  }

  final List<Subscription> _subscriptions = [];
  List<Subscription> get subscriptions => _subscriptions;

  // Calculate the total paid amount
  getPaid() {
    return _subscriptions.fold<int>(
      0,
      (sum, subscription) => sum + (subscription.money ?? 0),
    );
  }

  // Calculate the remaining amount
  getRemaining() {
    return (_student.subscription ?? 0) - getPaid();
  }

  void getStudentSubscriptionsById() async {
    emit(StudentSubscriptionLoading());
    final result = await _studentSubscriptionRepo
        .getStudentSubscriptionsById(_student.id!);

    result.when(
      success: (subscriptions) {
        _subscriptions.clear();
        _subscriptions.addAll(subscriptions.data);
        _subscriptions.isEmpty
            ? emit(StudentSubscriptionEmpty())
            : emit(StudentSubscriptionLoaded(_subscriptions));
      },
      failure: (error) {
        emit(StudentSubscriptionError(error.error));
      },
    );
  }

  Future<void> setStudentSubscription(Subscription subscription) async {
    emit(StudentSubscriptionLoading());
    final result = await _studentSubscriptionRepo.setStudentSubscription(
        subscription.idStudent ?? 0,
        subscription.money ?? 0,
        subscription.date ?? '');

    result.when(
      success: (rowsAffected) {
        AppSettings.APP_Working == StudentSubscriptionStatus.yearly
            ? getStudentSubscriptionsById()
            : getStudentSubscriptionsByIdAndMonth();

        emit(StudentSubscriptionLoaded(_subscriptions));
      },
      failure: (error) {
        emit(StudentSubscriptionError(error.error));
      },
    );
  }

  Future<void> deleteStudentSubscriptionByDate(String date) async {
    emit(StudentSubscriptionLoading());
    final result = await _studentSubscriptionRepo
        .deleteStudentSubscriptionByDate(_student.id!, date);
    result.when(
      success: (rowsAffected) {
        AppSettings.APP_Working == StudentSubscriptionStatus.yearly
            ? getStudentSubscriptionsById()
            : getStudentSubscriptionsByIdAndMonth();
        emit(StudentSubscriptionLoaded(_subscriptions));
      },
      failure: (error) {
        emit(StudentSubscriptionError(error.error));
      },
    );
  }

  // month subscription
  String _currentMonth = DateHelper.getCurrentMonthAndYear();

  String get currentMonth => _currentMonth;

  Future<void> changeMonth(String month) async {
    _currentMonth = month;
    AppSettings.APP_Working == StudentSubscriptionStatus.yearly
        ? getStudentSubscriptionsById()
        : getStudentSubscriptionsByIdAndMonth();
    emit(StudentSubscriptionLoaded(_subscriptions));
  }

  void getStudentSubscriptionsByIdAndMonth() async {
    emit(StudentSubscriptionLoading());
    final result = await _studentSubscriptionRepo
        .getStudentSubscriptionsByIdAndMonth(_student.id!, _currentMonth);

    result.when(
      success: (subscriptions) {
        _subscriptions.clear();
        _subscriptions.addAll(subscriptions.data);
        _subscriptions.isEmpty
            ? emit(StudentSubscriptionEmpty())
            : emit(StudentSubscriptionLoaded(_subscriptions));
      },
      failure: (error) {
        emit(StudentSubscriptionError(error.error));
      },
    );
  }
}
