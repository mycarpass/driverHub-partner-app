import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ReceivableCardWidget extends StatelessWidget {
  const ReceivableCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.backgroundTransparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 12, 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(
                Icons.call_received,
                color: AppColor.iconSecondaryColor,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text("Recebíveis").body_bold(),
              const Expanded(child: SizedBox.shrink()),
              TextButton(onPressed: () {}, child: const Text("ver todos"))
            ]),
            const SizedBox(
              height: 16,
            ),
            const Text("Fevereiro/2024").caption1_bold(),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 20,
              width: double.infinity,
              child: LinearPercentIndicator(
                // radius: 12,
                animation: true,
                percent: 0.5,
                progressColor: AppColor.accentColor,
                lineHeight: 50,
                barRadius: const Radius.circular(12),
                center: Text(true ? "Acesso Completo ativado" : "50%")
                    .caption1_bold(
                        style: const TextStyle(color: AppColor.whiteColor)),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            true
                ? Center(
                    child:
                        const Text("Acesso completo liberado até o fim do mês")
                            .caption1_regular())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Retido para liberar Acesso Completo")
                          .caption1_regular(),
                      Text("R\$ 59,00").title3_bold()
                    ],
                  ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                const Text("À receber da DriverHub").caption1_bold(),
                const Expanded(child: SizedBox.shrink()),
                const Text("R\$ 100,00").title2_bold()
              ],
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
