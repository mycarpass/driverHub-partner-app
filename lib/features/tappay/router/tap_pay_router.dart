import 'package:driver_hub_partner/features/tappay/view/pages/home/tap_pay_view.dart';
import 'package:driver_hub_partner/features/tappay/presenter/tap_pay_presenter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TapPayRoutes {
  static const tapPay = "/tappay";
}

abstract class TapPayRoutesMap {
  static var routes = {
    "/tappay": (context) => BlocProvider(
          create: (context) => TapPayPresenter(),
          child: const TapPayView(),
        ),
  };
}
