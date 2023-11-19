import 'package:driver_hub_partner/features/home/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/schedules_service.dart';

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

  Future<dynamic> finishSchedule(int scheduleId, String code) async {
    try {
      return await _schedulesService.finishSchedule(scheduleId, code);
    } catch (e) {
      rethrow;
    }
  }
}
