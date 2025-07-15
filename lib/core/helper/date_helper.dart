import 'package:intl/intl.dart';

class DateHelper {
  static String getCurrentMonthAndYear() {
    final DateTime now = DateTime.now();
    return DateFormat('MM-yyyy', 'en').format(now);
  }

  static String getFormattedCurrentDate(String month) {
    final DateTime date = DateFormat("MM-yyyy").parse(month);
    return DateFormat('MM-yyyy', 'en').format(date);
  }

  static String getArabicMonthName(String month) {
    final DateTime date = DateFormat("MM-yyyy").parse(month);
    return DateFormat('MMMM', 'ar').format(date);
  }

  static int convertCurrentMonthToInt(String month) {
    final DateTime date = DateFormat("MM-yyyy").parse(month);
    return date.month;
  }
}
