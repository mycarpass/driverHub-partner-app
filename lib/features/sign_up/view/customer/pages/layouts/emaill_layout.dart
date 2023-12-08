import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_state.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/layout_input_base/layout_input_base.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';

// ignore: must_be_immutable
class EmailLayout extends LayoutInputBase {
  EmailLayout({
    super.key,
    this.text,
  });
  final String? text;
  late SignUpPresenter presenter;
  @override
  Widget build(BuildContext context) {
    presenter = context.read<SignUpPresenter>();
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("Digite seu email").largeTitle_bold(),
        const SizedBox(
          height: 32,
        ),
        BlocBuilder<SignUpPresenter, DHState>(
          builder: (context, state) => DHTextField(
            title: "E-MAIL",
            hint: "email@host.com",
            icon: (Icons.email_outlined),
            controller: TextEditingController(text: presenter.email),
            textError:
                state is InputValidationErrorState ? state.errorText : "",
            textErrorVisible: state is InputValidationErrorState,
            onChanged: (email) {
              presenter.email = email;
            },
          ),
        )
      ],
    );
  }

  @override
  SignUpStep get step => SignUpStep.email;

  @override
  void action(BuildContext context) {
    presenter.sendEmail();
  }
}
