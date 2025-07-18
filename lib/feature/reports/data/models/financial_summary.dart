class FinancialSummary {
  final int totalStudentSubscription;
  final int totalMoneyFromSubscriptions;
  final int remain;

  FinancialSummary({
    required this.totalStudentSubscription,
    required this.totalMoneyFromSubscriptions,
    required this.remain,
  });

  // Optional: Add a factory constructor to create an instance from a Map
  factory FinancialSummary.fromMap(Map<String, dynamic> map) {
    return FinancialSummary(
      totalStudentSubscription: map['totalStudentSubscription'] as int,
      totalMoneyFromSubscriptions: map['totalMoneyFromSubscriptions'] as int,
      remain: map['remain'] as int,
    );
  }

  // Optional: Add a method to convert the instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'totalStudentSubscription': totalStudentSubscription,
      'totalMoneyFromSubscriptions': totalMoneyFromSubscriptions,
      'remain': remain,
    };
  }

  @override
  String toString() {
    return 'FinancialSummary(totalStudentSubscription: $totalStudentSubscription, totalMoneyFromSubscriptions: $totalMoneyFromSubscriptions, remain: $remain)';
  }
}
