import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/schedules/interactor/schedules_interactor.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/enum/schedule_status.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/request_new_hours_suggest.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedule_detail_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/confirm_start_schedule_action.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/new_dates_schedule_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleDetailPresenter extends Cubit<DHState> {
  ScheduleDetailPresenter({required this.scheduleId}) : super(DHInitialState());

  final SchedulesInteractor _schedulesInteractor =
      DHInjector.instance.get<SchedulesInteractor>();

  final int scheduleId;

  late ScheduleDataDto scheduleDataDto;

  late ScheduleTimeSuggestionDto timeSuggestionSelected;

  Future<void> load() async {
    await _getScheduleDetail();
  }

  void selectTimeSuggestion(ScheduleTimeSuggestionDto suggestionTime) {
    timeSuggestionSelected = suggestionTime;
    emit(ScheduleTimeSelected(suggestionTime));
  }

  Future _getScheduleDetail() async {
    try {
      emit(ScheduleLoadingBody());
      scheduleDataDto =
          await _schedulesInteractor.getScheduleDetail(scheduleId);
      timeSuggestionSelected = scheduleDataDto.fetchInitialTimeSuggestion();
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future acceptSchedule() async {
    try {
      emit(ScheduleLoadingButton());

      await _schedulesInteractor.acceptSchedule(
          scheduleId, timeSuggestionSelected);
      scheduleDataDto =
          await _schedulesInteractor.getScheduleDetail(scheduleId);
      emit(ScheduleAcceptedSuccess());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future startSchedule() async {
    try {
      emit(ScheduleLoadingButton());
      await _schedulesInteractor.startSchedule(scheduleId);
      await _getScheduleDetail();
      emit(ScheduleStartedSuccess());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future finishSchedule() async {
    try {
      emit(ScheduleLoadingButton());
      await _schedulesInteractor.finishSchedule(scheduleId);
      await _getScheduleDetail();
      emit(ScheduleFinishedSuccess());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future action(BuildContext context) async {
    switch (scheduleDataDto.status) {
      case ScheduleStatus.pending:
        await acceptSchedule();
      case ScheduleStatus.waitingToWork:
        // ignore: use_build_context_synchronously
        dynamic isConfirmed = await showModalBottomSheet<bool>(
            context: context,
            builder: (BuildContext context) {
              return const ConfirmStartScheduleWidget();
            });
        if (isConfirmed != null && isConfirmed) {
          await startSchedule();
        }

      case ScheduleStatus.inProgress:
        await finishSchedule();

      default:
        return null;
    }
  }

  void openSuggestNewDate(BuildContext context) async {
    RequestNewHoursSuggest? requestNewHoursSuggest =
        await showModalBottomSheet<RequestNewHoursSuggest>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return const NewDatesScheduleWidget();
            });
    if (requestNewHoursSuggest != null) {
      await _suggestNewDate(requestNewHoursSuggest);
    }
  }

  Future _suggestNewDate(RequestNewHoursSuggest request) async {
    try {
      emit(ScheduleLoadingButton());

      await _schedulesInteractor.suggestNewHoursSchedule(scheduleId, request);
      scheduleDataDto =
          await _schedulesInteractor.getScheduleDetail(scheduleId);
      emit(ScheduleSuggestedSuccess());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
