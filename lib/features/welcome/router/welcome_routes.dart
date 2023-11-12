import 'package:driver_hub_partner/features/welcome/presenter/welcome_presenter.dart';
import 'package:driver_hub_partner/features/welcome/view/pages/splash_page.dart';
import 'package:driver_hub_partner/features/welcome/view/pages/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WelcomeRoutes {
  static const splash = "/";
  static const welcome = "/welcome";
}

abstract class WelcomeRoutesMap {
  static var routes = {
    "/": (context) => BlocProvider(
        create: (context) => WelcomePresenter(), child: const SplashView()),
    "/welcome": (context) => const WelcomeView(),
  };
}
