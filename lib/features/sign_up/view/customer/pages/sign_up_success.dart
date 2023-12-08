import 'package:dh_ui_kit/view/widgets/layouts/success/success_feedback_layout.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpSuccessView extends StatelessWidget {
  const SignUpSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var presenter = context.read<SignUpPresenter>();
      return Scaffold(
        body: SafeArea(
          child: DHSuccessFeedbackLayout(
            buttonTitle: 'Continuar',
            description: 'Parabéns! Sua conta foi criada com sucesso',
            title: 'Sua conta foi criada',
            svgImage: 'lib/assets/images/AccountCreatedSuccess.svg',
            onPressed: () => presenter.goOnboarding(),
          ),
        ),
      );
    });
  }
}
