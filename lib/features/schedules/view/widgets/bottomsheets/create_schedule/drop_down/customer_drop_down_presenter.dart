import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/customers/interactor/customers_interactor.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/enum/service_type.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';
import 'package:driver_hub_partner/features/services/presenter/services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDropDownPresenter extends Cubit<DHState> {
  CustomerDropDownPresenter() : super(DHInitialState());

  final CustomersInteractor _customersInteractor =
      DHInjector.instance.get<CustomersInteractor>();

  CustomersResponseDto customersResponseDto = CustomersResponseDto();

  ServiceEntity serviceEntity = ServiceEntity(null, "", "", null, null,
      ServiceCategory.wash, ServiceType.service, false);

  late CustomerDto selecetedCustomer;

  Future<void> load() async {
    customersResponseDto.customers = [
      CustomerDto(
          customerId: 0,
          status: CustomerStatus.notVerified,
          name: "Carregando lista",
          phone: "xxxxx",
          isSubscribed: false)
    ];
    _getCustomers();
  }

  Future _getCustomers() async {
    try {
      emit(LoadingServicesDropdownState());
      customersResponseDto = await _customersInteractor.getCustomers();
      if (customersResponseDto.customers.isEmpty) {
        customersResponseDto.customers = [
          CustomerDto(
              customerId: 0,
              status: CustomerStatus.notVerified,
              name: "Nenhum cliente cadastrado",
              phone: "xxxxx",
              isSubscribed: false)
        ];
        emit(EmptyDropdownState());
      }

      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  void selectServiceDropDown(CustomerDto customerDto) {
    selecetedCustomer = customerDto;
    emit(CustomerSelected(customer: selecetedCustomer));
  }
}

class CustomerSelected extends DHState {
  final CustomerDto customer;

  CustomerSelected({required this.customer});

  @override
  List<Object?> get props => [customer];
}
