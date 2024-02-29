import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
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
          children: [
            const Text("Histórico de recebíveis").title2_bold(),
            const SizedBox(
              height: 16,
            ),
            const Text(
                    "Assim que você finaliza um agendamento que veio pelo app da DriverHub, ele será contabilizado na sua lista de recebíveis, lembre-se sempre de finaliza-los para manter sua lista atualizada e seu controle financeiro em dia")
                .body_regular(),
            const SizedBox(
              height: 32,
            ),
            receivableHistoric.isEmpty
                ? Center(
                    child: const Text(
                            "Você ainda não tem nenhum agendamento finalizado no mês para contabilizar seus recebíveis :(")
                        .body_regular(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Movimentações").body_bold(),
                      const SizedBox(
                        height: 8,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: receivableHistoric.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        itemBuilder: (context, index) => Card(
                          elevation: 0,
                          color: AppColor.backgroundTransparent,
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child:
                                receivableHistoric[index].isOnlyDebitOperation()
                                    ? MovimentationDebitRow(
                                        item: receivableHistoric[index],
                                      )
                                    : receivableHistoric[index]
                                            .isOnlyCreditOperation()
                                        ? MovimentationCreditRow(
                                            item: receivableHistoric[index],
                                          )
                                        : Column(
                                            children: [
                                              MovimentationDebitRow(
                                                item: receivableHistoric[index],
                                              ),
                                              const SizedBox(
                                                height: 24,
                                              ),
                                              MovimentationCreditRow(
                                                item: receivableHistoric[index],
                                              )
                                            ],
                                          ),
                          ),
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

class MovimentationDebitRow extends StatelessWidget {
  const MovimentationDebitRow({
    super.key,
    required this.item,
  });

  final ReceivableHistoric item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          CustomIcons.dhCoins,
          color: AppColor.iconPrimaryColor,
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Agendamento ").body_bold(),
                Text(item.scheduledDate).body_bold(),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(
                  CustomIcons.dhLeftRowFilled,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text("Débito").caption1_regular(),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const Text("Retenção de mensalidade").body_regular(),
            const SizedBox(
              height: 8,
            ),
            Text("- ${item.amountWithheldForSignatureCents.priceInReal}")
                .caption1_regular(),
          ],
        ),
      ],
    );
  }
}

class MovimentationCreditRow extends StatelessWidget {
  const MovimentationCreditRow({
    super.key,
    required this.item,
  });

  final ReceivableHistoric item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          CustomIcons.dhMoneyPig,
          color: AppColor.iconPrimaryColor,
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Agendamento ").body_bold(),
                Text(item.scheduledDate).body_bold(),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Icon(
                  CustomIcons.dhRightRowFilled,
                  color: AppColor.accentColor,
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text("Crédito").caption1_regular(),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Text("Previsão de recebimento").body_regular(),
                const SizedBox(
                  width: 4,
                ),
                Text(item.forecastDate).body_bold()
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(item.amountEarnedFromScheduleCents.priceInReal)
                .caption1_regular(),
          ],
        ),
      ],
    );
  }
}
