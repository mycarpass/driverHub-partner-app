import 'package:driver_hub_partner/features/customers/interactor/service/dto/customer_register_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';

abstract class CustomersService {
  Future<CustomersResponseDto> getCustomers();

  Future<void> registerCustomer(CustomerRegisterDto customerRegisterDto);
}
