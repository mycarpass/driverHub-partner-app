import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  MaskTextInputFormatter numberFormatter = MaskTextInputFormatter(
    mask: "####",
    filter: {
      "#": RegExp('[0-9]'),
    },
  );

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
                  'Informe os 4 últimos números do telefone do cliente para finalizar o serviço.',
                  textAlign: TextAlign.center,
                ).body_regular(
                    style: const TextStyle(color: AppColor.textSecondaryColor)),
                const SizedBox(
                  height: 24,
                ),
                DHTextField(
                    hint: "4 últimos números do telefone",
                    icon: Icons.phone_android,
                    controller: controller,
                    autofocus: true,
                    formatters: [numberFormatter],
                    keyboardType: TextInputType.number,
                    onChanged: (_) {}),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(
                    context,
                    controller.text,
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
                  height: 12,
                ),
              ]))
        ]));
  }
}
