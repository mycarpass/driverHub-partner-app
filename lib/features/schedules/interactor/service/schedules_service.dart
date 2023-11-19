import 'package:driver_hub_partner/features/home/interactor/service/dto/schedules_response_dto.dart';

abstract class SchedulesService {
  Future<SchedulesResponseDto> getSchedules();
  Future<ScheduleDataDto> getScheduleDetail(int scheduleId);
  Future<dynamic> acceptSchedule(
      int scheduleId, ScheduleTimeSuggestionDto timeSuggestion);
  Future<dynamic> startSchedule(int scheduleId);
  Future<dynamic> finishSchedule(int scheduleId, String code);
}
