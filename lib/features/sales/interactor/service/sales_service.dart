import 'package:driver_hub_partner/features/sales/interactor/service/dto/create_sale_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sale_details_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';

abstract class SalesService {
  Future<SalesResponseDto> getSales();
  Future<SaleDetailsDto> getDetails(String id);
  Future<void> saveSale(CreateSaleDto createSaleDto);
}
