import 'package:driver_hub_partner/features/sign_up/presenter/address/address_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/view/address/pages/address_check_view.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/sign_up_success.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SignUpRoutes {
  static const name = "/signUp/name";
  static const success = "/signUp/success";
  static const checkAddress = "/signUp/address/check";
}

abstract class SignUpRoutesMap {
  static var routes = {
    "/signUp/name": (context) => MultiBlocProvider(
          providers: [
            BlocProvider<SignUpPresenter>(
              create: (BuildContext context) => SignUpPresenter(),
            ),
            BlocProvider<AddressPresenter>(
              create: (BuildContext context) => AddressPresenter(),
            ),
          ],
          child: const SignUpView(),
        ),
    "/signUp/success": (context) => BlocProvider(
          create: (context) => SignUpPresenter(),
          child: const SignUpSuccessView(),
        ),
    "/signUp/address/check": (context) => AddressCheckView()
  };
}
