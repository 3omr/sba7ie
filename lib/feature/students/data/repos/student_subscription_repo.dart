import 'package:tasneem_sba7ie/core/database/db.dart';
import 'package:tasneem_sba7ie/core/helper/result.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/subscription_model.dart';

class StudentSubscriptionRepo {
  final Db _db;

  StudentSubscriptionRepo(this._db);

  Future<Result<int>> setStudentSubscription(
      int studentId, int money, String date) async {
    try {
      return Success(await _db.setStudentSubscription(studentId, money, date));
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<List<Subscription>>> getStudentSubscriptionsById(
      int studentId) async {
    try {
      List<Map> subscriptionList =
          await _db.getStudentSubscriptionsById(studentId);
      return Success(
          subscriptionList.map((json) => Subscription.fromJson(json)).toList());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<List<Subscription>>> getAllStudentSubscriptions() async {
    try {
      List<Map> subscriptionList = await _db.getAllStudentSubscriptions();
      return Success(
          subscriptionList.map((json) => Subscription.fromJson(json)).toList());
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<int>> deleteAllStudentSubscriptions(int studentId) async {
    try {
      return Success(await _db.deleteAllStudentSubscriptions(studentId));
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<Result<int>> deleteStudentSubscriptionByDate(
      int studentId, String date) async {
    try {
      return Success(
          await _db.deleteStudentSubscriptionByDate(studentId, date));
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
