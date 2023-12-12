import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/schedules/interactor/schedules_interactor.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_state.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/service_date.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulesPresenter extends Cubit<DHState> {
  SchedulesPresenter() : super(DHInitialState());

  final SchedulesInteractor _schedulesInteractor =
      DHInjector.instance.get<SchedulesInteractor>();

  SchedulesResponseDto schedulesResponseDto = SchedulesResponseDto();

  List<ScheduleDataDto> filteredList = [];
  DateTime selectedMonth = DateTime.now();
  Map<DateTime, List<dynamic>> mapListFiltered = {};

  Future<void> load() async {
    await _getSchedules();
  }

  Future _getSchedules() async {
    try {
      emit(DHLoadingState());
      var response = await _schedulesInteractor.getSchedules();
      schedulesResponseDto = response;

      filteredList = schedulesResponseDto.data.filterByDate(DateTime.now());
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future<void> filterListByDate(DateTime dateTime) async {
    selectedMonth = dateTime;
    filteredList = schedulesResponseDto.data.filterByDate(dateTime);
    await mapFromFilteredList();
    emit(
      FilteredListState(schedules: filteredList, map: mapListFiltered),
    );
  }

  Future<void> mapFromFilteredList() async {
    Map<DateTime, List<dynamic>> map = {};

    for (var i = 0; i <= 30; i++) {
      var listFilter = filteredList
          .where((element) => element.scheduleDateTime.day == i + 1)
          .toList();
      if (listFilter.isNotEmpty) {
        map[listFilter.first.scheduleDateTime] = listFilter;
      }
    }

    mapListFiltered = map;
  }
}
