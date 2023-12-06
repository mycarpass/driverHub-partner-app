import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/sales_service.dart';

class SalesInteractor {
  final SalesService _salesService;

  SalesInteractor(this._salesService);

  Future<SalesResponseDto> getSales() async {
    try {
      return await _salesService.getSales();
    } catch (e) {
      rethrow;
    }
  }
}
