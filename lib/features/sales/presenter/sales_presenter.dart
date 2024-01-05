import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/sales/interactor/sales_interactor.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/sales/presenter/sales_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_center/notification_center.dart';

class SalesPresenter extends Cubit<DHState> {
  SalesPresenter() : super(DHInitialState());

  final SalesInteractor _salesInteractor =
      DHInjector.instance.get<SalesInteractor>();

  SalesResponseDto salesResponseDto = SalesResponseDto();

  DateTime selectedMonth = DateTime.now();

  List<SalesDto> filteredList = [];

  Map<DateTime, List<dynamic>> mapListFiltered = {};

  Future<void> load() async {
    NotificationCenter().subscribe('updateSales', reload);

    await _getSales();
    filterListByDate(DateTime.now());
  }

  Future<void> reload() async {
    await _getSales();
    filterListByDate(DateTime.now());
  }

  Future _getSales() async {
    try {
      emit(DHLoadingState());
      salesResponseDto = await _salesInteractor.getSales();
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
      SalesFilteredState(
        filteredList,
        mapListFiltered,
      ),
    );
    emit(DHSuccessState());
  }

  List<SalesDto> _filterByDate(DateTime date) {
    return salesResponseDto.sales
        .where(
          (element) =>
              element.saleDate.month == date.month &&
              element.saleDate.year == date.year,
        )
        .toList();
  }

  Future<void> mapFromFilteredList() async {
    Map<DateTime, List<dynamic>> map = {};

    for (var i = 0; i <= 30; i++) {
      var listFilter = filteredList
          .where((element) => element.saleDate.day == i + 1)
          .toList();
      if (listFilter.isNotEmpty) {
        map[listFilter.first.saleDate] = listFilter;
      }
    }

    mapListFiltered = map;
  }
}
