import 'package:tasneem_sba7ie/core/helper/net_salary_calculator.dart';

class Teacher {
  int? id;
  String? name;
  int? salary;
  int? daysAbsent;
  int? discounts;

  Teacher({
    this.id,
    this.name,
    this.salary,
    this.daysAbsent = 0,
    this.discounts = 0,
  });

  setAbsencesAnddiscounts(int daysAbsent, int discounts) {
    this.daysAbsent = daysAbsent;
    this.discounts = discounts;
  }

  factory Teacher.fromJson(Map<dynamic, dynamic> json) {
    return Teacher(
      id: json["id"] as int?,
      name: json["name"] as String,
      salary: (json["salary"] as num).toInt(),
      daysAbsent: (json["daysAbsent"] ?? 0) as int,
      discounts: (json["discounts"] ?? 0) as int,
    );
  }

  factory Teacher.absenceFromJson(Map<dynamic, dynamic> json) {
    return Teacher(
      daysAbsent: (json["daysAbsent"] ?? 0) as int,
      discounts: (json["discounts"] ?? 0) as int,
    );
  }

  Map<String, Object?> toJson() {
    return {
      "name": name,
      "salary": salary,
    };
  }

  int calculateNetSalary() {
    return NetSalaryCalculator.calculateNetSalary(
        salary ?? 0, daysAbsent, discounts);
  }
}
