// ignore_for_file: must_be_immutable

import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/home_response_dto.dart';

class HomeState extends DHState {}

class HomeLoaded extends DHSuccessState {
  final HomeResponseDto homeResponseDto;

  HomeLoaded(this.homeResponseDto);
}

class FinancialLoadingState extends DHState {
  @override
  List<Object?> get props => [];
}

class FinancialLoadadedState extends DHState {
  final bool isVisible;

  FinancialLoadadedState({required this.isVisible});
  @override
  List<Object?> get props => [isVisible];
}
