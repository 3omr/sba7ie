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

  static String getFormattedCurrentDateDay(String currentDate) {
    // Define the format of the input date string
    final DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    // Parse the input string into a DateTime object
    final DateTime date = inputFormat.parse(currentDate);

    // Define the desired output format
    final DateFormat outputFormat = DateFormat('dd-MM-yyyy');
    // Format the DateTime object into the desired output string
    return outputFormat.format(date);
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
