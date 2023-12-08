import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_state.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/layout_input_base/layout_input_base.dart';

import 'package:flutter/material.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NameLayout extends LayoutInputBase {
  NameLayout({super.key});

  final MaskTextInputFormatter formatterCNPJ = MaskTextInputFormatter(
      mask: "###.###.###/####-##",
      initialText: "000.000.000/0001-00",
      filter: {"#": RegExp('[0-9]')});

  final MaskTextInputFormatter formatterPhone = MaskTextInputFormatter(
      mask: "(##) #####-####",
      initialText: "(00) 00000-0000",
      filter: {"#": RegExp('[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("Seja um parceiro").largeTitle_bold(),
        const SizedBox(
          height: 32,
        ),
        BlocBuilder<SignUpPresenter, DHState>(
          builder: (context, state) => Column(children: [
            DHTextField(
              controller: TextEditingController(
                  text: context.read<SignUpPresenter>().establishment),
              title: "ESTABELECIMENTO",
              hint: "Nome do estabelecimento",
              textError:
                  state is InputValidationErrorState ? state.errorText : "",
              textErrorVisible: state is InputValidationErrorState,
              icon: (Icons.home_work),
              onChanged: (establishment) {
                context.read<SignUpPresenter>().establishment = establishment;
              },
            ),
            DHTextField(
              controller: TextEditingController(
                  text: context.read<SignUpPresenter>().cnpj),
              title: "CNPJ (OPCIONAL)",
              hint: "00.000.000/0001-00",
              keyboardType: TextInputType.number,
              textError:
                  state is InputValidationErrorState ? state.errorText : "",
              textErrorVisible: state is InputValidationErrorState,
              icon: (Icons.numbers_rounded),
              formatters: [formatterCNPJ],
              onChanged: (cnpj) {
                context.read<SignUpPresenter>().cnpj = cnpj;
              },
            ),
            DHTextField(
              title: "WHATSAPP (CONTATO)*",
              hint: "(00) 00000-0000",
              keyboardType: TextInputType.number,
              icon: (Icons.phone_android_outlined),
              textError:
                  state is InputValidationErrorState ? state.errorText : "",
              textErrorVisible: state is InputValidationErrorState,
              controller: TextEditingController(
                  text: context.read<SignUpPresenter>().phone),
              formatters: [formatterPhone],
              onChanged: (phone) {
                context.read<SignUpPresenter>().phone = phone;
              },
            ),
            Center(
                child: const Text(
              '*Whatsapp é um dos meios de comunicação para receber seus agendamentos, informar corretamente',
              textAlign: TextAlign.center,
            ).caption1_regular(
                    style: const TextStyle(color: AppColor.textSecondaryColor)))
          ]),
        )
      ],
    );
  }

  @override
  SignUpStep get step => SignUpStep.name;

  @override
  void action(BuildContext context) {
    context.read<SignUpPresenter>().goNextStep();
  }
}
