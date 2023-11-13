import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/home_response_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/get_home_info_service.dart';

class RestGetHomeInfo implements GetHomeInfoService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();
  @override
  Future<HomeResponseDto> getHomeInfe() async {
    try {
      Response response = await _httpClient.get("/partner/me");

      return HomeResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
