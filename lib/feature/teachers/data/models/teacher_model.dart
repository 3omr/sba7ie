class Teacher {
  int? id;
  String? name;
  int? salary;
  int? daysAbsent;
  int? lateDays;

  Teacher({
    this.id,
    this.name,
    this.salary,
    this.daysAbsent = 0,
    this.lateDays = 0,
  });

  factory Teacher.fromJson(Map<dynamic, dynamic> json) {
    return Teacher(
      id: json["id"] as int?,
      name: json["name"] as String,
      salary: (json["salary"] as num).toInt(),
      daysAbsent: (json["daysAbsent"] ?? 0) as int,
      lateDays: (json["lateDays"] ?? 0) as int,
    );
  }

  factory Teacher.absenceFromJson(Map<dynamic, dynamic> json) {
    return Teacher(
      daysAbsent: (json["daysAbsent"] ?? 0) as int,
      lateDays: (json["lateDays"] ?? 0) as int,
    );
  }
  Map<String, Object?> toJson() {
    return {
      "name": name,
      "salary": salary,
    };
  }

  // double calculateNetSalary() {
  //   // افتراض: عدد أيام العمل في الشهر
  //   final int workingDaysInMonth = 22;

  //   // سياسة خصم التأخير: كل 3 أيام تأخير تُحتسب بيوم غياب كامل
  //   final int equivalentDaysAbsentFromLateDays = (lateDays / 3).floor();

  //   // إجمالي أيام الخصم (غياب + ما يعادل التأخير)
  //   final int totalDaysToDeduct = daysAbsent + equivalentDaysAbsentFromLateDays;

  //   if (workingDaysInMonth == 0) {
  //     return baseSalary; // تجنب القسمة على صفر
  //   }

  //   final double salaryPerDay = baseSalary / workingDaysInMonth;
  //   final double deduction = salaryPerDay * totalDaysToDeduct;

  //   double netSalary = baseSalary - deduction;

  //   return netSalary > 0 ? netSalary : 0; // التأكد من أن الراتب لا يقل عن صفر
  // }
}
