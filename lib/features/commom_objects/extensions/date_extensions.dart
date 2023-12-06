import 'package:intl/intl.dart';

extension DateHelper on DateTime {
  String formatDate(String dateFormatter, String? locale) {
    final formatter = DateFormat(dateFormatter, locale);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
