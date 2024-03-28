import 'package:driver_hub_partner/features/schedules/interactor/service/dto/request_new_hours_suggest.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/schedules_service.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_presenter.dart';

class SchedulesInteractor {
  final SchedulesService _schedulesService;

  SchedulesInteractor(this._schedulesService);

  Future<SchedulesResponseDto> getSchedules() async {
    try {
      return await _schedulesService.getSchedules();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getScheduleDetail(int scheduleId) async {
    try {
      return await _schedulesService.getScheduleDetail(scheduleId);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> removeSchedulePhoto(int schedulePhotoId) async {
    try {
      return await _schedulesService.removePhoto(schedulePhotoId);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> saveSchedulePhoto(CheckListPhoto checkListPhoto) async {
    try {
      return await _schedulesService.savePhoto(checkListPhoto);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> acceptSchedule(
      int scheduleId, ScheduleTimeSuggestionDto timeSuggestion) async {
    try {
      return await _schedulesService.acceptSchedule(scheduleId, timeSuggestion);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> startSchedule(int scheduleId) async {
    try {
      return await _schedulesService.startSchedule(scheduleId);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> finishSchedule(int scheduleId, int? paymentType) async {
    try {
      return await _schedulesService.finishSchedule(scheduleId, paymentType);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> validateCheckIn(int scheduleId) async {
    try {
      return await _schedulesService.validateCheckIn(scheduleId);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteSchedule(int scheduleId) async {
    try {
      return await _schedulesService.deleteSchedule(scheduleId);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> suggestNewHoursSchedule(
      int scheduleId, RequestNewHoursSuggest request) async {
    try {
      return await _schedulesService.suggestNewHoursSchedule(
          scheduleId, request);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> registerNewSchedule(ScheduleEntity scheduleEntity) async {
    try {
      return await _schedulesService.createNewSchedule(
        scheduleEntity,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getMonthPayments() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      rethrow;
    }
  }
}
