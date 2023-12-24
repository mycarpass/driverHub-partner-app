import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';

class PartnerServicesResponseDto {
  late List<PartnerServiceDto> services;
  late List<PartnerServiceDto> washes;

  PartnerServicesResponseDto.fromJson(Map<String, dynamic> json) {
    services = [];
    washes = [];
    for (var service in json['data']['Serviços']) {
      PartnerServiceDto sls = PartnerServiceDto.fromJson(service);
      if (sls.type == ServiceType.service ||
          sls.type == ServiceType.additional) {
        services.add(sls);
      }
    }
    for (var wash in json['data']['Lavagens']) {
      PartnerServiceDto wsh = PartnerServiceDto.fromJson(wash);
      if (wsh.type == ServiceType.service ||
          wsh.type == ServiceType.additional) {
        washes.add(wsh);
      }
    }
  }

  int partnerServicesLength() {
    return services.length + washes.length;
  }

  List<PartnerServiceDto> fetchServiceLiveOnApp() {
    return services.where((i) => i.isLiveOnApp).toList();
  }

  List<PartnerServiceDto> fetchWashesLiveOnApp() {
    return washes.where((i) => i.isLiveOnApp).toList();
  }

  List<ServiceEntity> washesToEntityList() {
    List<ServiceEntity> entities = [];
    for (var wash in washes) {
      var serviceEntity = ServiceEntity(
          wash.serviceId,
          wash.name,
          wash.description,
          null,
          null,
          ServiceCategory.wash,
          wash.type,
          wash.isLiveOnApp);
      entities.add(serviceEntity);

      for (var price in wash.prices) {
        serviceEntity.prices.add(
            ServiceRequestPrice(price.carBodyType, price.price, price.priceId));
      }
    }

    return entities;
  }

  List<ServiceEntity> servicesToEntityList() {
    List<ServiceEntity> entities = [];
    for (var service in services) {
      var serviceEntity = ServiceEntity(
          service.serviceId,
          service.name,
          service.description,
          null,
          null,
          ServiceCategory.wash,
          service.type,
          service.isLiveOnApp);

      for (var price in service.prices) {
        serviceEntity.prices.add(
            ServiceRequestPrice(price.carBodyType, price.price, price.priceId));
      }

      entities.add(serviceEntity);
    }
    return entities;
  }

  PartnerServicesResponseDto();
}

class PartnerServiceDto {
  late int serviceId;
  late String name;
  late String? description;
  late ServiceType type;
  late bool isLiveOnApp;
  late int quantityDoneServices;
  late String totalAmountBilling;
  List<PriceDto> prices = [];
  late String friendlyTime;
  late int hourTime;
  late int? daysPosSales;
  late ServiceCategory category;

  PartnerServiceDto({
    required this.serviceId,
    required this.description,
    required this.name,
    required this.type,
    required this.isLiveOnApp,
    required this.friendlyTime,
    required this.category,
  });

  PartnerServiceDto.fromJson(Map<String, dynamic> json) {
    serviceId = json['partner_service_id'];
    name = json['name'];
    description = json['description'] ?? "";
    type = _getType(json['type']);
    category = _getCategory(json['category']);
    isLiveOnApp = json['is_live_on_app'] ?? false;
    daysPosSales = json['day_pos_sales'];
    quantityDoneServices = json['quantity_done_services'] ?? 0;
    totalAmountBilling = json['total_amount_billed'] ?? "R\$ 0,00";
    friendlyTime = _convertToFriendlyHour(json["max_time"]);
    hourTime = _convertToHour(json["max_time"]);
    for (var price in json["prices"]) {
      prices.add(PriceDto.fromJson(price));
    }
  }

  List<PriceDto> getOnlyDefaultPrices() {
    var _prices = prices
        .where((element) => element.carBodyType != CarBodyType.van)
        .toSet()
        .toList();

    return _prices;
  }

  int _convertToHour(int? minutes) {
    if (minutes == null) {
      return 0;
    } else {
      return minutes ~/ 60;
    }
  }

  String _convertToFriendlyHour(int? minutes) {
    if (minutes == null) {
      return "Tempo não informado";
    } else {
      var inHours = minutes / 60;

      return "${inHours.toInt()} hora(s)";
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
}
