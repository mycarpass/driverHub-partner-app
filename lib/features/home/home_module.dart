import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/home/interactor/home_interactor.dart';
import 'package:driver_hub_partner/features/home/interactor/onboarding_interactor.dart';
import 'package:driver_hub_partner/features/home/interactor/service/onboarding_service.dart';
import 'package:driver_hub_partner/features/home/interactor/service/rest_get_home_info.dart';
import 'package:driver_hub_partner/features/home/interactor/service/rest_onboarding_service.dart';
import 'package:driver_hub_partner/features/home/router/home_router.dart';
import 'package:flutter/widgets.dart';

class HomeModule implements DHModule {
  @override
  Map<String, Widget Function(dynamic p1)> get routes => HomeRoutesMap.routes;

  @override
  void registerProviders() {
    DHInjector.instance.registerSingleton(
      HomeInteractor(
        RestGetHomeInfo(),
      ),
    );

    DHInjector.instance
        .registerFactory<OnboardingService>(() => RestOnboardingService());

    DHInjector.instance.registerFactory<OnboardingInteractor>(
        () => OnboardingInteractor(RestOnboardingService()));
  }
}
