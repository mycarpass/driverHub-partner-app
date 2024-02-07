import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/receivable_dto.dart';
import 'package:driver_hub_partner/features/home/interactor/subscription_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceivablePresenter extends Cubit<DHState> {
  ReceivablePresenter() : super(DHInitialState());

  SubscriptionInteractor interactor =
      DHInjector.instance.get<SubscriptionInteractor>();

  late ReceivableDto receivableDto;

  Future<void> getReceivable() async {
    try {
      emit(DHLoadingState());
      receivableDto = await interactor.getReceivable();
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
