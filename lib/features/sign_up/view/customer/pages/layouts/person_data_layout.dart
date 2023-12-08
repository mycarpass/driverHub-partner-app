import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'layout_input_base/layout_input_base.dart';

class PersonNameLayout extends LayoutInputBase {
  PersonNameLayout({super.key, this.text});

  final String? text;

  final MaskTextInputFormatter formatter = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp('[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("Dados pessoais").largeTitle_bold(),
        const SizedBox(
          height: 32,
        ),
        BlocBuilder<SignUpPresenter, DHState>(
          builder: (context, state) => Column(
            children: [
              DHTextField(
                title: "NOME COMPLETO",
                hint: "Ex: João Silva Oliveira",
                keyboardType: TextInputType.text,
                icon: (Icons.person),
                textError: state is NameErrorState ? state.errorText : "",
                textErrorVisible: state is NameErrorState,
                controller: TextEditingController(
                    text: context.read<SignUpPresenter>().personName),
                onChanged: (personName) {
                  context.read<SignUpPresenter>().personName = personName;
                },
              ),
              DHTextField(
                title: "CPF",
                hint: "00.000.000-00",
                keyboardType: TextInputType.number,
                icon: (Icons.numbers_outlined),
                textError: state is CPFErrorState ? state.errorText : "",
                textErrorVisible: state is CPFErrorState,
                controller: TextEditingController(
                    text: context.read<SignUpPresenter>().cpf),
                formatters: [formatter],
                onChanged: (cpf) {
                  context.read<SignUpPresenter>().cpf = cpf;
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  SignUpStep get step => SignUpStep.personData;

  @override
  void action(BuildContext context) {
    context.read<SignUpPresenter>().goNextStep();
  }
}
