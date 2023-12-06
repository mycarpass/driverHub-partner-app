import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/customers/interactor/customers_interactor.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/rest_customers_service.dart';
import 'package:driver_hub_partner/features/customers/router/customers_router.dart';
import 'package:flutter/widgets.dart';

class CustomersModule implements DHModule {
  @override
  Map<String, Widget Function(dynamic p1)> get routes =>
      CustomerRoutesMap.routes;

  @override
  void registerProviders() {
    DHInjector.instance.registerSingleton(
      CustomersInteractor(
        RestCustomerService(),
      ),
    );
  }
}
