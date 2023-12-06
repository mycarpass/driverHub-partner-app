import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/sales/interactor/sales_interactor.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesPresenter extends Cubit<DHState> {
  SalesPresenter() : super(DHInitialState());

  final SalesInteractor _salesInteractor =
      DHInjector.instance.get<SalesInteractor>();

  SalesResponseDto salesResponseDto = SalesResponseDto();

  Future<void> load() async {
    // await _getSales();
  }

  Future _getSales() async {
    try {
      emit(DHLoadingState());
      salesResponseDto = await _salesInteractor.getSales();
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
