import 'package:driver_hub_partner/features/home/interactor/service/dto/home_response_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/get_home_info_service.dart';

class HomeInteractor {
  final GetHomeInfoService _homeInfoService;

  HomeInteractor(this._homeInfoService);

  HomeResponseDto response = HomeResponseDto();

  Future<HomeResponseDto> getHomeInfo() async {
    try {
      response = await _homeInfoService.getHomeInfe();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
