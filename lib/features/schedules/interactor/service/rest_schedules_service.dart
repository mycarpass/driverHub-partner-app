import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/schedules_service.dart';

class RestSchedulesService implements SchedulesService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<SchedulesResponseDto> getSchedules() async {
    try {
      Response response = await _httpClient.get("/schedules");

      return SchedulesResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getScheduleDetail(int scheduleId) async {
    try {
      Response response = await _httpClient.get("/schedules/$scheduleId");

      return ScheduleDataDto.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }
}
