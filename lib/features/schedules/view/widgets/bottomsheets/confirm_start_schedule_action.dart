import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
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
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          AppBar().modalAppBar(
              title: 'Confirmação',
              backButtonsIsVisible: false,
              doneButtonIsVisible: false),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: Column(children: [
                const Text(
                  'Somente inicie o atendimento quando o veículo estiver prestes a ter os devidos cuidados. O cliente será notificado que o serviço foi iniciado.',
                  textAlign: TextAlign.center,
                ).body_regular(
                    style: const TextStyle(color: AppColor.textSecondaryColor)),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(
                    context,
                    true,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Iniciar serviço'),
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
                    child: const Text("Ainda não").label2_bold(
                        style: const TextStyle(color: AppColor.accentColor))),
                const SizedBox(
                  height: 24,
                ),
              ]))
        ]));
  }
}
