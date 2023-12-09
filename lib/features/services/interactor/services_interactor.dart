import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/services_service.dart';

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
}
