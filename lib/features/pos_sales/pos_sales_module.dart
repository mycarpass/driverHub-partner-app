import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/pos_sales_interactor.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/service/rest_pos_sales_service.dart';
import 'package:driver_hub_partner/features/pos_sales/router/pos_sales_router.dart';
import 'package:flutter/widgets.dart';

class PosSalesModule implements DHModule {
  @override
  Map<String, Widget Function(dynamic p1)> get routes =>
      PosSalesRoutesMap.routes;

  @override
  void registerProviders() {
    DHInjector.instance.registerSingleton(
      PosSalesInteractor(
        RestPosSalesService(),
      ),
    );
  }
}
