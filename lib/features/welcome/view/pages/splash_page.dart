import 'package:dh_state_management/dh_state.dart';
import 'package:driver_hub_partner/features/welcome/presenter/welcome_presenter.dart';
import 'package:driver_hub_partner/features/welcome/presenter/welcome_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var presenter = context.read<WelcomePresenter>();
      presenter.initSplash();
      return Scaffold(
        body: BlocConsumer<WelcomePresenter, DHState>(
            listener: (context, state) => state is SplashFinishedState
                ? presenter.redirectSplash(context)
                : DoNothingAction(),
            bloc: context.read<WelcomePresenter>(),
            builder: (context, state) {
              return Image.asset(
                "lib/assets/images/splash/splash.png",
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: double.infinity,
              );
            }),
      );
    });
  }
}
