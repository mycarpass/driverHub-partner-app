import 'dart:async';

import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/login/interactor/cache_key/email_key.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/request_new_hours_suggest.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/schedules_service.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_presenter.dart';

class RestSchedulesService implements SchedulesService {
  final _httpClient = DHInjector.instance.get<DHHttpClient>();
  final DHCacheManager _dhCacheManager =
      DHInjector.instance.get<DHCacheManager>();

  @override
  Future<SchedulesResponseDto> getSchedules() async {
    try {
      Response response = await _httpClient.get(await isServiceProvider()
          ? "/service-provider/schedules"
          : "/partner/schedules");

      return SchedulesResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ScheduleDataDto> getScheduleDetail(int scheduleId) async {
    try {
      Response response = await _httpClient.get(await isServiceProvider()
          ? "/service-provider/schedules/$scheduleId"
          : "/partner/schedules/$scheduleId");

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
      Response response = await _httpClient.put(await isServiceProvider()
          ? "/service-provider/start-service-schedule/$scheduleId"
          : "/partner/start-service-schedule/$scheduleId");

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> finishSchedule(int scheduleId, int? paymentType) async {
    try {
      Map<String, dynamic> body = {"code": "", "payment_type": paymentType};

      Response response = await _httpClient.put(
          await isServiceProvider()
              ? "/service-provider/finish-schedule/$scheduleId"
              : "/partner/finish-schedule/$scheduleId",
          body: body);

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> deleteSchedule(int scheduleId) async {
    try {
      Response response =
          await _httpClient.delete("/partner/schedules/$scheduleId");

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

  @override
  Future<void> removePhoto(int photoId) async {
    try {
      await _httpClient.delete(
        await isServiceProvider()
            ? "/service-provider/checklist-photo/$photoId"
            : "/partner/checklist-photo/$photoId",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> savePhoto(CheckListPhoto checkListPhoto) async {
    try {
      var formData = FormData.fromMap({
        "id": checkListPhoto.id,
        "image": await MultipartFile.fromFile(checkListPhoto.file.path),
        "description": checkListPhoto.description
      });
      return await _httpClient.post(
        await isServiceProvider()
            ? "/service-provider/schedule/checklist-photo"
            : "/partner/schedule/checklist-photo",
        body: formData,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isServiceProvider() async {
    String? role = await _dhCacheManager.getString(RoleTokenKey());
    return role != null && role == "SERVICE_PROVIDER";
  }

  @override
  Future validateCheckIn(int scheduleId) async {
    try {
      await _httpClient.get("validate-check-in");
    } catch (e) {
      rethrow;
    }
  }
}
