import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/interactor/schedules_interactor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulesPresenter extends Cubit<DHState> {
  SchedulesPresenter() : super(DHInitialState());

  final SchedulesInteractor _schedulesInteractor =
      DHInjector.instance.get<SchedulesInteractor>();

  SchedulesResponseDto schedulesResponseDto = SchedulesResponseDto();

  Future<void> load() async {
    await _getSchedules();
  }

  Future _getSchedules() async {
    try {
      emit(DHLoadingState());
      schedulesResponseDto = await _schedulesInteractor.getSchedules();
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
