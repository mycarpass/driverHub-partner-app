import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:flutter/material.dart';

class ConfirmFinishScheduleWidget extends StatefulWidget {
  const ConfirmFinishScheduleWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmFinishScheduleWidgetWidgetState createState() =>
      _ConfirmFinishScheduleWidgetWidgetState();
}

class _ConfirmFinishScheduleWidgetWidgetState
    extends State<ConfirmFinishScheduleWidget> {
  final TextEditingController controller = TextEditingController();

  int optionDefaultSelected = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          AppBar().modalAppBar(
              title: 'Finalização',
              backButtonsIsVisible: false,
              doneButtonIsVisible: false),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  24, 24, 24, MediaQuery.of(context).viewInsets.bottom),
              child: Column(children: [
                const Text(
                  'Qual foi o meio de pagamento utilizado para receber esse serviço do cliente?',
                  textAlign: TextAlign.center,
                ).body_regular(
                    style: const TextStyle(color: AppColor.textSecondaryColor)),
                const SizedBox(
                  height: 24,
                ),
                CustomRadioButton(
                    horizontal: true,
                    height: 48,
                    unSelectedBorderColor: AppColor.borderColor,
                    selectedBorderColor: AppColor.borderColor,
                    margin: const EdgeInsets.all(8),
                    enableShape: true,
                    shapeRadius: 16,
                    autoWidth: true,
                    radius: 16,
                    elevation: 0,
                    absoluteZeroSpacing: true,
                    buttonTextStyle: const ButtonTextStyle(
                        selectedColor: AppColor.backgroundColor,
                        unSelectedColor: AppColor.textSecondaryColor,
                        textStyle:
                            TextStyle(fontSize: 16, fontFamily: 'CircularStd')),
                    buttonLables: const [
                      'Cartão de Crédito',
                      'Pix',
                      'Dinheiro'
                    ],
                    buttonValues: const [1, 2, 3],
                    defaultSelected: optionDefaultSelected,
                    radioButtonValue: (value) {
                      optionDefaultSelected = value;
                    },
                    unSelectedColor: AppColor.backgroundColor,
                    selectedColor: AppColor.accentColor),
                ElevatedButton(
                  onPressed: () => Navigator.pop(
                    context,
                    optionDefaultSelected,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Finalizar serviço'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextButton(
                    onPressed: () => Navigator.pop(
                          context,
                          null,
                        ),
                    child: const Text("Ainda não").label2_bold(
                        style: const TextStyle(color: AppColor.accentColor))),
                const SizedBox(
                  height: 48,
                ),
              ]))
        ]));
  }
}
