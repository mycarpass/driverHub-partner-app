import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/services_service.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';

class ServicesInteractor {
  final ServicesService _servicesService;

  ServicesInteractor(this._servicesService);

  Future<ServicesResponseDto> getServicesDropDown() async {
    try {
      return await _servicesService.getServicesDropDown();
    } catch (e) {
      rethrow;
    }
  }

  Future<PartnerServicesResponseDto> getPartnersService() async {
    try {
      return await _servicesService.getPartnerServices();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> saveService(ServiceEntity entity) async {
    try {
      return await _servicesService.saveService(entity);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateService(ServiceEntity entity) async {
    try {
      return await _servicesService.saveService(entity);
    } catch (e) {
      rethrow;
    }
  }
}
