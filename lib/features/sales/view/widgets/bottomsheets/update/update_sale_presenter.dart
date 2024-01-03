import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/commom_objects/payment_type.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/sales/interactor/sales_interactor.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/create_sale_dto.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/bottomsheets/create_sale_state.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/cerate_schedule_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/service_date.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateSalePresenter extends Cubit<DHState> {
  UpdateSalePresenter() : super(DHInitialState()) {
    serviceDate.addDate(date: DateTime.now());
    _setScheduleDate(serviceDate.rawDate);
  }

  ServiceDate serviceDate = ServiceDate();

  ScheduleEntity scheduleEntity = ScheduleEntity();

  SalesInteractor interactor = DHInjector.instance.get<SalesInteractor>();

  final MoneyMaskedTextController moneyController =
      MoneyMaskedTextController(leftSymbol: "R\$ ", initialValue: 0.00);

  final MoneyMaskedTextController discountController =
      MoneyMaskedTextController(leftSymbol: "R\$ ", initialValue: 0.00);

  PaymentType paymentType = PaymentType.creditCard;

  void sendSale() async {
    try {
      emit(DHLoadingState());
      await interactor.saveSale(
        _toCreateSaleDto(
          scheduleEntity,
          MoneyValue(discountController.numberValue)
              .getStringValueWithoutSimbols(),
        ),
      );
      emit(NewSaleCreated());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  bool isEverythingFilled() {
    return scheduleEntity.date.isNotEmpty && scheduleEntity.services.isNotEmpty;
  }

  CreateSaleDto _toCreateSaleDto(
      ScheduleEntity scheduleEntity, String discontValue) {
    return CreateSaleDto(
      services: scheduleEntity.services,
      discontValue: discontValue,
      paymentType: paymentType,
      customerDto: scheduleEntity.customerDto,
      serviceDate: serviceDate,
    );
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
    emit(NewSaleDateSeleceted(serviceDate.rawDate));
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
