import 'package:driver_hub_partner/features/pos_sales/interactor/service/dto/pos_sales_response_dto.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/service/pos_sales_service.dart';

class PosSalesInteractor {
  final PosSalesService _posSalesService;

  PosSalesInteractor(this._posSalesService);

  Future<PosSalesResponseDto> getPosSales() async {
    try {
      return await _posSalesService.getPosSales();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changeMadeContact(bool isMadeContact, int id) async {
    try {
      await _posSalesService.changeMadeContact(isMadeContact, id);
    } catch (e) {
      rethrow;
    }
  }
}
