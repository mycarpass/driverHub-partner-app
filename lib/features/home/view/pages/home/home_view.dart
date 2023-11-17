// ignore_for_file: sized_box_for_whitespace

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:driver_hub_partner/features/home/presenter/home_state.dart';
import 'package:driver_hub_partner/features/home/view/widgets/home_error_widget.dart';
import 'package:driver_hub_partner/features/home/view/widgets/loading/home_body_loading.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_pull_to_refresh.dart';
import 'package:driver_hub_partner/features/tappay/router/tap_pay_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var presenter = context.read<HomePresenter>();
    return DHPullToRefresh(
      onRefresh: context.read<HomePresenter>().load,
      key: UniqueKey(),
      child: BlocBuilder<HomePresenter, DHState>(
        builder: (context, state) => Stack(
          children: [
            if (state is DHLoadingState) ...[
              const HomeBodyLoading()
            ] else if (state is DHErrorState) ...[
              const HomeErrorWidget()
            ] else ...[
              Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 0, bottom: 12, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Olá, ${presenter.homeResponseDto.data.partnerData.name}')
                          .title1_bold(),
                      const SizedBox(
                        height: 24,
                      ),
                      Card(
                        color: AppColor.backgroundTransparent,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 8, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                const Icon(
                                  Icons.wallet,
                                  color: AppColor.iconSecondaryColor,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text("Carteira").body_bold(),
                                const Expanded(child: SizedBox.shrink()),
                                BlocBuilder<HomePresenter, DHState>(
                                    builder: (context, state) => IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          presenter.changeVisible();
                                        },
                                        icon: Icon(
                                          state is VisibleIsChanged
                                              ? presenter.isVisible
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          size: 20,
                                          color: AppColor.iconSecondaryColor,
                                        ))),
                              ]),
                              const SizedBox(
                                height: 0,
                              ),
                              Row(children: [
                                // const Icon(
                                //   CustomIcons.dhUp,
                                //   color: AppColor.whiteColor,
                                // ),
                                // const SizedBox(
                                //   width: 8,
                                // ),
                                const Text("À receber").body_regular(),
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
                                              color: AppColor.iconPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          height: 32,
                                          width: 140,
                                        )
                                      : const Text("R\$ 120,00").title1_bold(),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(children: [
                                const Text("Total recebido").body_regular(),
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
                                              color: AppColor.iconPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          height: 24,
                                          width: 120,
                                        )
                                      : const Text("R\$ 10,00").title2_bold(
                                          style: TextStyle(
                                              color: AppColor.accentColor
                                                  .withOpacity(0.85))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
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
                                  const Icon(
                                    CustomIcons.dhLock,
                                    size: 48,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text(
                                    "Em breve você poderá acompanhar as movimentações da sua carteira por aqui.",
                                    textAlign: TextAlign.center,
                                  ).body_regular(),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ]
          ],
        ),
      ),
    );
  }
}
