import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:dio/dio.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/checklist/add_checklist_photo_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/checklist/get_device_image_interactor.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/checklist/schedule_image_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddChecklistPhotoPresenter extends Cubit<DHState> {
  AddChecklistPhotoPresenter() : super(DHInitialState());

  var getDeviceImageInteractor =
      DHInjector.instance.get<GetDeviceImageInteractor>();

  var checklistInteractor = DHInjector.instance.get<CheckListPhotoInteractor>();

  XFile? image;
  int? photoId;

  void takePhoto() async {
    try {
      emit(DHLoadingState());
      image = await getDeviceImageInteractor.captureImage();
      emit(CapturedPhotoState(image!));
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future<int> saveSchedulePhoto(CheckListPhoto checkListPhoto) async {
    try {
      emit(SavingPhotoState(checkListPhoto.file));
      Response response =
          await checklistInteractor.saveSchedulePhoto(checkListPhoto);
      return response.data["photo_id"];
    } catch (e) {
      emit(DHErrorState());
      rethrow;
    }
  }

  Future<int> saveSalePhoto(CheckListPhoto checkListPhoto) async {
    try {
      emit(SavingPhotoState(checkListPhoto.file));
      return await checklistInteractor.saveSalePhoto(checkListPhoto);
    } catch (e) {
      emit(DHErrorState());
      rethrow;
    }
  }

  void renovePhoto() {
    image = null;
    emit(DHInitialState());
    takePhoto();
  }
}
