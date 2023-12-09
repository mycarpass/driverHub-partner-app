import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/services/interactor/service/rest_services_service.dart';
import 'package:driver_hub_partner/features/services/interactor/services_interactor.dart';
import 'package:driver_hub_partner/features/services/router/services_router.dart';
import 'package:flutter/widgets.dart';

class ServicesModule implements DHModule {
  @override
  Map<String, Widget Function(dynamic p1)> get routes =>
      ServicesRoutesMap.routes;

  @override
  void registerProviders() {
    DHInjector.instance.registerSingleton(
      ServicesInteractor(
        RestServicesService(),
      ),
    );
  }
}
