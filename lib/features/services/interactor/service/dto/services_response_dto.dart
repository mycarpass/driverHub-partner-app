import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';

class ServicesResponseDto {
  late List<ServiceDto> services;

  ServicesResponseDto.fromJson(Map<String, dynamic> json) {
    services = [];

    for (var service in json['data']) {
      ServiceDto sls = ServiceDto.fromJson(service);
      services.add(sls);
    }
  }

  ServicesResponseDto();

  List<ServiceEntity> fetchServices() {
    List<ServiceEntity> servicesEntity = [];
    for (var service in services) {
      if (service.category == ServiceCategory.services &&
          service.type == ServiceType.service) {
        var serviceEntity = ServiceEntity(
            service.serviceId,
            service.name,
            service.description,
            null,
            null,
            service.category,
            service.type,
            false);
        servicesEntity.add(serviceEntity);
      }
    }
    return servicesEntity;
  }

  List<ServiceEntity> allServices() {
    List<ServiceEntity> washesEntity = [];
    for (var service in services) {
      if (service.type != ServiceType.additional) {
        var serviceEntity = ServiceEntity(
            service.serviceId,
            service.name,
            service.description,
            null,
            null,
            service.category,
            service.type,
            false);
        washesEntity.add(serviceEntity);
      }
    }
    return washesEntity;
  }

  List<ServiceEntity> fetchWashes() {
    List<ServiceEntity> washesEntity = [];
    for (var service in services) {
      if (service.category == ServiceCategory.wash &&
          service.type == ServiceType.service) {
        var serviceEntity = ServiceEntity(
            service.serviceId,
            service.name,
            service.description,
            null,
            null,
            service.category,
            service.type,
            false);
        washesEntity.add(serviceEntity);
      }
    }
    return washesEntity;
  }

  List<ServiceEntity> fetchAddionalWashes() {
    List<ServiceEntity> washesEntity = [];
    for (var service in services) {
      if (service.category == ServiceCategory.wash &&
          service.type == ServiceType.additional) {
        var serviceEntity = ServiceEntity(
            service.serviceId,
            service.name,
            service.description,
            null,
            null,
            service.category,
            service.type,
            false);
        washesEntity.add(serviceEntity);
      }
    }
    return washesEntity;
  }
}

class ServiceDto {
  late int serviceId;
  late ServiceCategory category;
  late ServiceType type;
  late String name;
  // late String id;
  late String description;
  List<PriceDto> prices = [];

  ServiceDto(
      {required this.serviceId,
      required this.type,
      required this.category,
      required this.name,
      required this.prices});

  ServiceDto.fromEntity(ServiceEntity serviceEntity) {
    serviceId = serviceEntity.id!;
    type = serviceEntity.type;
    category = serviceEntity.category;
    name = serviceEntity.name;
    description = serviceEntity.description ?? "";

    for (var price in serviceEntity.prices) {
      prices.add(PriceDto(price.value, price.carBodyType, price.partnerId));
    }
  }

  ServiceDto.fromJson(Map<String, dynamic> json) {
    serviceId = json['id'];
    type = _getType(json['type']);
    category = _getCategory(json['category']);
    name = json['name'];
    description = json['description'];

    if (json["prices"] != null) {
      for (var price in json["prices"]) {
        prices.add(PriceDto.fromJson(price));
      }
    }
  }

  ServiceType _getType(String type) {
    switch (type) {
      case "SERVICE":
        return ServiceType.service;
      case "ADDITIONAL":
        return ServiceType.additional;
      default:
        return ServiceType.service;
    }
  }

  ServiceCategory _getCategory(String category) {
    switch (category) {
      case "Lavagens":
        return ServiceCategory.wash;
      case "Serviços":
        return ServiceCategory.services;
      default:
        return ServiceCategory.services;
    }
  }

  MoneyValue getPriceByCarBodyType(CarBodyType carBodyType) {
    try {
      var value = prices
          .where((element) => element.carBodyType == carBodyType)
          .toList()
          .first;

      return value.price;
    } catch (e) {
      return prices.first.price;
    }
  }

  PriceDto finPrice(CarBodyType carBodyType) {
    var value = prices
        .where((element) => element.carBodyType == carBodyType)
        .toList()
        .first;

    return value;
  }
}

class PriceDto {
  late MoneyValue price;
  late CarBodyType carBodyType;
  late int priceId;

  PriceDto(this.price, this.carBodyType, this.priceId);

  PriceDto.fromJson(Map<String, dynamic> json) {
    price = MoneyValue(json['value']);
    carBodyType = _getCategory(json['car_body_type']);
    priceId = json["id"];
  }

  CarBodyType _getCategory(String category) {
    switch (category) {
      case "HATCHBACK":
        return CarBodyType.hatchback;
      case "SEDAN":
        return CarBodyType.sedan;
      case "SUV":
        return CarBodyType.suv;
      case "PICKUP":
        return CarBodyType.pickup;
      case "HIGH_VALUE_PICKUP":
        return CarBodyType.ram;
      default:
        return CarBodyType.hatchback;
    }
  }
}

enum CarBodyType {
  hatchback("Hatch"),
  sedan("Sedan"),
  suv("SUV"),
  pickup("Caminhonete"),
  ram("RAM");

  const CarBodyType(this.value);
  final String value;
}

extension GetCarBodyTypeByString on CarBodyType {
  CarBodyType getCategory(String category) {
    switch (category) {
      case "HATCHBACK":
        return CarBodyType.hatchback;
      case "SEDAN":
        return CarBodyType.sedan;
      case "SUV":
        return CarBodyType.suv;
      case "PICKUP":
        return CarBodyType.pickup;
      case "HIGH_VALUE_PICKUP":
        return CarBodyType.ram;
      default:
        return CarBodyType.hatchback;
    }
  }

  int toInt() {
    switch (this) {
      case CarBodyType.hatchback:
        return 0;
      case CarBodyType.sedan:
        return 1;
      case CarBodyType.suv:
        return 2;
      case CarBodyType.pickup:
        return 3;
      case CarBodyType.ram:
        return 9;
      default:
        return 1;
    }
  }
}
