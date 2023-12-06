import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/customers/interactor/customers_interactor.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomersPresenter extends Cubit<DHState> {
  CustomersPresenter() : super(DHInitialState());

  final CustomersInteractor _customersInteractor =
      DHInjector.instance.get<CustomersInteractor>();

  CustomersResponseDto customersResponseDto = CustomersResponseDto();
  List<CustomerDto> subscribers = [];
  Future<void> load() async {
    await _getCustomers();
  }

  Future _getCustomers() async {
    try {
      emit(DHLoadingState());
      // customersResponseDto = await _customersInteractor.getCustomers();
      customersResponseDto = CustomersResponseDto();

      CustomerDto customerDto1 = CustomerDto(
          customerId: 1,
          status: CustomerStatus.notVerified,
          isSubscribed: false,
          name: "Carlos Henrique",
          phone: "(34) 99199-2313");
      CustomerDto customerDto2 = CustomerDto(
          customerId: 2,
          status: CustomerStatus.verified,
          isSubscribed: true,
          name: "Rafael Zanin",
          phone: "(34) 99199-8372");
      CustomerDto customerDto3 = CustomerDto(
          customerId: 3,
          status: CustomerStatus.notVerified,
          isSubscribed: false,
          name: "Carlos Henrique",
          phone: "(34) 21323-2313");
      CustomerDto customerDto4 = CustomerDto(
          customerId: 4,
          status: CustomerStatus.notVerified,
          isSubscribed: false,
          name: "Carlos Henrique",
          phone: "(34) 21111-2343");
      List<CustomerDto> customers = [];
      customers.add(customerDto1);
      customers.add(customerDto2);
      customers.add(customerDto3);
      customers.add(customerDto4);
      customersResponseDto.customers = customers;
      _filterSubscribers();
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  void _filterSubscribers() {
    subscribers = customersResponseDto.customers
        .where(
          (element) => element.isSubscribed,
        )
        .toList();
  }
}
