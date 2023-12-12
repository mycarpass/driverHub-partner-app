import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/services_interactor.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';
import 'package:driver_hub_partner/features/services/presenter/services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesDropDownPresenter extends Cubit<DHState> {
  ServicesDropDownPresenter(
    this.loadOnlyPartnerRegisteredServices,
  ) : super(DHInitialState()) {}
  final bool loadOnlyPartnerRegisteredServices;

  final ServicesInteractor _servicesInteractor =
      DHInjector.instance.get<ServicesInteractor>();

  ServicesResponseDto servicesResponseDto = ServicesResponseDto();
  PartnerServicesResponseDto partnerServicesResponseDto =
      PartnerServicesResponseDto();

  ServiceEntity serviceEntity = ServiceEntity(null, "", "", null, null,
      ServiceCategory.wash, ServiceType.service, false);

  List<ServiceEntity> dropDownServices = [
    ServiceEntity(null, "Carregando aguarde...", "", null, null,
        ServiceCategory.services, ServiceType.service, false)
  ];

  List<ServiceEntity> dropDownWashes = [
    ServiceEntity(null, "Carregando aguarde...", "", null, null,
        ServiceCategory.wash, ServiceType.service, false)
  ];

  List<ServiceEntity> addtionalWashes = [
    ServiceEntity(2, "Cera", "Enceramento básico", null, null,
        ServiceCategory.wash, ServiceType.additional, true),
    ServiceEntity(3, "Cera Premium", "Enceramento com produto premium", null,
        null, ServiceCategory.wash, ServiceType.additional, true),
    ServiceEntity(
        76,
        "Revitalização de plásticos",
        "Revitalização de plásticos",
        null,
        null,
        ServiceCategory.wash,
        ServiceType.additional,
        true),
    ServiceEntity(39, "Selante cerâmico", "Selante cerâmico", null, null,
        ServiceCategory.wash, ServiceType.additional, true)
  ];

  Future<void> load() async {
    loadOnlyPartnerRegisteredServices
        ? await _getOnlyRegisteredServices()
        : await _getServicesDropDown();
  }

  Future _getOnlyRegisteredServices() async {
    try {
      emit(LoadingServicesDropdownState());
      partnerServicesResponseDto =
          await _servicesInteractor.getPartnersService();
      dropDownServices = partnerServicesResponseDto.servicesToEntityList();
      dropDownWashes = partnerServicesResponseDto.washesToEntityList();

      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future _getServicesDropDown() async {
    try {
      emit(LoadingServicesDropdownState());
      servicesResponseDto = await _servicesInteractor.getServicesDropDown();
      dropDownServices = servicesResponseDto.fetchServices();
      dropDownWashes = servicesResponseDto.fetchWashes();

      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  void selectServiceDropDown(ServiceEntity service) {
    serviceEntity.id = service.id;
    serviceEntity.name = service.name;
    serviceEntity.description = service.description;
    emit(DropDownServiceSelected(serviceEntity: service));
  }
}
