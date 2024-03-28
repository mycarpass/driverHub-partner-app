import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:flutter/material.dart';

class ConfirmStartScheduleWidget extends StatefulWidget {
  const ConfirmStartScheduleWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmStartScheduleWidgetWidgetState createState() =>
      _ConfirmStartScheduleWidgetWidgetState();
}

class _ConfirmStartScheduleWidgetWidgetState
    extends State<ConfirmStartScheduleWidget> {
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar().modalAppBar(
              title: 'Pronto para o Check-In',
              backButtonsIsVisible: false,
              doneButtonIsVisible: false),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Column(
              children: [
                const Text(
                  'Peça para que o cliente entre na aba de Agendamentos e faça o Check-In pelo app dele. Após o Check-In será solicitado o código de confirmação abaixo, basta dize-lo para o cliente e o serviço será iniciado ;)',
                  textAlign: TextAlign.center,
                ).body_regular(
                    style: const TextStyle(color: AppColor.textSecondaryColor)),
                const SizedBox(
                  height: 24,
                ),
                DHTextField(
                  hint: "123ADPLSO",
                  icon: Icons.code,
                  onChanged: (_) {},
                  // title: "1231231",
                  controller: TextEditingController(text: "ABCD"),
                  readOnly: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(
                    context,
                    true,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Check-In realizado'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                    onPressed: () => Navigator.pop(
                          context,
                          false,
                        ),
                    child: const Text("Agora não").label2_bold(
                        style: const TextStyle(color: AppColor.accentColor))),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
