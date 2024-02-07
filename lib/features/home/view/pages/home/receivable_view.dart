import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/receivable_dto.dart';
import 'package:flutter/material.dart';

class ReceivableHistoricView extends StatelessWidget {
  const ReceivableHistoricView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<ReceivableHistoric> receivableHistoric =
        ModalRoute.of(context)?.settings.arguments as List<ReceivableHistoric>;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recebíveis"),
      ).backButton(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Histórico de recebíveis").title2_bold(),
            const SizedBox(
              height: 16,
            ),
            const Text(
                    "Assim que você finaliza um agendamento que veio pelo app da DriverHub, ele será contabilizado na sua lista de recebíveis, lembre-se sempre de finaliza-los para manter sua lista atualizado e seu controle financeiro em dia")
                .body_regular(),
            const SizedBox(
              height: 32,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: receivableHistoric.length,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Divider(),
              ),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  children: [
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColor.successColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text("Valor à receber: ").body_regular(),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(receivableHistoric[index]
                                    .amountEarnedFromScheduleCents
                                    .priceInReal)
                                .body_bold(),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Text("Agendamento feito no dia: ")
                                .body_regular(),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(receivableHistoric[index].scheduledDate)
                                .body_bold(),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Text("Previsão de recebimento: ")
                                .body_regular(),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(receivableHistoric[index].forecastDate)
                                .body_bold(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
