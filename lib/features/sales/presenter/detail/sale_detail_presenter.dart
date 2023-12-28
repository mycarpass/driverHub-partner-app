import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/sales/interactor/sales_interactor.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sale_details_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaleDetailsPresenter extends Cubit<DHState> {
  SaleDetailsPresenter() : super(DHInitialState());

  final SalesInteractor _salesInteractor =
      DHInjector.instance.get<SalesInteractor>();
  late SaleDetailsDto saleDetailsDto;

  void load(String id) async {
    try {
      emit(DHLoadingState());
      saleDetailsDto = await _salesInteractor.getDetails(id);
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
