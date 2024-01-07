// ignore_for_file: must_be_immutable

import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:image_picker/image_picker.dart';

class ScheduleDetailState extends DHState {}

class ScheduleTimeSelected extends DHSuccessState {
  final ScheduleTimeSuggestionDto timeSuggestionDto;
  ScheduleTimeSelected(this.timeSuggestionDto);

  @override
  List<Object> get props => [timeSuggestionDto];
}

class NewPhotoCaptured extends DHState {
  final XFile file;

  NewPhotoCaptured({required this.file});
  @override
  List<Object?> get props => [file];
}

class SchedulePhotoRemoveLoading extends DHState {}

class PhotoRemoved extends DHState {
  final CheckListPhoto checkListPhoto;

  PhotoRemoved({required this.checkListPhoto});
  @override
  List<Object?> get props => [checkListPhoto];
}

class ScheduleLoadingBody extends DHLoadingState {}

class ScheduleLoadingButton extends DHLoadingState {}

class ScheduleAcceptedSuccess extends DHSuccessState {}

class ScheduleStartedSuccess extends DHSuccessState {}

class ScheduleFinishedSuccess extends DHSuccessState {}

class ScheduleSuggestedSuccess extends DHSuccessState {}

class ScheduleDeletedSuccess extends DHSuccessState {}
