import 'package:driver_hub_partner/features/schedules/interactor/service/dto/request_new_hours_suggest.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_presenter.dart';

abstract class SchedulesService {
  Future<SchedulesResponseDto> getSchedules();
  Future<ScheduleDataDto> getScheduleDetail(int scheduleId);
  Future<dynamic> acceptSchedule(
      int scheduleId, ScheduleTimeSuggestionDto timeSuggestion);
  Future<dynamic> startSchedule(int scheduleId);
  Future<dynamic> finishSchedule(int scheduleId);
  Future<dynamic> suggestNewHoursSchedule(
      int scheduleId, RequestNewHoursSuggest request);
  Future<void> createNewSchedule(ScheduleEntity scheduleEntity);
}
