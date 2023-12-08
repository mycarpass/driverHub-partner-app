import 'package:driver_hub_partner/features/sign_up/interactor/customer/service/dto/create_customer_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/service/dto/create_customer_response_dto.dart';

abstract class CreateCustomerService {
  Future<CreateCustomerReponseDto> create(CreateCustomerDto customerDto);
}
