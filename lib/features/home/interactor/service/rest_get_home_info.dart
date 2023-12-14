import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/charts_info_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/financial_info_dto.dart';
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

  @override
  Future<FinancialInfoDto> getFinancialInfo() async {
    try {
      DateTime now = DateTime.now();
      int year = now.year;
      int month = now.month;
      Response response =
          await _httpClient.get("/partner/account?year=$year&month=$month");

      return FinancialInfoDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ChartsResponseDto> getCharts() async {
    try {
      Response response = await _httpClient.get("/partner/home");

      return ChartsResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
