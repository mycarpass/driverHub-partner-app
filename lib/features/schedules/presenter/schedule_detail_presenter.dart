import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/interactor/schedules_interactor.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedule_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleDetailPresenter extends Cubit<DHState> {
  ScheduleDetailPresenter({required this.scheduleId}) : super(DHInitialState());

  final SchedulesInteractor _schedulesInteractor =
      DHInjector.instance.get<SchedulesInteractor>();

  final int scheduleId;

  late ScheduleDataDto scheduleDataDto;

  ScheduleTimeSuggestionDto? timeSuggestionSelected;

  Future<void> load() async {
    await _getScheduleDetail();
  }

  void selectTimeSuggestion(ScheduleTimeSuggestionDto suggestionTime) {
    timeSuggestionSelected = suggestionTime;
    emit(ScheduleTimeSelected(suggestionTime));
  }

  Future _getScheduleDetail() async {
    try {
      emit(DHLoadingState());
      scheduleDataDto =
          await _schedulesInteractor.getScheduleDetail(scheduleId);
      timeSuggestionSelected = scheduleDataDto.fetchInitialTimeSuggestion();
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
