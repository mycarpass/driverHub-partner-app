import 'package:driver_hub_partner/features/services/presenter/details/service_details_presenter.dart';
import 'package:driver_hub_partner/features/services/view/pages/detail/services_details_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ServicesRoutes {
  static const servicesDetail = "/services-detail";
}

abstract class ServicesRoutesMap {
  static var routes = {
    "/services-detail": (context) => BlocProvider(
          create: (context) => ServiceDetailsPresenter(),
          child: const ServicesDetailsView(),
        ),
  };
}
