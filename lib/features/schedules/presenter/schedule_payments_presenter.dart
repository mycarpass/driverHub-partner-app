import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/schedules/interactor/schedules_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePaymentsPresenter extends Cubit<DHState> {
  SchedulePaymentsPresenter() : super(DHInitialState());

  var interactor = DHInjector.instance.get<SchedulesInteractor>();

  void load(DateTime month) async {
    try {
      emit(DHLoadingState());
      await interactor.getMonthPayments();
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
