class StudentPayment {
  final int studentId;
  final String studentName;
  final String teacherName;
  final int moneyPaid;
  final DateTime date;

  StudentPayment({
    required this.studentId,
    required this.studentName,
    required this.teacherName,
    required this.moneyPaid,
    required this.date,
  });

  factory StudentPayment.fromJson(Map<String, dynamic> map) {
    return StudentPayment(
      studentId: map['studentId'] as int,
      studentName: map['studentName'] as String,
      teacherName: map['teacherName'] as String,
      moneyPaid: map['moneyPaid'] as int,
      date: DateTime.parse(map['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'teacherName': teacherName,
      'moneyPaid': moneyPaid,
      'date': date.toIso8601String(),
    };
  }
}