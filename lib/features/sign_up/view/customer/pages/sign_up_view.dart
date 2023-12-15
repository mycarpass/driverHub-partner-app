// ignore_for_file: prefer_const_constructors

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_circular_loading.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_state.dart';
import 'package:driver_hub_partner/features/sign_up/router/sign_up_router.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/person_data_layout.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/confirm_email_layout.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/emaill_layout.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/layout_input_base/layout_input_base.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/name_layout.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/password_layout.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/address_layout.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/widgets/step_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var presenter = context.read<SignUpPresenter>();

      final List<LayoutInputBase> signUpSteps = [
        NameLayout(),
        PersonNameLayout(),
        AddressLayout(),
        EmailLayout(),
        const ConfirmEmailLayout(),
        const PasswordLayout()
      ];
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar().backButton(
              onPressed: () => context.read<SignUpPresenter>().backStep()),
          body: SingleChildScrollView(
            child: IntrinsicHeight(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        BlocConsumer<SignUpPresenter, DHState>(
                            listener: (context, state) {
                              if (state is SignUpFinishedState) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  SignUpRoutes.success,
                                  (route) => false,
                                );
                              }
                              if (state is DHErrorState) {
                                DHSnackBar().showSnackBar(
                                    "Ops..",
                                    state.error ??
                                        "Ocorreu um erro ao tentar se cadastrar, tente novamente mais tarde.",
                                    DHSnackBarType.error);
                              }
                            },
                            bloc: context.read<SignUpPresenter>(),
                            builder: (context, state) {
                              return SizedBox(
                                height: 50,
                                child: StepIndicatorWidget(
                                  countSteps: 6,
                                  currentStep: context
                                      .read<SignUpPresenter>()
                                      .currentStep,
                                ),
                              );
                            }),
                        BlocBuilder<SignUpPresenter, DHState>(
                          builder: (context, state) {
                            return signUpSteps[
                                context.read<SignUpPresenter>().currentStep];
                          },
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              presenter.validate(
                                      signUpSteps[presenter.currentStep].step)
                                  ? signUpSteps[presenter.currentStep]
                                      .action(context)
                                  : DoNothingAction();
                            },
                            child: BlocBuilder<SignUpPresenter, DHState>(
                              builder: (context, state) =>
                                  state is DHLoadingState
                                      ? const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            DHCircularLoading(),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(presenter.currentStep == 5
                                                    ? "Criar conta"
                                                    : "Continuar")
                                                .label1_bold(
                                                    style: const TextStyle(
                                                        color: AppColor
                                                            .blackColor)),
                                          ],
                                        ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
