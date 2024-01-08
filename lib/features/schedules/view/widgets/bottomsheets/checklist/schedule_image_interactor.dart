import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/sales_service.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/schedules_service.dart';

class CheckListPhotoInteractor {
  SchedulesService schedulesService =
      DHInjector.instance.get<SchedulesService>();

  SalesService saleService = DHInjector.instance.get<SalesService>();

  Future saveSchedulePhoto(CheckListPhoto checkListPhoto) async {
    return await schedulesService.savePhoto(checkListPhoto);
  }

  Future saveSalePhoto(CheckListPhoto checkListPhoto) async {
    return await saleService.saveSalePhoto(checkListPhoto);
  }
}

abstract class SendCheckListPhotoService {}

class RestSendCHeckListPhotoSchedule implements SendCheckListPhotoService {}
