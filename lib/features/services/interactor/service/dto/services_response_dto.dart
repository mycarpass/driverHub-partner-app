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

  ServiceDto({
    required this.serviceId,
    required this.type,
    required this.category,
    required this.name,
  });

  ServiceDto.fromJson(Map<String, dynamic> json) {
    serviceId = json['id'];
    type = _getType(json['type']);
    category = _getCategory(json['category']);
    name = json['name'];
    description = json['description'];
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
