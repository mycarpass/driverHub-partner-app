import 'package:dh_ui_kit/view/extensions/string_extension.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/layout_input_base/layout_input_base.dart';

class ProspectEntity {
  String establishment;
  String email;
  String password;
  String phone;
  String cpf;
  String? cnpj;
  String personName;
  GeoLocationResponseDto? address;

  ProspectEntity(this.establishment, this.email, this.password, this.phone,
      this.cpf, this.personName);

  bool validateEstablishment() {
    return establishment.length > 3;
  }

  bool validatePhone() {
    return phone.length == 15;
  }

  bool validatePassword() {
    return password.isNotEmpty && password.length >= 6;
  }

  bool validateEmail() {
    return email.trim().isValidEmail();
  }

  bool validatePersonName() {
    return personName.length > 3;
  }

  bool validateCPF() {
    return cpf.isNotEmpty && cpf.length == 14;
  }

  bool validateCNPJ() {
    return cnpj == null || cnpj == "" || cnpj?.length == 18;
  }

  bool validateAddressNumber() {
    return address?.number != null && address?.number != "";
  }

  String? validatePropertyByField(SignUpFields field) {
    switch (field) {
      case SignUpFields.email:
        return validateEmail() ? null : "E-mail inválido";
      case SignUpFields.establishment:
        return validateEstablishment()
            ? null
            : "Informe o nome do estabelecimento corretamente";
      case SignUpFields.phone:
        return validatePhone() ? null : "Telefone inválido";
      case SignUpFields.password:
        return validatePassword()
            ? null
            : "Senha deve ter pelo menos 6 caracteres";

      case SignUpFields.name:
        return validatePersonName() ? null : "Digite seu nome completo";
      case SignUpFields.cnpj:
        return validateCNPJ() ? null : "Digite seu CNPJ corretamente";
      case SignUpFields.cpf:
        return validateCPF() ? null : "Digite seu CPF corretamente";
      case SignUpFields.addressNumber:
        return validateAddressNumber()
            ? null
            : "Digite o número do endereço ou informe S/N";

      default:
        return null;
    }
  }
}
