import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/service_details_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/services_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceDetailsPresenter extends Cubit<DHState> {
  ServiceDetailsPresenter() : super(DHInitialState());
  ServicesInteractor servicesInteractor =
      DHInjector.instance.get<ServicesInteractor>();

  late ServiceDetailsDto serviceDetailsDto;

  void load(String id) async {
    try {
      emit(DHLoadingState());
      serviceDetailsDto = await servicesInteractor.getServiceDetails(id);
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
