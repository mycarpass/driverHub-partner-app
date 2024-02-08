import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:driver_hub_partner/features/home/presenter/onboarding_presenter.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_presenter.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/receivable_view.dart';
import 'package:driver_hub_partner/features/home/view/pages/tabs/customer_home_tabs_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeRoutes {
  static const home = "/home";
  static const receivableHistoric = "/home/receivable-historic";
}

abstract class HomeRoutesMap {
  static var routes = {
    "/home": (context) => MultiBlocProvider(
          providers: [
            BlocProvider<HomePresenter>(
              create: (BuildContext context) => HomePresenter(),
            ),
            BlocProvider<OnboardingPresenter>(
              create: (BuildContext context) => OnboardingPresenter(),
            ),
            BlocProvider<SubscriptionPresenter>(
              create: (BuildContext context) =>
                  SubscriptionPresenter()..start(),
            ),
          ],
          child: const CustomerHomeTabsWidget(),
        ),
    "/home/receivable-historic": (context) => const ReceivableHistoricView()
  };
}
