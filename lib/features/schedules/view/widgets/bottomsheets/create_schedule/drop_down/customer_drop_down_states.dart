import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';

class ListLoadedWithInitialCustomer extends DHState {
  final CustomerDto customerDto;

  ListLoadedWithInitialCustomer({required this.customerDto});

  @override
  List<Object?> get props => [customerDto];
}
