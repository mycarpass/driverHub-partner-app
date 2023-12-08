import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:driver_hub_partner/features/home/presenter/onboarding_presenter.dart';
import 'package:driver_hub_partner/features/home/view/pages/tabs/customer_home_tabs_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeRoutes {
  static const home = "/home";
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
          ],
          child: const CustomerHomeTabsWidget(),
        ),
  };
}
