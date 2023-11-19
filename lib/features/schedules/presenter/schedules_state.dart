// ignore_for_file: must_be_immutable

import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';

class SchedulesState extends DHState {}

class SchedulesLoaded extends DHSuccessState {
  final SchedulesResponseDto schedulesResponseDto;

  SchedulesLoaded(this.schedulesResponseDto);
}
