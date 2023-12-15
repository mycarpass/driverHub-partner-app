import 'package:driver_hub_partner/features/sales/view/pages/sales_list/sales_list_view.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/schedule_detail_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SalesRoutes {
  static const salesDetail = "/sales-detail";
  static const salesList = "/sales-list";
}

abstract class SalesRoutesMap {
  static var routes = {
    "/sales-detail": (context) => BlocProvider(
          create: (context) => SchedulesPresenter(),
          child: const ScheduleDetailView(),
        ),
    "/sales-list": (context) => const SalesListView()
  };
}
