import 'dart:async';

import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/request_new_hours_suggest.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/schedules_service.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_presenter.dart';

class RestSchedulesService implements SchedulesService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<SchedulesResponseDto> getSchedules() async {
    try {
      Response response = await _httpClient.get("/partner/schedules");

      return SchedulesResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ScheduleDataDto> getScheduleDetail(int scheduleId) async {
    try {
      Response response =
          await _httpClient.get("/partner/schedules/$scheduleId");

      return ScheduleDataDto.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> acceptSchedule(
      int scheduleId, ScheduleTimeSuggestionDto timeSuggestion) async {
    try {
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
  Future<dynamic> finishSchedule(int scheduleId) async {
    try {
      Response response = await _httpClient
          .put("/partner/finish-schedule/$scheduleId");

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future suggestNewHoursSchedule(
      int scheduleId, RequestNewHoursSuggest request) async {
    try {
      Response response = await _httpClient.post(
          "/partner/send-new-date-time-suggestion/$scheduleId",
          body: request.toJson());

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createNewSchedule(ScheduleEntity scheduleEntity) async {
    try {
      await _httpClient.post("/partner/new-schedule",
          body: scheduleEntity.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
