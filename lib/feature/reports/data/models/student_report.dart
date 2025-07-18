class StudentReport {
  final int id;
  final String name;
  final int subscription;
  final int totalPaid;
  final int remaining;
  final int teacherId;

  StudentReport({
    required this.id,
    required this.name,
    required this.subscription,
    required this.totalPaid,
    required this.remaining,
    required this.teacherId,
  });

  factory StudentReport.fromJson(Map<String, dynamic> json) {
    return StudentReport(
      id: json['id'],
      name: json['name'],
      subscription: json['subscription'],
      totalPaid: json['totalPaid'],
      remaining: json['remaining'],
      teacherId: json['idTeacher'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subscription': subscription,
      'totalPaid': totalPaid,
      'remaining': remaining,
      'idTeacher': teacherId,
    };
  }
}
