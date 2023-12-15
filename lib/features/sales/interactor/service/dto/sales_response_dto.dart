import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/commom_objects/payment_type.dart';
import 'package:driver_hub_partner/features/commom_objects/person_name.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/enum/sales_status.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/sales_service.dart';
import 'package:intl/intl.dart';

class SalesResponseDto {
  SalesResponseDto({this.sales = const []});

  List<SalesDto> sales = [];

  SalesResponseDto.fromJson(Map<String, dynamic> json) {
    sales = <SalesDto>[];
    json['data'].forEach((v) {
      sales.add(SalesDto.fromJson(v));
    });
  }
}

class SalesDto {
  late SalesStatus status;
  late int id;
  late PaymentType? paymentType;
  late SalesClient client;
  late List<SaleService> services;
  late MoneyValue totalAmountPaid;
  late MoneyValue discountValue;
  // late String? type;
  late DateTime saleDate;
  late String friendlyDate;
  late String createdAt;

  MoneyValue servicesValuePaidSum = MoneyValue(0.00);

  SalesDto(
      {required this.id,
      required this.saleDate,
      required this.paymentType,
      required this.services,
      required this.totalAmountPaid,
      required this.discountValue,
      required this.client,
      required this.friendlyDate,
      required this.createdAt});

  SalesDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    paymentType = json['payment_type'] == null
        ? null
        : PaymentType.fromString(json['payment_type']);
    client = SalesClient.fromJson(json['client']);
    if (json['services'] != null) {
      services = <SaleService>[];
      json['services'].forEach((v) {
        services.add(SaleService.fromJson(v));
      });

      for (var element in services) {
        servicesValuePaidSum.sum(element.value.price);
      }
    }
    totalAmountPaid = MoneyValue(json['total_amount_paid']);
    discountValue = MoneyValue(json['discount_value']);
    // type = json['type'];
    createdAt = json["created_at"];
    // salesId = json['sales_id'];
    saleDate = DateFormat('dd/MM/yyyy').parse(json['sale_date']);
    friendlyDate = json['sale_date'];
  }

  SalesStatus _getStatus(String status) {
    switch (status) {
      case "VERIFIED":
        return SalesStatus.verified;
      case "NOT_VERIFIED":
        return SalesStatus.notVerified;
      default:
        return SalesStatus.notVerified;
    }
  }
}

class SaleService {
  late MoneyValue value;

  SaleService(this.value);

  SaleService.fromJson(Map<String, dynamic> json) {
    value = MoneyValue(json['value']);
  }
}

class SalesClient {
  late PersonName personName;
  late String phone;
  late String status;

  SalesClient(
      {required this.personName, required this.phone, required this.status});

  SalesClient.fromJson(Map<String, dynamic> json) {
    personName = PersonName(json['name']);
    phone = json['phone'];
    status = json['status'];
  }
}
