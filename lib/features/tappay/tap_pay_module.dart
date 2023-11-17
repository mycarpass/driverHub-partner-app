import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/tappay/interactor/service/rest_tap_pay_service.dart';
import 'package:driver_hub_partner/features/tappay/interactor/tap_pay_interactor.dart';
import 'package:driver_hub_partner/features/tappay/router/tap_pay_router.dart';
import 'package:flutter/widgets.dart';

class TapPayModule implements DHModule {
  @override
  Map<String, Widget Function(dynamic p1)> get routes => TapPayRoutesMap.routes;

  @override
  void registerProviders() {
    DHInjector.instance.registerSingleton(
      TapPayInterector(
        RestTapPayService(),
      ),
    );
  }
}
