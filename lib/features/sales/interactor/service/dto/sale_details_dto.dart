import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/commom_objects/payment_type.dart';
import 'package:driver_hub_partner/features/commom_objects/person_name.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';

class SaleDetailsDto {
  late SaleDetailsData data;

  SaleDetailsDto.fromJson(Map<String, dynamic> json) {
    data = SaleDetailsData.fromJson(json['data']);
  }

  List<ServiceDto> toServiceDtoList() {
    List<ServiceDto> list = [];

    for (var service in data.services) {
      list.add(
        ServiceDto(
          serviceId: service.priceId,
          chargedPrice: service.chargedPrice,

          ///TODO adicionar type e category no /sales
          type: ServiceType.service,
          category: ServiceCategory.wash,
          name: service.serviceName,
          prices: service.pricesList,
        ),
      );
    }
    return list;
  }
}

class SaleDetailsData {
  late int id;
  late int? scheduleId;
  late PaymentType? paymentType;
  late SaleDetailsClient client;
  late SaleDetailPartner partner;
  late List<Services> services;
  MoneyValue totalAmountPaid = MoneyValue(0.00);
  late MoneyValue discountValue;
  late MoneyValue subTotalPaid;
  late String type;
  late String saleDate;
  late String createdAt;
  List<CheckListPhoto> photoList = [];

  SaleDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleId = json['schedule_id'];
    paymentType = json['payment_type'] != null
        ? PaymentType.fromString(json['payment_type'])
        : null;
    client = SaleDetailsClient.fromJson(json['client']);
    partner = SaleDetailPartner.fromJson(json['partner']);
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services.add(Services.fromJson(v));
      });
    }
    for (var photo in json['checklist_photos']) {
      photoList.add(CheckListPhoto.fromJson(photo));
    }
    discountValue = MoneyValue(json['discount_value']);
    subTotalPaid = MoneyValue(json['total_amount_paid']);

    totalAmountPaid = _getSubTotal();
    type = json['type'];
    saleDate = json['sale_date'];
    createdAt = json['created_at'];
  }

  MoneyValue _getSubTotal() {
    return MoneyValue(subTotalPaid.price)..sum(discountValue.price);
  }
}

class SaleDetailsClient {
  late PersonName name;
  late String phone;
  late String id;
  VehicleDto? vehicle;

  SaleDetailsClient.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = PersonName(json['name']);
    phone = json['phone'];
    vehicle =
        json['vehicle'] != null ? VehicleDto.fromJson(json['vehicle']) : null;
  }
}

class SaleDetailPartner {
  late String name;
  String? logo;

  SaleDetailPartner.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    name = json['name'] ?? "";
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
  late MoneyValue basePrice;
  late MoneyValue chargedPrice;
  late CarBodyType? carBodyType;
  List<PriceDto> pricesList = [];

  Services.fromJson(Map<String, dynamic> json) {
    priceId = json['price_id'];
    serviceName = json['service_name'];
    basePrice = MoneyValue(json['base_price']);
    chargedPrice = MoneyValue(json['charged_price']);
    for (var price in json["prices"]) {
      pricesList.add(PriceDto.fromJson(price));
    }
    carBodyType = CarBodyType.values
        .where((element) => element.name.toUpperCase() == json["car_body_type"])
        .toList()
        .first;
  }
}
