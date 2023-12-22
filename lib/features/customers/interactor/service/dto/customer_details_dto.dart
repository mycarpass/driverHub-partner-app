import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';

class CustomerDetailsDto {
  late Data data;

  CustomerDetailsDto.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late int id;
  late String name;
  late String phone;
  late List<SalesHistory> salesHistory;
  late MoneyValue totalSold;
  VehicleDto? vehicle;
  String? createdAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    if (json['sales_history'] != null) {
      salesHistory = <SalesHistory>[];
      json['sales_history'].forEach((v) {
        salesHistory.add(SalesHistory.fromJson(v));
      });
    }
    totalSold = MoneyValue(json['total_sold']);
    vehicle =
        json['vehicle'] != null ? VehicleDto.fromJson(json['vehicle']) : null;
    createdAt = json['created_at'];
  }
}

class SalesHistory {
  late int saleId;
  late List<Services> services;
  late MoneyValue totalAmountPaid;
  late String discountValue;
  late String saleDate;

  SalesHistory.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services.add(Services.fromJson(v));
      });
    }
    totalAmountPaid = MoneyValue(json['total_amount_paid']);
    discountValue = json['discount_value'];
    saleDate = json['sale_date'];
  }

  String getServicesRaw() {
    String servicesRaw = '';
    for (var i = 0; i < services.length; i++) {
      if (i == services.length - 1) {
        servicesRaw += services[i].serviceName;
      } else {
        servicesRaw += "${services[i].serviceName} + ";
      }
    }

    return servicesRaw;
  }
}

class Services {
  late String serviceName;
  late String servicePrice;
  late String chargedPrice;

  Services.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    chargedPrice = json['charged_price'];
  }
}
