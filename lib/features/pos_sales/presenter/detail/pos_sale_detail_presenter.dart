import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/pos_sales_interactor.dart';
import 'package:driver_hub_partner/features/pos_sales/presenter/pos_sales_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PosSaleDetailsPresenter extends Cubit<DHState> {
  PosSaleDetailsPresenter() : super(DHInitialState());

  final PosSalesInteractor _posSalesInteractor =
      DHInjector.instance.get<PosSalesInteractor>();

  void load(String id) async {
    // try {
    //   emit(DHLoadingState());
    //   saleDetailsDto = await _salesInteractor.getDetails(id);
    //   emit(DHSuccessState());
    // } catch (e) {
    //   emit(DHErrorState());
    // }
  }

  Future<void> changeMadeContact(bool isMadeContact, int posSaleId) async {
    try {
      emit(CheckBoxLoadingState());
      await _posSalesInteractor.changeMadeContact(isMadeContact, posSaleId);
      emit(MadeContactStatusChanged(isMadeContact: isMadeContact));
    } catch (e) {
      emit(DHErrorState());
    }
  }
}

class CheckBoxLoadingState extends DHLoadingState {
  @override
  List<Object?> get props => [];
}
