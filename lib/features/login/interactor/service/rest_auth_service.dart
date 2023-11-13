import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_http_client/interactor/service/fz_http_client.dart';
import 'package:driver_hub_partner/features/login/interactor/service/auth_service.dart';
import 'package:driver_hub_partner/features/login/interactor/service/dto/auth_dto.dart';
import 'package:driver_hub_partner/features/login/interactor/service/dto/auth_dto_response.dart';

class RestAuthService implements AuthService {
  RestAuthService();

  final DHHttpClient _httpClient = DHInjector.instance.get();

  @override
  Future<AuthDtoResponse> auth(AuthDto authDto) async {
    var response =
        await _httpClient.post("/login/partners", body: authDto.toMap());

    return AuthDtoResponse.fromJson(response.data);
  }

  @override
  Future requestEmailToRecoverPassword(String email) {
    throw UnimplementedError();
  }
}
