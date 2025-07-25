class AppSettings {
  static const String APP_NAME = "حضانة تسنيم الخاصة";
  static const int DAYS_IN_MONTH = 26;

  static const StudentSubscriptionStatus APP_Working =
      StudentSubscriptionStatus.monthly;
}

enum StudentSubscriptionStatus {
  monthly,
  yearly,
}
