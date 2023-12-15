// ignore_for_file: must_be_immutable

import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';

class SalesState extends DHState {}

class SalesFilteredState extends DHState {
  final List<SalesDto> sales;
  final Map<DateTime, List<dynamic>> map;

  SalesFilteredState(
    this.sales,
    this.map,
  );
  @override
  List<Object?> get props => [sales, map];
}
