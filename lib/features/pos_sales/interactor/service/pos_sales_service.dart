import 'package:driver_hub_partner/features/pos_sales/interactor/service/dto/pos_sales_response_dto.dart';

abstract class PosSalesService {
  Future<PosSalesResponseDto> getPosSales();
  Future<void> changeMadeContact(bool isMadeContact, int id);
}
