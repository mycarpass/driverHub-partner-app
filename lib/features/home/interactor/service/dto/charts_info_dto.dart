import 'dart:collection';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:intl/intl.dart';

class ChartsResponseDto {
  late MoneyValue todayTotalSales;
  late MoneyValue currentMonthTotalSales;
  late int todayQuantitySales;
  late int todayQuantitySchedules;
  late List<SoldService> topSoldServices;
  late List<DayOfBilling> weeklyBilling;

  ChartsResponseDto.fromJson(Map<String, dynamic> json) {
    todayTotalSales = MoneyValue((removeBrl(json['today_sales_total'])));
    currentMonthTotalSales =
        MoneyValue((removeBrl(json['current_month_sales_total'])));

    todayQuantitySales = json['today_sales_quantity'];
    todayQuantitySchedules = json['today_schedules_quantity'];
    topSoldServices = [];
    if (json['top_sold_services'] != null) {
      for (var topSold in json['top_sold_services']) {
        topSoldServices.add(SoldService.fromJson(topSold));
      }
    }
    weeklyBilling = [];
    if (json['weekly_billing'] != null) {
      Map<dynamic, dynamic> map = HashMap.from(json['weekly_billing']);
      map.forEach((key, value) {
        weeklyBilling.add(DayOfBilling(key, value));
      });
    }
  }

  List<ChartData> fetchWeeklyEarnData() {
    List<ChartData> data = [];
    for (var weeklyBill in weeklyBilling) {
      DateTime date = DateFormat("dd/MM/yyy").parse(weeklyBill.date);
      MoneyValue value = MoneyValue(weeklyBill.value);
      ChartData chartData = ChartData(xval: value.price, yval: date);
      data.add(chartData);
    }
    return data;
  }

  List<ChartData> fetchServicesValueData() {
    List<ChartData> data = [];
    for (var soldServices in topSoldServices) {
      String service = soldServices.name;
      MoneyValue value = MoneyValue(soldServices.totalSold);
      ChartData chartData = ChartData(yval: value.price, xval: service);
      data.add(chartData);
    }
    return data;
  }

  List<ChartData> fetchServicesQuantityData() {
    List<ChartData> data = [];
    for (var soldServices in topSoldServices) {
      String service = soldServices.name;
      int quantity = soldServices.quantitySold;
      ChartData chartData = ChartData(yval: quantity, xval: service);
      data.add(chartData);
    }
    return data;
  }

  String removeBrl(String value) {
    if (value.contains("BRL")) {
      return value.split(" ")[0];
    }
    if (value.contains(" ")) {
      return value.split(" ")[1];
    }

    return value;
  }
}

class SoldService {
  late int serviceId;
  late String name;
  late String totalSold;
  late int quantitySold;

  SoldService.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    name = json['name'];
    totalSold = json['total_sold'];
    quantitySold = json['quantity_sold'];
  }
}

class DayOfBilling {
  late String date;
  late String value;

  DayOfBilling(this.date, this.value);
}

class ChartData {
  ChartData({required this.xval, required this.yval});
  final dynamic xval;
  final dynamic yval;
  // final String rawValue;
}
