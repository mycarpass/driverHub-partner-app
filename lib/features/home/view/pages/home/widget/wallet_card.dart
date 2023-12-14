import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({
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
        padding: const EdgeInsets.fromLTRB(24, 12, 12, 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(
                Icons.wallet_outlined,
                color: AppColor.iconSecondaryColor,
                size: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text("Resumo financeiro").body_bold(),
              const Expanded(child: SizedBox.shrink()),
              BlocBuilder<HomePresenter, DHState>(
                builder: (context, state) => IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    presenter.changeVisible();
                  },
                  icon: Icon(
                    presenter.isVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: AppColor.iconSecondaryColor,
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 0,
            ),
            Row(children: [
              const Text("Vendas hoje").body_regular(),
              const Expanded(child: SizedBox.shrink()),
            ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !presenter.isVisible
                    ? Container(
                        margin: const EdgeInsets.only(top: 4),
                        decoration: const BoxDecoration(
                            color: AppColor.backgroundSecondary,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        height: 32,
                        width: 140,
                      )
                    : Text(presenter
                            .chartsResponseDto.todayTotalSales.priceInReal)
                        .title1_bold(),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text("Total de vendas este mês").body_regular(),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !presenter.isVisible
                    ? Container(
                        margin: const EdgeInsets.only(top: 4),
                        decoration: const BoxDecoration(
                          color: AppColor.backgroundSecondary,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        height: 24,
                        width: 120,
                      )
                    : Text(presenter.chartsResponseDto.currentMonthTotalSales
                            .priceInReal)
                        .title2_bold(
                        style: const TextStyle(color: AppColor.accentColor),
                      ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text("À receber da DriverHub").body_regular(),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !presenter.isVisible
                    ? Container(
                        margin: const EdgeInsets.only(top: 4),
                        decoration: const BoxDecoration(
                          color: AppColor.backgroundSecondary,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        height: 24,
                        width: 120,
                      )
                    : Text(presenter.financialInfoDto.data.accountInfo
                            .volumeThisMonth.priceInReal)
                        .title2_bold(
                        style:
                            const TextStyle(color: AppColor.textSecondaryColor),
                      ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            // Row(
            //   children: [
            //     const Text("Total de assinantes").body_regular(),
            //     const Expanded(child: SizedBox.shrink()),
            //   ],
            // ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     !presenter.isVisible
            //         ? Container(
            //             margin: const EdgeInsets.only(top: 4),
            //             decoration: const BoxDecoration(
            //                 color: AppColor.iconPrimaryColor,
            //                 borderRadius: BorderRadius.all(Radius.circular(8))),
            //             height: 24,
            //             width: 60,
            //           )
            //         : Text(
            //             presenter.financialInfoDto.data.accountInfo
            //                 .totalActiveSubscriptions
            //                 .toString(),
            //           ).title2_bold(),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
