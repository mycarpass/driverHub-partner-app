import 'package:intl/intl.dart';

class ServiceDate {
  String rawDate = "";
  DateTime datetime = DateTime.now();

  ServiceDate() {
    addDate(date: DateTime.now());
  }

  void addDate({DateTime? date}) {
    datetime = date ?? DateTime.now();
    rawDate = date != null
        ? DateFormat('dd/MM/yyyy').format(date)
        : DateFormat('dd/MM/yyyy').parse(DateTime.now().toString()).toString();
  }

  void addDateByString({String? date}) {
    datetime = date != null
        ? DateFormat('dd/MM/yyyy').parse(date)
        : DateFormat('dd/MM/yyyy').parse(DateTime.now().toString());
    rawDate = date ??
        DateFormat('dd/MM/yyyy').parse(DateTime.now().toString()).toString();
  }

  bool isToday() {
    DateTime now = DateTime.now();
    if ((datetime.day == now.day) &&
        (datetime.month == now.month) &&
        (datetime.year == now.year)) {
      return true;
    }
    return false;
  }
}
