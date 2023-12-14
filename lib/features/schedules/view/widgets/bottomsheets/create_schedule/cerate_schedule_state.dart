import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';

class ServiceAddeedState extends DHState {
  final ServiceDto serviceDto;

  ServiceAddeedState(this.serviceDto);

  @override
  List<Object?> get props => [serviceDto];
}

class ServicesRecalculatedState extends DHState {
  final CustomerDto customerDto;

  ServicesRecalculatedState(this.customerDto);

  @override
  List<Object?> get props => [customerDto];
}

class NewBodyTypeSeleceted extends DHState {
  final CarBodyType carBodyType;

  NewBodyTypeSeleceted({required this.carBodyType});

  @override
  List<Object?> get props => [carBodyType];
}

class ServiceRemovedState extends DHState {
  final ServiceDto serviceDto;

  ServiceRemovedState({required this.serviceDto});

  @override
  List<Object?> get props => [serviceDto];
}

class ServicePriceChanged extends DHState {
  final double price;

  ServicePriceChanged({required this.price});

  @override
  List<Object?> get props => [price];
}

class NewScheduleCreatedState extends DHState {
  @override
  List<Object?> get props => [];
}
