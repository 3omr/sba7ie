class NetSalaryCalculator {
  // ignore: constant_identifier_names
  static const int DAYS_IN_MONTH = 26;

  static int calculateNetSalary(int salary, int? daysAbsent, int? discounts) {
    final double daySalary = (salary / DAYS_IN_MONTH);
    final double netSalary =
        (salary) - ((daysAbsent ?? 0) * daySalary) - (discounts ?? 0);

    return netSalary.toInt();
  }
}
