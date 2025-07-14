import 'package:intl/intl.dart';

class DateHelper {
  static String getCurrentMonthAndYear() {
    final DateTime now = DateTime.now();
    return DateFormat('MM-yyyy', 'en').format(now);
  }
}
