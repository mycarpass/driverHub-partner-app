import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/home/router/home_router.dart';
import 'package:driver_hub_partner/features/login/presenter/login_presenter.dart';
import 'package:driver_hub_partner/features/login/presenter/login_state.dart';
import 'package:driver_hub_partner/features/login/router/login_routes.dart';
import 'package:driver_hub_partner/features/login/view/resources/login_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginPresenter>(
      create: (context) => LoginPresenter(),
      child: Builder(
        builder: (context) {
          var presenter = context.read<LoginPresenter>();
          return Scaffold(
            appBar: AppBar().backButton(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocConsumer<LoginPresenter, DHState>(
                  listener: (context, state) => state is LoginSuccessState
                      ? Navigator.pushNamedAndRemoveUntil(
                          context, HomeRoutes.home, (route) => false)
                      : state is DHErrorState
                          ? DHSnackBar().showSnackBar(
                              "Oops..",
                              "Desculpe, suas credenciais de login estão incorretas. Por favor, tente novamente.",
                              DHSnackBarType.error)
                          : DoNothingAction(),
                  bloc: context.read<LoginPresenter>(),
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Acesse sua conta").largeTitle_bold(),
                            const SizedBox(
                              height: 40,
                            ),
                            BlocBuilder<LoginPresenter, DHState>(
                                builder: (context, state) => DHTextField(
                                      key: LoginKeys.emailField,
                                      title: "E-MAIL",
                                      hint: "email@host.com",
                                      icon: (Icons.email_outlined),
                                      controller: TextEditingController(
                                          text: context
                                              .read<LoginPresenter>()
                                              .email),
                                      textError:
                                          state is LoginEmailInputErrorState
                                              ? state.errorText
                                              : "",
                                      textErrorVisible:
                                          state is LoginEmailInputErrorState,
                                      onChanged: (email) {
                                        context.read<LoginPresenter>().email =
                                            email;
                                      },
                                    )),
                            BlocBuilder<LoginPresenter, DHState>(
                                builder: (context, state) => DHTextField(
                                      key: LoginKeys.passwordField,
                                      title: "SENHA",
                                      hint: "Sua senha",
                                      icon: (Icons.lock_outline),
                                      obscureText: true,
                                      controller: TextEditingController(
                                          text: context
                                              .read<LoginPresenter>()
                                              .password),
                                      textError:
                                          state is LoginPasswordInputErrorState
                                              ? state.errorText
                                              : "",
                                      textErrorVisible:
                                          state is LoginPasswordInputErrorState,
                                      onChanged: (password) {
                                        context
                                            .read<LoginPresenter>()
                                            .password = password;
                                      },
                                    )),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, LoginRoutes.forgotPassword);
                                },
                                child:
                                    const Text("Esqueceu a senha?").label2_bold(
                                  style: const TextStyle(
                                    color: AppColor.accentColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<LoginPresenter, DHState>(
                              builder: (context, state) => ElevatedButton(
                                key: LoginKeys.loginButton,
                                onPressed: () {
                                  presenter.validate()
                                      ? presenter.auth()
                                      : DoNothingAction();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocBuilder<LoginPresenter, DHState>(
                                      builder: (context, state) {
                                        if (state is LoginLoadingState) {
                                          return const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          );
                                        }
                                        return const Text(
                                          "Entrar",
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
