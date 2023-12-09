import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/schedule_detail_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ServicesRoutes {
  static const servicesDetail = "/services-detail";
}

abstract class ServicesRoutesMap {
  static var routes = {
    "/services-detail": (context) => BlocProvider(
          create: (context) => SchedulesPresenter(),
          child: const ScheduleDetailView(),
        ),
  };
}
