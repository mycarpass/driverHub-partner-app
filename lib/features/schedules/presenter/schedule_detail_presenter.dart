import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/schedules/interactor/schedules_interactor.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/enum/schedule_status.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/request_new_hours_suggest.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedule_detail_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/confirm_delete_schedule_action.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/confirm_finish_schedule_action.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/confirm_start_schedule_action.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/new_dates_schedule_action.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/receipt/receipt_schedule_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notification_center/notification_center.dart';

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

  void addPhotoToCheckList(XFile photo) {
    scheduleDataDto.photoList.add(
      CheckListPhoto(
        id: "",
        file: photo,
      ),
    );
    emit(NewPhotoCaptured(file: photo));
  }

  void removePhoto(CheckListPhoto photo) async {
    try {
      emit(SchedulePhotoRemoveLoading());
      await Future.delayed(const Duration(seconds: 2));
      scheduleDataDto.photoList.removeWhere(
        (element) => element.id == photo.id,
      );
      emit(PhotoRemoved(checkListPhoto: photo));
    } catch (e) {
      emit(DHErrorState(
          error:
              "Infelizmente não foi possível remover a foto, tente novamente mais tarde"));
    }
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

  Future finishSchedule(int? paymentType) async {
    try {
      emit(ScheduleLoadingButton());
      await _schedulesInteractor.finishSchedule(scheduleId, paymentType);
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
        NotificationCenter().notify('updateSchedules');
      case ScheduleStatus.waitingToWork:
        // ignore: use_build_context_synchronously
        dynamic isConfirmed = await showModalBottomSheet<bool>(
            context: context,
            builder: (BuildContext context) {
              return const ConfirmStartScheduleWidget();
            });
        if (isConfirmed != null && isConfirmed) {
          await startSchedule();
          NotificationCenter().notify('updateSchedules');
        }

      case ScheduleStatus.inProgress:
        if (scheduleDataDto.paymentType == null ||
            scheduleDataDto.paymentType == "" ||
            scheduleDataDto.paymentType == "IN_STORE") {
          // ignore: use_build_context_synchronously
          dynamic paymentType = await showModalBottomSheet<int?>(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return const ConfirmFinishScheduleWidget();
              });
          if (paymentType != null) {
            await finishSchedule(paymentType);
          }
        } else {
          await finishSchedule(null);
        }
        NotificationCenter().notify('updateSchedules');

      default:
        return null;
    }
  }

  void deleteSchedule(BuildContext context) async {
    dynamic isDeleted = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const ConfirmDeleteScheduleWidget();
        });
    if (isDeleted != null && isDeleted) {
      await callDeleteSchedule();
    }
  }

  Future callDeleteSchedule() async {
    try {
      emit(ScheduleLoadingButton());
      await _schedulesInteractor.deleteSchedule(scheduleId);
      emit(ScheduleDeletedSuccess());
      NotificationCenter().notify('updateSchedules');
    } catch (e) {
      emit(DHErrorState());
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
      NotificationCenter().notify('updateSchedules');
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

  ReceiptScheduleEntity getScheduleReceiptEntity() {
    String scheduleDate =
        '${scheduleDataDto.scheduleDate} às ${timeSuggestionSelected.time}';

    List<String> services = [];
    for (var service in scheduleDataDto.selectedServices.items) {
      MoneyValue price = MoneyValue(service.price);
      services.add("${service.service} (${price.priceInReal})");
    }

    ReceiptScheduleEntity entity = ReceiptScheduleEntity(
        customerName: scheduleDataDto.client.name,
        partnerName: scheduleDataDto.partner?.name ?? "",
        partnerLogo: scheduleDataDto.partner?.logo,
        services: services,
        total: MoneyValue(scheduleDataDto.totalAmountPayable ?? "0,00"),
        vehicle: scheduleDataDto.vehicle,
        scheduleDate: scheduleDate);
    return entity;
  }
}
