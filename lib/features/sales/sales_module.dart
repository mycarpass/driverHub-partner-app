import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/sales/interactor/sales_interactor.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/rest_sales_service.dart';
import 'package:driver_hub_partner/features/sales/router/customers_router.dart';
import 'package:flutter/widgets.dart';

class SalesModule implements DHModule {
  @override
  Map<String, Widget Function(dynamic p1)> get routes => SalesRoutesMap.routes;

  @override
  void registerProviders() {
    DHInjector.instance.registerSingleton(
      SalesInteractor(
        RestSalesService(),
      ),
    );
  }
}
