import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/address_geo_interector.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/address_interector.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/address_service.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/geo_service.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/rest_address_service.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/address/service/rest_geo_service.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/create_customer_interactor.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/service/create_customer_service.dart';
import 'package:driver_hub_partner/features/sign_up/interactor/customer/service/rest_create_customer.dart';
import 'package:driver_hub_partner/features/sign_up/router/sign_up_router.dart';
import 'package:flutter/widgets.dart';

class SignUpModule implements DHModule {
  @override
  void registerProviders() {
    DHInjector.instance.registerFactory<CreateCustomerService>(
        () => RestCreateCustomerService());

    DHInjector.instance.registerFactory<CreateCustomerInteractor>(
        () => CreateCustomerInteractor());

    DHInjector.instance.registerFactory<GeoService>(() => RestGeoService());

    DHInjector.instance
        .registerFactory<AddressGeoInteractor>(() => AddressGeoInteractor());

    DHInjector.instance
        .registerFactory<AddressService>(() => RestAddressService());

    DHInjector.instance
        .registerFactory<AddressInteractor>(() => AddressInteractor());
  }

  @override
  Map<String, Widget Function(dynamic p1)> get routes => SignUpRoutesMap.routes;
}
