import 'package:driver_hub_partner/features/login/entities/auth_entity.dart';

class AuthDto {
  AuthDto(this._email, this._password);

  final String _email;
  final String _password;

  Map<String, dynamic> toMap() {
    return {"email": _email, "password": _password};
  }

  factory AuthDto.fromEntity(AuthEntity authEntity) {
    return AuthDto(authEntity.email, authEntity.password);
  }
}
