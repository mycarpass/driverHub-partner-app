import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/service_date.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSchedulePresenter extends Cubit<DHState> {
  CreateSchedulePresenter() : super(DHInitialState());

  ServiceDate serviceDate = ServiceDate();

  ScheduleEntity _scheduleEntity = ScheduleEntity();

  void updateServiceDate(DateTime dateTime) {
    serviceDate.addDate(date: dateTime);
    _setScheduleDate(serviceDate.rawDate);
    emit(NewDateSeleceted(serviceDate.rawDate));
  }

  void _setScheduleDate(String date) {
    _scheduleEntity.date = date;
  }

  void setScheduleHour(String hour) {
    _scheduleEntity.hour = hour;
  }

  void setScheduleService(ServiceDto serviceDto) {
    _scheduleEntity.serviceDto = serviceDto;
  }

  void setScheduleCustomer(CustomerDto customerDto) {
    _scheduleEntity.customerDto = customerDto;
  }
}

class ScheduleEntity {
  String hour = "";
  String date = "";
  CustomerDto customerDto = CustomerDto(
      customerId: 0,
      status: CustomerStatus.notVerified,
      name: "",
      phone: '',
      isSubscribed: false);
  ServiceDto serviceDto = ServiceDto(
      serviceId: 0,
      type: ServiceType.additional,
      category: ServiceCategory.wash,
      name: '');
}
