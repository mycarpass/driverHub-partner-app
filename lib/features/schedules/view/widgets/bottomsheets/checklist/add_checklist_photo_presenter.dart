import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/checklist/add_checklist_photo_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/checklist/get_device_image_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddChecklistPhotoPresenter extends Cubit<DHState> {
  AddChecklistPhotoPresenter() : super(DHInitialState());

  var getDeviceImageInteractor =
      DHInjector.instance.get<GetDeviceImageInteractor>();

  XFile? image;

  void takePhoto() async {
    try {
      emit(DHLoadingState());
      image = await getDeviceImageInteractor.captureImage();
      emit(CapturedPhotoState(image!));
    } catch (e) {
      emit(DHErrorState());
    }
  }

  void renovePhoto() {
    image = null;
    emit(DHInitialState());
    takePhoto();
  }
}
