import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/customers/interactor/customers_interactor.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomersPresenter extends Cubit<DHState> {
  CustomersPresenter() : super(DHInitialState());

  final CustomersInteractor _customersInteractor =
      DHInjector.instance.get<CustomersInteractor>();

  CustomersResponseDto customersResponseDto = CustomersResponseDto();

  Future<void> load() async {
    // await _getCustomers();
  }

  Future _getCustomers() async {
    try {
      emit(DHLoadingState());
      customersResponseDto = await _customersInteractor.getCustomers();
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
