import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:flutter/material.dart';

class AddressNumberWidget extends StatefulWidget {
  const AddressNumberWidget({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AddressNumberWidgetState createState() => _AddressNumberWidgetState();
}

class _AddressNumberWidgetState extends State<AddressNumberWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.76,
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Scaffold(
                appBar: AppBar().modalAppBar(
                    title: 'Qual o número do endereço?',
                    backButtonsIsVisible: false,
                    doneButtonIsVisible: false),
                body: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 24.0),
                    child: Column(children: [
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width - 50,
                          child: DHTextField(
                              title: "Número",
                              hint: "Número",
                              keyboardType: TextInputType.number,
                              controller: _controller,
                              icon: Icons.location_on_outlined,
                              autofocus: true,
                              onChanged: (query) async {
                                //_controller.text = query;
                              })),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        onPressed: () => _controller.text != ""
                            ? Navigator.pop(
                                context,
                                _controller.text,
                              )
                            : null,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Adicionar número"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextButton(
                          onPressed: () => Navigator.pop(
                                context,
                                "S/N",
                              ),
                          child: const Text("Endereço sem número").label2_bold(
                              style: const TextStyle(
                                  color: AppColor.accentColor))),
                    ])))));
  }
}
