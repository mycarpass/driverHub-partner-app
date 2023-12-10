import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/service/create_customer_service.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/service/dto/create_customer_dto.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/service/dto/create_customer_response_dto.dart';

class RestCreateCustomerService implements CreateCustomerService {
  final DHHttpClient httpClient = DHInjector.instance.get<DHHttpClient>();

  @override
  Future<CreateCustomerReponseDto> create(CreateCustomerDto customerDto) async {
    try {
      var response = await httpClient.post("/partners/register/v2",
          body: customerDto.toJson());

      return CreateCustomerReponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
