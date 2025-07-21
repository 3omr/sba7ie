class TeacherSalaryReportModel {
  final int id;
  final String teacherName;
  final int salary;
  final int daysAbsent;
  final int discounts;
  final int netSalary;

  TeacherSalaryReportModel({
    required this.id,
    required this.teacherName,
    required this.salary,
    required this.daysAbsent,
    required this.discounts,
    required this.netSalary,
  });

  // Factory constructor to create from database map
  factory TeacherSalaryReportModel.fromMap(Map<String, dynamic> map) {
    return TeacherSalaryReportModel(
      id: map['id'] ?? 0,
      teacherName: map['teacherName'] ?? '',
      salary: map['salary'] ?? 0,
      daysAbsent: map['daysAbsent'] ?? 0,
      discounts: map['discounts'] ?? 0,
      netSalary: map['netSalary'] ?? 0,
    );
  }

  // Convert to map (useful for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'teacherName': teacherName,
      'salary': salary,
      'daysAbsent': daysAbsent,
      'discounts': discounts,
      'netSalary': netSalary,
    };
  }

  // Calculate day salary
  double get daySalary => salary / 25.0;

  // Calculate deduction amount
  double get totalDeductions => (daysAbsent * daySalary) + discounts;

  // Calculate deduction percentage
  double get deductionPercentage =>
      salary > 0 ? (totalDeductions / salary) * 100 : 0;

  // Check if teacher has any deductions
  bool get hasDeductions => daysAbsent > 0 || discounts > 0;

  @override
  String toString() {
    return 'TeacherSalaryReportModel(id: $id, teacherName: $teacherName, salary: $salary, daysAbsent: $daysAbsent, discounts: $discounts, netSalary: $netSalary)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TeacherSalaryReportModel &&
        other.id == id &&
        other.teacherName == teacherName &&
        other.salary == salary &&
        other.daysAbsent == daysAbsent &&
        other.discounts == discounts &&
        other.netSalary == netSalary;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        teacherName.hashCode ^
        salary.hashCode ^
        daysAbsent.hashCode ^
        discounts.hashCode ^
        netSalary.hashCode;
  }

  // Copy with method for immutability
  TeacherSalaryReportModel copyWith({
    int? id,
    String? teacherName,
    int? salary,
    int? daysAbsent,
    int? discounts,
    int? netSalary,
  }) {
    return TeacherSalaryReportModel(
      id: id ?? this.id,
      teacherName: teacherName ?? this.teacherName,
      salary: salary ?? this.salary,
      daysAbsent: daysAbsent ?? this.daysAbsent,
      discounts: discounts ?? this.discounts,
      netSalary: netSalary ?? this.netSalary,
    );
  }
}
