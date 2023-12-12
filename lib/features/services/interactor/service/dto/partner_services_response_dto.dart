import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';

class PartnerServicesResponseDto {
  late List<PartnerServiceDto> services;
  late List<PartnerServiceDto> washes;

  PartnerServicesResponseDto.fromJson(Map<String, dynamic> json) {
    services = [];
    washes = [];
    for (var service in json['data']['Serviços']) {
      PartnerServiceDto sls = PartnerServiceDto.fromJson(service);
      if (sls.type == ServiceType.service) {
        services.add(sls);
      }
    }
    for (var wash in json['data']['Lavagens']) {
      PartnerServiceDto wsh = PartnerServiceDto.fromJson(wash);
      if (wsh.type == ServiceType.service) {
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
      entities.add(serviceEntity);
    }
    return entities;
  }

  PartnerServicesResponseDto();
}

class PartnerServiceDto {
  late int serviceId;
  late String name;
  late String description;
  late ServiceType type;
  late bool isLiveOnApp;
  late int quantityDoneServices;
  late String totalAmountBilling;

  PartnerServiceDto(
      {required this.serviceId,
      required this.description,
      required this.name,
      required this.type,
      required this.isLiveOnApp});

  PartnerServiceDto.fromJson(Map<String, dynamic> json) {
    serviceId = json['partner_service_id'];
    name = json['name'];
    description = json['description'] ?? "";
    type = _getType(json['type']);
    isLiveOnApp = json['is_live_on_app'] ?? false;
    quantityDoneServices = json['quantity_done_services'] ?? 0;
    totalAmountBilling = json['total_amount_billed'] ?? "R\$ 0,00";
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
}
