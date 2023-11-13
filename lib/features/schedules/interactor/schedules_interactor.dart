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
}
