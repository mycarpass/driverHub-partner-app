import 'package:driver_hub_partner/features/login/interactor/service/dto/auth_dto.dart';
import 'package:driver_hub_partner/features/login/interactor/service/dto/auth_dto_response.dart';

abstract class AuthService {
  Future<AuthDtoResponse> auth(AuthDto authDto);
  Future requestEmailToRecoverPassword(String email);
}
