import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_cache_manager/interactor/keys/onboarding_keys/onboarding_keys.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_navigation/navigation_service.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/login/entities/auth_entity.dart';
import 'package:driver_hub_partner/features/login/interactor/auth_interactor.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginPresenter extends Cubit<DHState> {
  LoginPresenter() : super(LoginInitialState());

  final _cacheManager = DHInjector.instance.get<DHCacheManager>();

  ///GETTERS AND SETTERS
  var _email = "";

  String get email => _email;

  set email(String newemail) {
    _email = newemail;
    authEntity.email = _email;
  }

  var _password = "";

  String get password => _password;

  set password(String newpassword) {
    _password = newpassword;
    authEntity.password = _password;
  }
  /////////////////

  bool isButtonDisabled = true;
  var authEntity = AuthEntity(email: "", password: "");

  final AuthInteractor _authInteractor =
      DHInjector.instance.get<AuthInteractor>();

  bool validate() {
    if (!authEntity.isValidEmail()) {
      emit(LoginEmailInputErrorState(
          "E-mail inválido, verifique e tente novamente"));
      return false;
    }
    if (!authEntity.isValidPassword()) {
      emit(LoginPasswordInputErrorState(
          "Senha inválida, verifique e tente novamente"));
      return false;
    }
    return true;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future auth() async {
    try {
      emit(LoginLoadingState());
      await _authInteractor.authenticate(_email, _password);
    } catch (e) {
      emit(DHErrorState());
    }
  }
}
