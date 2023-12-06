import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/schedule_detail_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CustomerRoutes {
  static const customerDetail = "/customer-detail";
}

abstract class CustomerRoutesMap {
  static var routes = {
    "/customer-detail": (context) => BlocProvider(
          create: (context) => SchedulesPresenter(),
          child: const ScheduleDetailView(),
        ),
  };
}
