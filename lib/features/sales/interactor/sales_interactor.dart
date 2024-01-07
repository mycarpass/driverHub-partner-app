import 'package:driver_hub_partner/features/sales/interactor/service/dto/create_sale_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sale_details_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/update_sale_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/sales_service.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';

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

  Future<SaleDetailsDto> getDetails(String id) async {
    try {
      return await _salesService.getDetails(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveSale(CreateSaleDto createSaleDto) async {
    try {
      await _salesService.saveSale(createSaleDto);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateSale(UpdateSaleDto updateSaleDto) async {
    try {
      await _salesService.updateSale(updateSaleDto);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeSalePhoto(CheckListPhoto checkListPhoto) async {
    try {
      await _salesService.removeSalePhoto(checkListPhoto);
    } catch (e) {
      rethrow;
    }
  }
}
