import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/commom_objects/person_name.dart';
import 'package:driver_hub_partner/features/commom_objects/phone_value.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/schedules/interactor/schedules_interactor.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/cerate_schedule_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/service_date.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSchedulePresenter extends Cubit<DHState> {
  CreateSchedulePresenter() : super(DHInitialState()) {
    serviceDate.addDate(date: DateTime.now());
    _setScheduleDate(serviceDate.rawDate);
  }

  ServiceDate serviceDate = ServiceDate();

  ScheduleEntity scheduleEntity = ScheduleEntity();

  SchedulesInteractor interactor =
      DHInjector.instance.get<SchedulesInteractor>();

  final MoneyMaskedTextController moneyController =
      MoneyMaskedTextController(leftSymbol: "R\$ ", initialValue: 0.00);

  void sendSchedule() async {
    try {
      emit(DHLoadingState());
      await interactor.registerNewSchedule(scheduleEntity);
      emit(NewScheduleCreatedState());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  MoneyValue getPriceByCarBodyType(ServiceDto serviceDto) {
    return serviceDto.getPriceByCarBodyType(
        scheduleEntity.customerDto.manualBodyTypeSelected ??
            scheduleEntity.customerDto.vehicle?.bodyType ??
            CarBodyType.sedan);
  }

  void updateServiceDate(DateTime dateTime) {
    serviceDate.addDate(date: dateTime);
    _setScheduleDate(serviceDate.rawDate);
    emit(NewDateSeleceted(serviceDate.rawDate));
  }

  void _setScheduleDate(String date) {
    scheduleEntity.date = date;
  }

  void setScheduleHour(String hour) {
    scheduleEntity.hour = hour;
  }

  void setScheduleCustomer(CustomerDto customerDto) {
    scheduleEntity.customerDto = customerDto;
    emit(DHSuccessState());
  }

  void addScheduleService(ServiceDto serviceDto) {
    scheduleEntity.addService(serviceDto);
    moneyController.updateValue(
      scheduleEntity.value.price,
    );
    emit(ServiceAddeedState(serviceDto));
  }

  void removeScheduleService(ServiceDto serviceDto) {
    scheduleEntity.removeService(serviceDto);
    moneyController.updateValue(
      scheduleEntity.value.price,
    );
    emit(ServiceRemovedState(serviceDto: serviceDto));
  }

  void recalculateService() {
    scheduleEntity.recalculatePrices();
    emit(ServicesRecalculatedState(scheduleEntity.customerDto));
  }

  void setValue(String value) {
    scheduleEntity.value = MoneyValue(value);
  }

  void manualSetOfCarBodyType(CarBodyType carBodyType) {
    scheduleEntity.customerDto.vehicle = VehicleDto(
        id: 0,
        name: "Não informado",
        make: "",
        model: "",
        bodyType: carBodyType,
        plate: "");
    scheduleEntity.customerDto.manualBodyTypeSelected = carBodyType;
    emit(NewBodyTypeSeleceted(carBodyType: carBodyType));
  }

  void alterPrice(ServiceDto serviceDto, double newPrice) {
    scheduleEntity.alterPrice(serviceDto, newPrice);
    moneyController.updateValue(
      scheduleEntity.value.price,
    );
    emit(ServicePriceChanged(price: newPrice));
  }
}

class ScheduleEntity {
  String hour = "";
  String date = "";
  CustomerDto customerDto = CustomerDto(
      customerId: 0,
      status: CustomerStatus.notVerified,
      name: PersonName(""),
      phone: PhoneValue(value: ""),
      isSubscribed: false);

  List<ServiceDto> services = [];

  MoneyValue value = MoneyValue("0,00");

  Map<String, dynamic> toJson() {
    var map = {
      "lead_partner_id": customerDto.customerId,
      "vehicle": {
        "car_body_type": customerDto.manualBodyTypeSelected?.toInt() ??
            customerDto.vehicle?.bodyType.toInt() ??
            0
      },
      "scheduled_date": date,
      "time_suggestions": [
        {"time": hour}
      ],
      "services": _servicesToJson()
    };

    return map;
  }

  bool isEverythingFilled() {
    return hour.isNotEmpty && date.isNotEmpty && services.isNotEmpty;
  }

  bool containsVehicle() {
    return customerDto.vehicle != null && customerDto.vehicle?.model != "";
  }

  void alterPrice(ServiceDto serviceDto, double newPrice) {
    ServiceDto service = services
        .where((element) => element.serviceId == serviceDto.serviceId)
        .toList()
        .first;

    int index = services.indexOf(service);

    for (var price in service.prices) {
      price.price = MoneyValue(newPrice);
    }
    services[index] = service;
    recalculatePrices();
  }

  List<Map<String, dynamic>> _servicesToJson() {
    return [
      ...services.map(
        (e) => {
          "price_id": e
              .finPrice(customerDto.vehicle?.bodyType ??
                  customerDto.manualBodyTypeSelected!)
              .priceId,
          "value": e
              .getPriceByCarBodyType(customerDto.vehicle?.bodyType ??
                  customerDto.manualBodyTypeSelected!)
              .getStringValueWithoutSimbols()
        },
      )
    ];
  }

  bool matchCustomerCarBodyType(CarBodyType carBodyType) {
    return customerDto.manualBodyTypeSelected == carBodyType;
  }

  bool isCustomerAndVehicleAlreadySetted() {
    return customerDto.customerId != 0 && !customerDto.isVehicleNull();
  }

  void addServiceWithBasePrice(ServiceDto serviceDto) {
    value.sum(serviceDto.chargedPrice?.price ?? 0);

    services.add(serviceDto);
  }

  void addService(ServiceDto serviceDto) {
    if (customerDto.vehicle != null) {
      try {
        value.sum(serviceDto.prices
            .where((element) =>
                element.carBodyType == customerDto.vehicle!.bodyType)
            .first
            .price
            .price);
      } catch (e) {
        value.sum(serviceDto.prices.first.price.price);
      }
    }
    services.add(serviceDto);
  }

  void removeService(ServiceDto serviceDto) {
    try {
      value.sub(serviceDto.prices
          .where(
              (element) => element.carBodyType == customerDto.vehicle!.bodyType)
          .first
          .price
          .price);
    } catch (e) {
      if (serviceDto.chargedPrice != null) {
        value.sub(serviceDto.chargedPrice!.price);
      } else {
        ///Usando o valor do hatch quando não existe preço cadastrado para a carroceria desejada
        value.sub(serviceDto.prices
            .where((element) => element.carBodyType == CarBodyType.hatchback)
            .first
            .price
            .price);
      }
    }

    services.remove(serviceDto);
  }

  void recalculatePrices() {
    if (customerDto.vehicle != null) {
      for (ServiceDto serviceElement in services) {
        try {
          value.sum(serviceElement.prices
              .where((element) =>
                  element.carBodyType == customerDto.vehicle!.bodyType)
              .first
              .price
              .price);
        } catch (e) {
          value.sum(serviceElement.prices
              .where((element) =>
                  element.carBodyType == customerDto.manualBodyTypeSelected)
              .first
              .price
              .price);
        }
      }
    }
  }
}
