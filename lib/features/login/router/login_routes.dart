import 'package:driver_hub_partner/features/login/view/pages/login_page.dart';

abstract class LoginRoutes {
  static const login = "/login";
  static const forgotPassword = "/forgotPassword/email";
  static const forgotPasswordSuccess = "/forgotPassword/success";
}

abstract class LoginRoutesMap {
  static var routes = {
    "/login": (context) => const LoginPage(),
  };
}
