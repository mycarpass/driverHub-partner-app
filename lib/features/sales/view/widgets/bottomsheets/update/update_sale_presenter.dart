import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:driver_hub_partner/features/commom_objects/payment_type.dart';
import 'package:driver_hub_partner/features/commom_objects/person_name.dart';
import 'package:driver_hub_partner/features/commom_objects/phone_value.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/sales/interactor/sales_interactor.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/update_sale_dto.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/bottomsheets/create_sale_state.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/bottomsheets/update/update_sale_state.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/cerate_schedule_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/service_date.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_center/notification_center.dart';

class UpdateSalePresenter extends Cubit<DHState> {
  UpdateSalePresenter() : super(DHInitialState()) {
    serviceDate.addDate(date: DateTime.now());
    _setScheduleDate(serviceDate.rawDate);
  }
  bool showCustomerDropDown = false;

  bool showPaymentTypeDropDown = false;

  ServiceDate serviceDate = ServiceDate();

  ScheduleEntity scheduleEntity = ScheduleEntity();

  SalesInteractor interactor = DHInjector.instance.get<SalesInteractor>();

  final MoneyMaskedTextController moneyController =
      MoneyMaskedTextController(leftSymbol: "R\$ ", initialValue: 0.00);

  final MoneyMaskedTextController discountController =
      MoneyMaskedTextController(leftSymbol: "R\$ ", initialValue: 0.00);

  PaymentType paymentType = PaymentType.creditCard;

  void update(int id) async {
    try {
      emit(DHLoadingState());
      await interactor.updateSale(
        _toUpdateSaleDto(
          scheduleEntity,
          MoneyValue(discountController.numberValue)
              .getStringValueWithoutSimbols(),
          id,
        ),
      );

      emit(SaleUpdatedState());
      NotificationCenter().notify('updateSales');
    } catch (e) {
      emit(DHErrorState());
    }
  }

  void calculateDiscount() {
    if (scheduleEntity.services.isEmpty) {
      return;
    }
    if (discountController.numberValue == 0) {
      moneyController.updateValue(scheduleEntity.value.price);
    } else {
      MoneyValue calculatedDiscount = MoneyValue(scheduleEntity.value.price)
        ..sub(discountController.numberValue);
      moneyController.updateValue(calculatedDiscount.price);
    }
    emit(DiscountApliedState(discountValue: moneyController.numberValue));
  }

  void changePaymentType() {
    showPaymentTypeDropDown = true;
    emit(ChangePaymentTypeState());
  }

  void changeCustomer() {
    setScheduleCustomer(CustomerDto(
        customerId: 0,
        status: CustomerStatus.notVerified,
        name: PersonName(""),
        phone: PhoneValue(value: ""),
        isSubscribed: false));

    showCustomerDropDown = true;
    emit(ChangeCustomerState());
  }

  bool isEverythingFilled() {
    return scheduleEntity.date.isNotEmpty && scheduleEntity.services.isNotEmpty;
  }

  UpdateSaleDto _toUpdateSaleDto(
      ScheduleEntity scheduleEntity, String discontValue, int id) {
    return UpdateSaleDto(
      id: id,
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

  void addScheduleServiceWithBasePrice(ServiceDto serviceDto) {
    scheduleEntity.addServiceWithBasePrice(serviceDto);
    moneyController.updateValue(
      scheduleEntity.value.price,
    );
    emit(ServiceAddeedState(serviceDto));
  }

  void addScheduleService(ServiceDto serviceDto) {
    scheduleEntity.addService(serviceDto);
    scheduleEntity.services.length == 1
        ? calculateDiscount()
        : moneyController.updateValue(
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

  void addInitialDiscount() {
    MoneyValue calculatedDiscount = MoneyValue(scheduleEntity.value.price)
      ..sub(discountController.numberValue);
    moneyController.updateValue(calculatedDiscount.price);

    emit(DiscountApliedState(discountValue: moneyController.numberValue));
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
