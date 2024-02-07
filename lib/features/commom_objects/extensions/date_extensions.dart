import 'package:driver_hub_partner/features/commom_objects/extensions/date_months.dart';
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

  String getRawMonthName() {
    return months[month] ?? "Erro ao detectar mês atual";
  }
}
