import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/schedule_detail_view.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/schedules_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SchedulesRoutes {
  static const scheduleDetail = "/schedule-detail";
  static const scheduleList = "/schedule-list";
}

abstract class SchedulesRoutesMap {
  static var routes = {
    "/schedule-detail": (context) => BlocProvider(
          create: (context) => SchedulesPresenter(),
          child: const ScheduleDetailView(),
        ),
    "/schedule-list": (context) => BlocProvider(
          create: (context) => SchedulesPresenter(),
          child: ScheduledListView(),
        ),
  };
}
