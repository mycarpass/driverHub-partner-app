import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';

abstract class SalesService {
  Future<SalesResponseDto> getSales();
}
