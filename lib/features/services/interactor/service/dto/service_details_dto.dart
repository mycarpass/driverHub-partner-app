import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';

class ServiceDetailsDto {
  late int serviceId;
  late int partnerServiceId;
  late String name;
  late String description;
  late String category;
  late String type;
  late int minTime;
  late int maxTime;
  late int soldAmount;
  late MoneyValue totalBilled;
  late SoldAmountPerCarBodyType soldAmountPerCarBodyType;
  late List<ServiceDetailsPrices> prices;

  ServiceDetailsDto.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    partnerServiceId = json['partner_service_id'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    type = json['type'];
    minTime = json['min_time'];
    maxTime = json['max_time'];
    soldAmount = json['sold_amount'];
    totalBilled = MoneyValue(json['total_billed']);
    soldAmountPerCarBodyType = SoldAmountPerCarBodyType.fromJson(
        json['sold_amount_per_car_body_type']);
    if (json['prices'] != null) {
      prices = <ServiceDetailsPrices>[];
      json['prices'].forEach((v) {
        prices.add(ServiceDetailsPrices.fromJson(v));
      });
    }
  }
}

class SoldAmountPerCarBodyType {
  Map<CarBodyType, int> soldByType = {};

  List<CarBodyType> carBodyTypes = [
    CarBodyType.hatchback,
    CarBodyType.sedan,
    CarBodyType.suv,
    CarBodyType.pickup,
    CarBodyType.ram,
    CarBodyType.convertible,
    CarBodyType.van,
    CarBodyType.stationwagon,
    CarBodyType.coupe,
  ];

  SoldAmountPerCarBodyType.fromJson(dynamic json) {
    if (json is List) {
      for (var bodyType in carBodyTypes) {
        soldByType[bodyType] = 0;
      }
    } else {
      for (var bodyType in carBodyTypes) {
        if (json[bodyType.name.toUpperCase()] != null) {
          soldByType[bodyType] = json[bodyType.name.toUpperCase()];
        }
      }
    }

    // hatch = json['HATCHBACK'];
    // sedan = json['SEDAN'];
    // suv
    // pickUp
    // highValuePickUp
  }
}

class ServiceDetailsPrices {
  late int id;
  late String value;
  late String carBodyType;
  late int partnerServiceId;

  ServiceDetailsPrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    carBodyType = json['car_body_type'];
    partnerServiceId = json['partner_service_id'];
  }
}
