import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/service_details_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';

abstract class ServicesService {
  Future<ServicesResponseDto> getServicesDropDown();
  Future<PartnerServicesResponseDto> getPartnerServices();
  Future<ServiceDetailsDto> getServiceDetails(String id);
  Future<dynamic> saveService(ServiceEntity entity);
  Future<dynamic> updateService(ServiceEntity entity);
}
