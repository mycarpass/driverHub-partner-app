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

  bool validateName() {
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
    return cpf.isNotEmpty && cpf.length == 15;
  }

  String? validatePropertyByStep(SignUpStep step) {
    switch (step) {
      case SignUpStep.email:
        return validateEmail() ? null : "E-mail inválido";
      case SignUpStep.name:
        return validateName()
            ? null
            : "Informe o nome do estabelecimento corretamente";
      case SignUpStep.phone:
        return validatePhone() ? null : "Telefone inválido";
      case SignUpStep.password:
        return validatePassword()
            ? null
            : "Senha deve ter pelo menos 6 caracteres";

      case SignUpStep.personName:
        return validatePersonName() ? null : "Digite seu nome completo";

      default:
        return null;
    }
  }
}
