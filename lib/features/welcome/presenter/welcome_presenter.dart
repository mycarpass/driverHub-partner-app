import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_cache_manager/interactor/keys/auth_keys/auth_keys.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_navigation/navigation_service.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/router/home_router.dart';
import 'package:driver_hub_partner/features/welcome/presenter/welcome_state.dart';
import 'package:driver_hub_partner/features/welcome/router/welcome_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePresenter extends Cubit<DHState> {
  WelcomePresenter() : super(SplashInitialState());

  final _cacheManager = DHInjector.instance.get<DHCacheManager>();

  Future<void> initSplash() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(SplashFinishedState());
    } catch (e) {
      emit(DHErrorState(error: "Erro ao carregar dados de cache"));
    }
  }

  Future<void> redirectSplash(BuildContext context) async {
    var token = await _cacheManager.getString(AuthTokenKey());

    if (token != null) {
      // Navigator.push(
      //     context,
      //     CupertinoPageRoute(
      //       builder: (context) => Scaffold(),
      //     ));
      Navigator.pushNamedAndRemoveUntil(
          NavigationService.navigatorKey.currentContext!,
          HomeRoutes.home,
          (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          NavigationService.navigatorKey.currentContext!,
          WelcomeRoutes.welcome,
          (route) => false);
    }
  }
}
