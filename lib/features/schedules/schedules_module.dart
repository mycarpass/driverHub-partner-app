import 'package:dh_dependency_injection/dh_dependecy_injector.dart';
import 'package:dh_dependency_injection/dh_module_builder.dart';
import 'package:driver_hub_partner/features/schedules/interactor/schedules_interactor.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/rest_schedules_service.dart';
import 'package:driver_hub_partner/features/schedules/router/schedules_router.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/checklist/get_device_image_interactor.dart';
import 'package:flutter/widgets.dart';

class SchedulesModule implements DHModule {
  @override
  Map<String, Widget Function(dynamic p1)> get routes =>
      SchedulesRoutesMap.routes;

  @override
  void registerProviders() {
    DHInjector.instance.registerFactory(() => GetDeviceImageInteractor());
    DHInjector.instance.registerSingleton(
      SchedulesInteractor(
        RestSchedulesService(),
      ),
    );
  }
}
