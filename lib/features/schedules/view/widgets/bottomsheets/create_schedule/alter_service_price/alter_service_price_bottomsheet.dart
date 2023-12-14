import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:driver_hub_partner/features/commom_objects/money_value.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';

class AlterServicePriceBottomSheet extends StatefulWidget {
  const AlterServicePriceBottomSheet({super.key, required this.initialValue});

  final double initialValue;

  @override
  State<AlterServicePriceBottomSheet> createState() =>
      _AlterServicePriceBottomSheetState();
}

class _AlterServicePriceBottomSheetState
    extends State<AlterServicePriceBottomSheet> {
  late MoneyMaskedTextController controller;

  @override
  void initState() {
    controller = MoneyMaskedTextController(
        leftSymbol: "R\$ ", initialValue: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Altere o valor do serviço neste agendamento",
            ).title2_bold(),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Precisará cobrar um valor diferente neste agendamento? Sem problemas, altere o valor e dessa forma seu financeiro ficará mais preciso ;)",
            ).body_regular(),
            const SizedBox(
              height: 16,
            ),
            DHTextField(
              hint: "R\$ 100,00",
              icon: Icons.money,
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: (_) {},
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(controller.numberValue);
                  },
                  child: const Text(
                    "Alterar",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
