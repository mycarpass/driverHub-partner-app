import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_cache_manager/interactor/keys/auth_keys/auth_keys.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:driver_hub_partner/features/login/entities/auth_entity.dart';
import 'package:driver_hub_partner/features/login/interactor/cache_key/email_key.dart';
import 'package:driver_hub_partner/features/login/interactor/service/auth_service.dart';
import 'package:driver_hub_partner/features/login/interactor/service/dto/auth_dto.dart';
import 'package:driver_hub_partner/features/login/interactor/service/dto/auth_dto_response.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

      Sentry.configureScope(
        (scope) => scope.setUser(
          SentryUser(
            id: '',
            email: authEntity.email,
          ),
        ),
      );
      _dhCacheManager.setString(EmailTokenKey(), authEntity.email);
      _dhCacheManager.setString(RoleTokenKey(), authReponse.role);
      _dhCacheManager.setString(AuthTokenKey(), authReponse.token);
    } catch (e) {
      rethrow;
    }
  }
}
