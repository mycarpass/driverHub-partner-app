import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:flutter/material.dart';

class DailyNumbersCard extends StatelessWidget {
  const DailyNumbersCard({
    super.key,
    required this.presenter,
  });

  final HomePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColor.backgroundTransparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: AppColor.iconSecondaryColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text("Resumo do dia").body_bold(),
                  const Expanded(child: SizedBox.shrink()),
                ]),
                const SizedBox(
                  height: 12,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("2").title1_bold(),
                          const Text("agenda hoje").body_regular(),
                        ],
                      ),
                      Column(
                        children: [
                          Text("3").title1_bold(),
                          const Text("vendas hoje").body_regular(),
                        ],
                      ),
                      Column(
                        children: [
                          Text("4").title1_bold(),
                          const Text("pós-vendas").body_regular(),
                        ],
                      ),
                    ]),
              ]),
        ));
  }
}
