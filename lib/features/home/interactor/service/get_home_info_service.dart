import 'package:driver_hub_partner/features/home/interactor/service/dto/financial_info_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/home_response_dto.dart';

abstract class GetHomeInfoService {
  Future<HomeResponseDto> getHomeInfe();
  Future<FinancialInfoDto> getFinancialInfo();
}
