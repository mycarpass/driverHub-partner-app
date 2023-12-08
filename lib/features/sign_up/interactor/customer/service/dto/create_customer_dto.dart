import 'package:driver_hub_partner/features/sign_up/interactor/address/service/dto/geo_location_dto.dart';

class CreateCustomerDto {
  final String establishment;
  final String email;
  final String password;
  final String phone;
  final String personName;
  final String cpf;
  final String? cnpj;
  final GeoLocationResponseDto? address;

  CreateCustomerDto(
      {required this.establishment,
      required this.email,
      required this.password,
      required this.phone,
      required this.cpf,
      required this.personName,
      this.cnpj,
      this.address});

  Map<String, dynamic> toJson() {
    return {
      "establishment": establishment,
      "email": email,
      "password": password,
      // "password_confirmation": password,
      "phone": phone,
      "name": personName,
      "cpf": cpf,
      "cnpj": cnpj,
      "address": address?.toJson()
    };
  }
}
