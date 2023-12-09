import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';

abstract class ServicesService {
  Future<ServicesResponseDto> getServicesDropDown();
}
