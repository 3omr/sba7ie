import 'package:tasneem_sba7ie/core/helper/app_settings.dart';

class NetSalaryCalculator {
  static int calculateNetSalary(int salary, int? daysAbsent, int? discounts) {
    final double daySalary = (salary / AppSettings.DAYS_IN_MONTH);
    final double netSalary =
        (salary) - ((daysAbsent ?? 0) * daySalary) - (discounts ?? 0);

    return netSalary.toInt();
  }
}
