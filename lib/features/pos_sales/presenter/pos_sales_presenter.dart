import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/pos_sales_interactor.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/service/dto/pos_sales_response_dto.dart';
import 'package:driver_hub_partner/features/pos_sales/presenter/pos_sales_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PosSalesPresenter extends Cubit<DHState> {
  PosSalesPresenter() : super(DHInitialState());

  final PosSalesInteractor _posSalesInteractor =
      DHInjector.instance.get<PosSalesInteractor>();

  PosSalesResponseDto posSalesResponseDto = PosSalesResponseDto();

  DateTime selectedMonth = DateTime.now();

  List<PosSalesDto> filteredList = [];

  Map<DateTime, List<dynamic>> mapListFiltered = {};

  Future<void> load() async {
    await _getPosSales();
    filterListByDate(DateTime.now());
  }

  Future _getPosSales() async {
    try {
      emit(DHLoadingState());
      posSalesResponseDto = await _posSalesInteractor.getPosSales();
      filteredList = _filterByDate(DateTime.now());
      emit(DHSuccessState());
    } catch (e) {
      emit(DHErrorState());
    }
  }

  Future<void> filterListByDate(DateTime dateTime) async {
    selectedMonth = dateTime;
    filteredList = _filterByDate(dateTime);
    await mapFromFilteredList();
    emit(
      PosSalesFilteredState(
        filteredList,
        mapListFiltered,
      ),
    );
    emit(DHSuccessState());
  }

  List<PosSalesDto> _filterByDate(DateTime date) {
    return posSalesResponseDto.posSales
        .where(
          (element) =>
              element.posSaleDate.month == date.month &&
              element.posSaleDate.year == date.year,
        )
        .toList();
  }

  Future<void> mapFromFilteredList() async {
    Map<DateTime, List<dynamic>> map = {};

    for (var i = 0; i <= 30; i++) {
      var listFilter = filteredList
          .where((element) => element.posSaleDate.day == i + 1)
          .toList();
      if (listFilter.isNotEmpty) {
        map[listFilter.first.posSaleDate] = listFilter;
      }
    }

    mapListFiltered = map;
  }
}
