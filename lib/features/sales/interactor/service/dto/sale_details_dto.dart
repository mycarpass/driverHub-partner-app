import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/commom_objects/payment_type.dart';

class SaleDetailsDto {
  late SaleDetailsData data;

  SaleDetailsDto.fromJson(Map<String, dynamic> json) {
    data = SaleDetailsData.fromJson(json['data']);
  }
}

class SaleDetailsData {
  late int id;
  late int? scheduleId;
  late PaymentType? paymentType;
  late SaleDetailsClient client;
  late List<Services> services;
  late MoneyValue totalAmountPaid;
  late MoneyValue discountValue;
  late MoneyValue subTotalPaid;
  late String type;
  late String saleDate;
  late String createdAt;

  SaleDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['schedule_id'];
    paymentType = json['payment_type'];
    client = SaleDetailsClient.fromJson(json['client']);
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services.add(Services.fromJson(v));
      });
    }
    totalAmountPaid = MoneyValue(json['total_amount_paid']);
    discountValue = MoneyValue(json['discount_value']);
    subTotalPaid = _getSubTotal();
    type = json['type'];
    saleDate = json['sale_date'];
    createdAt = json['created_at'];
  }

  MoneyValue _getSubTotal() {
    MoneyValue total = totalAmountPaid;
    MoneyValue discount = discountValue;
    total.sub(discount.price);
    return total;
  }
}

class SaleDetailsClient {
  late String name;
  late String phone;
  late String id;
  SaleDetailsVehicle? vehicle;

  SaleDetailsClient.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    phone = json['phone'];
    vehicle = json['vehicle'] != null
        ? SaleDetailsVehicle.fromJson(json['vehicle'])
        : null;
  }
}

class SaleDetailsVehicle {
  late int id;
  late String name;
  late String make;
  late String model;
  String? color;
  late String bodyType;
  String? nickname;
  String? year;
  String? licensePlate;
  bool? isSelected;

  SaleDetailsVehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    make = json['make'];
    model = json['model'];
    color = json['color'];
    bodyType = json['body_type'];
    nickname = json['nickname'];
    year = json['year'];
    licensePlate = json['license_plate'];
    isSelected = json['is_selected'];
  }
}

class Services {
  late int priceId;
  late String serviceName;
  late String basePrice;
  late String chargedPrice;

  Services.fromJson(Map<String, dynamic> json) {
    priceId = json['price_id'];
    serviceName = json['service_name'];
    basePrice = json['base_price'];
    chargedPrice = json['charged_price'];
  }
}
