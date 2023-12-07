import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/customers/interactor/customers_interactor.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customer_register_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerRegisterPresenter extends Cubit<DHState> {
  CustomerRegisterPresenter() : super(DHInitialState());

  final CustomersInteractor customersInteractor =
      DHInjector.instance.get<CustomersInteractor>();

  Future<void> register(
      {required String name,
      required String phone,
      required String plate}) async {
    try {
      emit(DHLoadingState());

      await customersInteractor.registerCustomer(
          CustomerRegisterDto(name: name, plate: plate, phone: phone));
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
