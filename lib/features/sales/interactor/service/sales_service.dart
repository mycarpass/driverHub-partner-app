import 'package:driver_hub_partner/features/sales/interactor/service/dto/create_sale_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_presenter.dart';

abstract class SalesService {
  Future<SalesResponseDto> getSales();
  Future<void> saveSale(CreateSaleDto createSaleDto);
}
