import 'package:driver_hub_partner/features/home/interactor/service/dto/schedules_response_dto.dart';

abstract class SchedulesService {
  Future<SchedulesResponseDto> getSchedules();
}
