import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/services_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_center/notification_center.dart';

class ServicesPresenter extends Cubit<DHState> {
  ServicesPresenter() : super(DHInitialState());

  final ServicesInteractor _servicesInteractor =
      DHInjector.instance.get<ServicesInteractor>();

  PartnerServicesResponseDto partnerServicesResponseDto =
      PartnerServicesResponseDto();

  Future<void> load() async {
    NotificationCenter().subscribe('updatedService', _getServices);
    await _getServices();
  }

  Future _getServices() async {
    try {
      emit(DHLoadingState());
      partnerServicesResponseDto =
          await _servicesInteractor.getPartnersService();
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
