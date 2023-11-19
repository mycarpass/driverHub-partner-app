// ignore_for_file: must_be_immutable

import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';

class ScheduleDetailState extends DHState {}

class ScheduleTimeSelected extends DHSuccessState {
  final ScheduleTimeSuggestionDto timeSuggestionDto;
  ScheduleTimeSelected(this.timeSuggestionDto);

  @override
  List<Object> get props => [timeSuggestionDto];
}

class ScheduleLoadingBody extends DHLoadingState {}

class ScheduleLoadingButton extends DHLoadingState {}

class ScheduleAcceptedSuccess extends DHSuccessState {}

class ScheduleStartedSuccess extends DHSuccessState {}

class ScheduleFinishedSuccess extends DHSuccessState {}

class ScheduleSuggestedSuccess extends DHSuccessState {}
