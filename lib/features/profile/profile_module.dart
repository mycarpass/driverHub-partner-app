import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/profile/router/profile_router.dart';
import 'package:flutter/widgets.dart';

class ProfileModule implements DHModule {
  @override
  Map<String, Widget Function(dynamic p1)> get routes =>
      ProfileRoutesMap.routes;

  @override
  void registerProviders() {}
}
