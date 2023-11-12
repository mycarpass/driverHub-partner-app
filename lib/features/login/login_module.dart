import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/login/interactor/auth_interactor.dart';
import 'package:driver_hub_partner/features/login/interactor/service/auth_service.dart';
import 'package:driver_hub_partner/features/login/interactor/service/rest_auth_service.dart';
import 'package:driver_hub_partner/features/login/router/login_routes.dart';
import 'package:flutter/material.dart';

///All new module must have this implementation
///To put all their providers injection into a single place
///After  override the method of register provider, just add your new module
///To the moduleList, it is on main.dart, and restar de app, your injections
///must work after that

class LoginModule implements DHModule {
  @override
  void registerProviders() {
    DHInjector.instance.registerFactory<AuthService>(() => RestAuthService());
    DHInjector.instance.registerFactory<AuthInteractor>(() => AuthInteractor());
  }

  @override
  Map<String, Widget Function(dynamic p1)> get routes => LoginRoutesMap.routes;
}
