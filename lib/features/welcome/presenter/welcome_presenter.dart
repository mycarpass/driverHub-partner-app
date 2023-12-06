import 'dart:async';

import 'package:dh_cache_manager/interactor/infrastructure/dh_cache_manager.dart';
import 'package:dh_cache_manager/interactor/keys/auth_keys/auth_keys.dart';
import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_navigation/navigation_service.dart';
import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/home/router/home_router.dart';
import 'package:driver_hub_partner/features/welcome/presenter/welcome_state.dart';
import 'package:driver_hub_partner/features/welcome/router/welcome_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';

class WelcomePresenter extends Cubit<DHState> {
  WelcomePresenter() : super(SplashInitialState());

  final _cacheManager = DHInjector.instance.get<DHCacheManager>();
  bool _initialUriIsHandled = false;
  Uri? uriDeepLink;
  // ignore: unused_field
  StreamSubscription? _sub;

  Future<void> initSplash() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      // _handleIncomingLinks();
      //_handleInitialUri();
      emit(SplashFinishedState());
    } catch (e) {
      emit(DHErrorState(error: "Erro ao carregar dados de cache"));
    }
  }

  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      // _showSnackBar('_handleInitialUri called');
      try {
        final uri = await getInitialUri();
        if (uri != null) {
          uriDeepLink = uri;
          redirectSplash(NavigationService.navigatorKey.currentContext!);
        }
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
      }
    }
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        uriDeepLink = uri;
        redirectSplash(NavigationService.navigatorKey.currentContext!);
      }, onError: (Object err) {});
    }
  }

  Future<void> redirectSplash(BuildContext context) async {
    var token = await _cacheManager.getString(AuthTokenKey());

    if (token != null) {
      Navigator.pushNamedAndRemoveUntil(
          NavigationService.navigatorKey.currentContext!,
          HomeRoutes.home,
          arguments: uriDeepLink != null ? {'deeplink': uriDeepLink} : null,
          (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          NavigationService.navigatorKey.currentContext!,
          WelcomeRoutes.welcome,
          (route) => false);
    }
  }
}
