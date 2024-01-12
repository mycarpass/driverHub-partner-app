import 'package:driver_hub_partner/features/schedules/presenter/schedule_payments_presenter.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/schedule_payments_view.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/schedules_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/pages/home/schedule_detail_view.dart';

abstract class SchedulesRoutes {
  static const scheduleDetail = "/schedule-detail";
  static const scheduleList = "/schedule-list";
  static const schedulePaymentsView = "/schedule-payments-view";
}

abstract class SchedulesRoutesMap {
  static var routes = {
    "/schedule-detail": (context) => BlocProvider(
          create: (context) => SchedulesPresenter(),
          child: const ScheduleDetailView(),
        ),
    "/schedule-list": (context) => BlocProvider(
          create: (context) => SchedulesPresenter(),
          child: const ScheduledListView(),
        ),
    "/schedule-payments-view": (context) => SchedulePaymentsView(),
  };
}
