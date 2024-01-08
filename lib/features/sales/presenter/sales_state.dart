// ignore_for_file: must_be_immutable

import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:image_picker/image_picker.dart';

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

class SaleNewPhotoCaptured extends DHState {
  final XFile file;

  SaleNewPhotoCaptured({required this.file});
  @override
  List<Object?> get props => [file];
}

class SalePhotoRemovindLoading extends DHState {
  final int id;
  SalePhotoRemovindLoading(this.id);
  @override
  List<Object?> get props => [id];
}

class SalePhotoRemoved extends DHState {
  final CheckListPhoto checkListPhoto;

  SalePhotoRemoved({required this.checkListPhoto});
  @override
  List<Object?> get props => [checkListPhoto];
}
