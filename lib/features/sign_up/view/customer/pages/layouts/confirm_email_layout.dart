import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/widgets/text_field/dh_pin_text_field.dart';
import 'package:dh_ui_kit/view/widgets/timer_text_indicator/widget/timer_text_widget.dart';
import 'package:driver_hub_partner/features/sign_up/presenter/customer/sign_up_presenter.dart';
import 'package:driver_hub_partner/features/sign_up/view/customer/pages/layouts/layout_input_base/layout_input_base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';

class ConfirmEmailLayout extends LayoutInputBase {
  const ConfirmEmailLayout({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text("Digite o código").largeTitle_bold(),
        const SizedBox(
          height: 12,
        ),
        const Text(
          "Enviamos um código para o seu e-mail. Se você não está encontrando na sua caixa de entrada, verifique o spam.",
          textAlign: TextAlign.center,
        ).body_regular(
            style: const TextStyle(color: AppColor.textTertiaryColor)),
        const SizedBox(
          height: 24,
        ),
        DHPinCodeField(
          length: 6,
          fieldBorderStyle: FieldBorderStyle.square,
          responsive: false,
          fieldHeight: 64.0,
          fieldWidth: (MediaQuery.sizeOf(context).width / 6) - 16,
          activeBorderColor: AppColor.accentColor,
          activeBackgroundColor: AppColor.backgroundColor,
          margin: const EdgeInsets.all(0.0),
          borderRadius: BorderRadius.circular(8.0),
          keyboardType: TextInputType.number,
          autoHideKeyboard: false,
          fieldBackgroundColor: AppColor.backgroundColor,
          borderColor: AppColor.borderColor,
          textStyle: const TextStyle(
              fontSize: 24.0,
              fontFamily: 'CircularStd',
              fontWeight: FontWeight.w800,
              color: AppColor.textPrimaryColor),
          onChange: (value) {
            context.read<SignUpPresenter>().confirmEmailCode = value;
          },
          onComplete: (output) {
            // setState(() {
            //   _isButtonDisabled = false;
            // });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        TimerTextWidget(
            resendCodeFunction: context.read<SignUpPresenter>().resendEmail),
      ],
    );
  }

  @override
  SignUpStep get step => SignUpStep.emailCode;

  @override
  void action(BuildContext context) {
    context.read<SignUpPresenter>().validateCode();
  }
}
