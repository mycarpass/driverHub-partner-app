// ignore_for_file: must_be_immutable

import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/services/presenter/entities/service_entity.dart';

class ServicesState extends DHState {}

class DropDownServiceSelected extends DHState {
  final ServiceEntity serviceEntity;

  DropDownServiceSelected({required this.serviceEntity});
  @override
  List<Object?> get props => [serviceEntity];
}

class IsLiveOnAppChanged extends DHState {
  final bool isLiveOnApp;

  IsLiveOnAppChanged({required this.isLiveOnApp});
  @override
  List<Object?> get props => [isLiveOnApp];
}

class CategoryServiceIsChanged extends DHState {
  final String category;

  CategoryServiceIsChanged({required this.category});
  @override
  List<Object?> get props => [category];
}

class WashAddtionalIsSelected extends DHState {
  final int index;
  final bool isSelected;

  WashAddtionalIsSelected({required this.index, required this.isSelected});
  @override
  List<Object?> get props => [index, isSelected];
}

class LoadingServicesDropdownState extends DHLoadingState {}

class ServiceRegisteredSuccessful extends DHSuccessState {}

class ServiceUpdatededSuccessful extends DHSuccessState {}

class EmptyDropdownState extends DHSuccessState {}
