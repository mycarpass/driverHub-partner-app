import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_state.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/layout_input_base/layout_input_base.dart';
import 'package:flutter/material.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordLayout extends LayoutInputBase {
  const PasswordLayout({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("Crie uma senha").largeTitle_bold(),
        const SizedBox(
          height: 32,
        ),
        BlocBuilder<SignUpPresenter, DHState>(
          builder: (context, state) => DHTextField(
            title: "SENHA",
            hint: "Senha",
            controller: TextEditingController(
                text: context.read<SignUpPresenter>().password),
            icon: (Icons.lock_outline),
            textError: state is PasswordFieldErrorState ? state.errorText : "",
            textErrorVisible: state is PasswordFieldErrorState,
            obscureText: true,
            onChanged: (password) {
              context.read<SignUpPresenter>().password = password;
            },
          ),
        )
      ],
    );
  }

  @override
  SignUpStep get step => SignUpStep.password;

  @override
  void action(BuildContext context) {
    context.read<SignUpPresenter>().goNextStep();
  }
}
