import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/services_interactor.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesPresenter extends Cubit<DHState> {
  ServicesPresenter() : super(DHInitialState());

  final ServicesInteractor _servicesInteractor =
      DHInjector.instance.get<ServicesInteractor>();

  ServicesResponseDto servicesResponseDto = ServicesResponseDto();

  Future<void> load() async {
    await _getServices();
  }

  Future _getServices() async {
    try {
      emit(DHLoadingState());
      //servicesResponseDto = await _servicesInteractor.getServices();
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
