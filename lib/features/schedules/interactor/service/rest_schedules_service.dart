import 'dart:async';

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
  Future<ScheduleDataDto> getScheduleDetail(int scheduleId) async {
    try {
      Response response = await _httpClient.get("/schedules/$scheduleId");

      return ScheduleDataDto.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> acceptSchedule(
      int scheduleId, ScheduleTimeSuggestionDto timeSuggestion) async {
    try {
      // Timer(
      //   const Duration(seconds: 3),
      //   () => false,
      // );
      Response response = await _httpClient.put(
          "/partner/accept-schedule/$scheduleId",
          body: {'time_suggestion_id': timeSuggestion.id});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> startSchedule(int scheduleId) async {
    try {
      Response response =
          await _httpClient.put("/partner/start-service-schedule/$scheduleId");

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> finishSchedule(int scheduleId, String code) async {
    try {
      Response response = await _httpClient
          .put("/partner/finish-schedule/$scheduleId", body: {'code': "8372"});

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
