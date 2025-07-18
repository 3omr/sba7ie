class StudentReport {
  final int id;
  final String name;
  final int subscription;
  final int totalPaid;
  final int remaining;

  StudentReport({
    required this.id,
    required this.name,
    required this.subscription,
    required this.totalPaid,
    required this.remaining,
  });

  factory StudentReport.fromJson(Map<String, dynamic> json) {
    return StudentReport(
      id: json['id'],
      name: json['name'],
      subscription: json['subscription'],
      totalPaid: json['total_paid'],
      remaining: json['remaining'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subscription': subscription,
      'total_paid': totalPaid,
      'remaining': remaining,
    };
  }
}
