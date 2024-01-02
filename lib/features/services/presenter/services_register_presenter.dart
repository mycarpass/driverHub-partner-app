import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/services_interactor.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';
import 'package:driver_hub_partner/features/services/presenter/services_state.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesRegisterPresenter extends Cubit<DHState> {
  ServicesRegisterPresenter() : super(DHInitialState());

  final ServicesInteractor _servicesInteractor =
      DHInjector.instance.get<ServicesInteractor>();

  ServicesResponseDto servicesResponseDto = ServicesResponseDto();

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

  var descriptionController = TextEditingController();

  final MoneyMaskedTextController moneyBaseController =
      MoneyMaskedTextController(
          decimalSeparator: ",", leftSymbol: "R\$", initialValue: 0.00);

  final MoneyMaskedTextController priceHatchController =
      MoneyMaskedTextController(
          decimalSeparator: ",", leftSymbol: "R\$", initialValue: 0.00);

  final MoneyMaskedTextController priceSedanController =
      MoneyMaskedTextController(
          decimalSeparator: ",", leftSymbol: "R\$", initialValue: 0.00);

  final MoneyMaskedTextController priceSuvController =
      MoneyMaskedTextController(
          decimalSeparator: ",", leftSymbol: "R\$", initialValue: 0.00);

  final MoneyMaskedTextController pricePickupController =
      MoneyMaskedTextController(
          decimalSeparator: ",", leftSymbol: "R\$", initialValue: 0.00);

  final MoneyMaskedTextController priceRAMController =
      MoneyMaskedTextController(
          decimalSeparator: ",", leftSymbol: "R\$", initialValue: 0.00);

  Future<void> load() async {
    await _getServicesDropDown();
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

  Future saveService() async {
    try {
      emit(DHLoadingState());
      _fillPrices();
      _fillAdditionalWashes();

      await _servicesInteractor.saveService(serviceEntity);

      emit(ServiceRegisteredSuccessful());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future updateService() async {
    try {
      emit(DHLoadingState());
      _fillPrices();
      _fillAdditionalWashes();
      if (serviceEntity.isAllPricesFilled()) {
        await _servicesInteractor.updateService(serviceEntity);

        emit(ServiceRegisteredSuccessful());
      } else {
        emit(DHErrorState(
            error: "Preencha todos os preços para todas as carrocerias"));
      }
    } catch (e) {
      emit(DHErrorState());
    }
  }

  void _fillPrices() {
    serviceEntity.prices = [];
    ServiceRequestPrice priceHatch = ServiceRequestPrice(
      CarBodyType.hatchback,
      MoneyValue(priceHatchController.numberValue),
      0,
    );
    ServiceRequestPrice priceSedan = ServiceRequestPrice(
      CarBodyType.sedan,
      MoneyValue(priceSedanController.numberValue),
      0,
    );
    ServiceRequestPrice priceSuv = ServiceRequestPrice(
      CarBodyType.suv,
      MoneyValue(priceSuvController.numberValue),
      0,
    );
    ServiceRequestPrice pricePickup = ServiceRequestPrice(
      CarBodyType.pickup,
      MoneyValue(pricePickupController.numberValue),
      0,
    );
    ServiceRequestPrice priceRAM = ServiceRequestPrice(
      CarBodyType.ram,
      MoneyValue(priceRAMController.numberValue),
      0,
    );

    serviceEntity.prices.add(priceHatch);
    serviceEntity.prices.add(priceSedan);
    serviceEntity.prices.add(priceSuv);
    serviceEntity.prices.add(pricePickup);
    serviceEntity.prices.add(priceRAM);
  }

  void _fillAdditionalWashes() {
    serviceEntity.additionalWashes = null;
    List<ServiceEntity> additionalWashesSelected =
        addtionalWashes.where((i) => i.isSelected ?? false).toList();
    if (additionalWashesSelected.isNotEmpty) {
      List<AddtionalWashRequest> additionalWashesRequest = [];
      serviceEntity.additionalWashes = [];
      for (var additionalWash in additionalWashesSelected) {
        AddtionalWashRequest addtionalWashRequest = AddtionalWashRequest(
            additionalWash.id ?? 0, additionalWash.basePrice.toString());
        additionalWashesRequest.add(addtionalWashRequest);
      }
      serviceEntity.additionalWashes = additionalWashesRequest;
    }
  }

  void selectServiceDropDown(ServiceEntity service) {
    serviceEntity.id = service.id;
    serviceEntity.name = service.name;
    serviceEntity.description = service.description;
    descriptionController.text = service.description ?? "";
    emit(DropDownServiceSelected(serviceEntity: service));
  }

  void setServiceCategory(String category, {bool shouldCleanData = true}) {
    if (shouldCleanData) {
      serviceEntity.id = null;
      serviceEntity.name = "";
      serviceEntity.description = "";
    }

    switch (category) {
      case "Lavada":
        serviceEntity.category = ServiceCategory.wash;
        break;
      default:
        serviceEntity.category = ServiceCategory.services;
        break;
    }
    emit(CategoryServiceIsChanged(category: category));
  }

  void setIsLiveOnApp(bool isLiveOnApp) {
    serviceEntity.isLiveOnApp = isLiveOnApp;
    emit(IsLiveOnAppChanged(isLiveOnApp: isLiveOnApp));
  }

  void selectAddtionalService(int index, bool isSelected) {
    addtionalWashes[index].isSelected = isSelected;
    emit(WashAddtionalIsSelected(index: index, isSelected: isSelected));
  }

  bool isValideToContinue() {
    if (serviceEntity.isLiveOnApp) {
      if (serviceEntity.name.isNotEmpty &&
          serviceEntity.description != null &&
          serviceEntity.description!.isNotEmpty &&
          serviceEntity.serviceTimeHours != null &&
          serviceEntity.serviceTimeHours!.isNotEmpty) {
        return true;
      }
      return false;
    } else {
      if (serviceEntity.name.isNotEmpty) {
        return true;
      }
      return false;
    }
  }

  void setBasePriceAddtionalService(int index, String basePrice) {
    addtionalWashes[index].basePrice = basePrice;
  }
}
