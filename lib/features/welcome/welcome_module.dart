import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/welcome/router/welcome_routes.dart';
import 'package:flutter/widgets.dart';

class WelcomeModule implements DHModule {
  @override
  void registerProviders() {}

  @override
  Map<String, Widget Function(dynamic p1)> get routes =>
      WelcomeRoutesMap.routes;
}
