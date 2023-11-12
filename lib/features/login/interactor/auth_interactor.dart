import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_cache_manager/interactor/keys/auth_keys/auth_keys.dart';
import 'package:dh_cache_manager/interactor/keys/onboarding_keys/onboarding_keys.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:driver_hub_partner/features/login/entities/auth_entity.dart';
import 'package:driver_hub_partner/features/login/interactor/service/auth_service.dart';
import 'package:driver_hub_partner/features/login/interactor/service/dto/auth_dto.dart';
import 'package:driver_hub_partner/features/login/interactor/service/dto/auth_dto_response.dart';

class AuthInteractor {
  AuthInteractor();

  final AuthService _authService = DHInjector.instance.get<AuthService>();

  final DHCacheManager _dhCacheManager =
      DHInjector.instance.get<DHCacheManager>();

  Future authenticate(String email, String password) async {
    var authEntity = AuthEntity(email: email, password: password);
    try {
      AuthDtoResponse authReponse =
          await _authService.auth(AuthDto.fromEntity(authEntity));
      _dhCacheManager.setString(AuthTokenKey(), authReponse.token);
      _dhCacheManager.setBool(OnboardingViewKey(), authReponse.isOnboarded);
    } catch (e) {
      rethrow;
    }
  }
}
