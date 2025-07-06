import 'package:tasneem_sba7ie/models/subscription_model.dart';
import 'package:tasneem_sba7ie/sql_database/tabels_name.dart';
import '../sql_database/db.dart';

class SubscriptionRepo {
  Db db = Db();

  Future<List<Subscription>> getSubscription() async {
    List<Subscription> subscriptionList = [];
    List<Map<dynamic, dynamic>> resp = await db.readData(subscriptionsTable);
    subscriptionList.addAll(resp.map((e) => Subscription.fromJson(e)));
    return subscriptionList;
  }

  Future<int> addSubscription(Map<String, Object?> subscription) async {
    int resp = await db.insertData(subscriptionsTable, subscription);
    return resp;
  }

  updateSubscription(Subscription oldSubscriptionData,
      Map<String, Object?> newSubscriptionData) async {
    int resp = await db.updateData(subscriptionsTable, newSubscriptionData,
        "id = ${oldSubscriptionData.id}");
    return resp;
  }

  deleteSubscription(int subscriptionId) async {
    int resp = await db.deleteData(subscriptionsTable, "id = $subscriptionId");
    return resp;
  }
}
