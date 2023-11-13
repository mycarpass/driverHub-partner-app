import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SchedulesRoutes {
  static const scheduleDetail = "/schedule-detail";
}

abstract class SchedulesRoutesMap {
  static var routes = {
    "/schedule-detail": (context) => BlocProvider(
          create: (context) => SchedulesPresenter(),
          child: Container(),
        ),
  };
}
