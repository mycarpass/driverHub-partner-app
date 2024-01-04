// ignore_for_file: must_be_immutable

import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/service/dto/pos_sales_response_dto.dart';

class PosSalesState extends DHState {}

class PosSalesFilteredState extends DHState {
  final List<PosSalesDto> posSales;
  final Map<DateTime, List<dynamic>> map;

  PosSalesFilteredState(
    this.posSales,
    this.map,
  );
  @override
  List<Object?> get props => [posSales, map];
}

class MadeContactStatusChanged extends DHState {
  final bool isMadeContact;

  MadeContactStatusChanged({required this.isMadeContact});

  @override
  List<Object?> get props => [isMadeContact];
}
