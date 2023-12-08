import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_cache_manager/interactor/keys/auth_keys/auth_keys.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/exceptions/http_exceptions.dart';
import 'package:driver_hub_partner/features/sign_up/entities/customer/prospect_entity.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/exceptions/email_already_registered.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/service/create_customer_service.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/service/dto/create_customer_dto.dart';

class CreateCustomerInteractor {
  CreateCustomerInteractor();

  final CreateCustomerService _createCustomerService =
      DHInjector.instance.get<CreateCustomerService>();

  final _dhCacheManager = DHInjector.instance.get<DHCacheManager>();

  Future createCustomer(ProspectEntity prospectEntity) async {
    try {
      var response = await _createCustomerService.create(
        CreateCustomerDto(
            establishment: prospectEntity.establishment,
            email: prospectEntity.email.trim(),
            password: prospectEntity.password,
            phone: prospectEntity.phone,
            personName: prospectEntity.personName,
            cpf: prospectEntity.cpf,
            cnpj: prospectEntity.cnpj,
            address: prospectEntity.address),
      );
      _dhCacheManager.setString(AuthTokenKey(), response.token);
    } on HttpUnprocessableEntity {
      throw EmailAlreadyRegistered();
    } catch (e) {
      rethrow;
    }
  }
}
