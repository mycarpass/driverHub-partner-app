import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/financial_info_dto.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/emptystate/empty_state_list.dart';
import 'package:flutter/material.dart';

class FinancialMovimentationsCard extends StatelessWidget {
  final List<Transactions> transactions;
  const FinancialMovimentationsCard({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.backgroundTransparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(
                Icons.trending_up,
                color: AppColor.iconSecondaryColor,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text("Movimentações").body_bold(),
              const Expanded(child: SizedBox.shrink()),
            ]),
            const SizedBox(
              height: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                transactions.isEmpty
                    ? const EmptyStateList(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        text: "Nenhuma motimentação realizada neste mês")
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: transactions.length,
                        itemBuilder: (context, index) => Row(
                          children: [
                            transactions[index].icon,
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(transactions[index].description)
                                      .body_regular(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: transactions[index].backgroundColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child:
                                  Text(transactions[index].amount.priceInReal)
                                      .body_bold(
                                style: TextStyle(
                                  color: transactions[index].textColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
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
