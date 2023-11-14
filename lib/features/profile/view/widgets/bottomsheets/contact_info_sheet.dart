import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:flutter/material.dart';

class ContactInfoSheetWidget extends StatefulWidget {
  const ContactInfoSheetWidget({super.key, required this.onTapButton});

  final Function() onTapButton;
  @override
  // ignore: library_private_types_in_public_api
  _ContactInfoSheetWidgetWidgetState createState() =>
      _ContactInfoSheetWidgetWidgetState();
}

class _ContactInfoSheetWidgetWidgetState extends State<ContactInfoSheetWidget> {
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
            title: 'Fale conosco',
            backButtonsIsVisible: false,
            doneButtonIsVisible: false,
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: Column(children: [
                const Icon(
                  CustomIcons.dhWhatsapp,
                  size: 48,
                  color: AppColor.accentColor,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Está com dúvidas ou algum problema? \nChama a gente no whats, para resolvermos!',
                  textAlign: TextAlign.center,
                ).body_regular(),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: widget.onTapButton,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Abrir whatsapp"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
              ]))
        ]));
  }
}
