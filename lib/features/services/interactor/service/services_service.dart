import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';

abstract class ServicesService {
  Future<ServicesResponseDto> getServicesDropDown();
  Future<dynamic> saveService(ServiceEntity entity);
  Future<ServicesResponseDto> getPartnerServices();
}
