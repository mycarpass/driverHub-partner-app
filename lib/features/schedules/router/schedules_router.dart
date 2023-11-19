import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/pages/home/schedule_detail_view.dart';

abstract class SchedulesRoutes {
  static const scheduleDetail = "/schedule-detail";
}

abstract class SchedulesRoutesMap {
  static var routes = {
    "/schedule-detail": (context) => BlocProvider(
          create: (context) => SchedulesPresenter(),
          child: const ScheduleDetailView(),
        ),
  };
}
