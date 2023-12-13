// ignore_for_file: sized_box_for_whitespace

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_skeleton.dart';
import 'package:driver_hub_partner/features/home/presenter/home_presenter.dart';
import 'package:driver_hub_partner/features/home/presenter/home_state.dart';
import 'package:driver_hub_partner/features/home/presenter/onboarding_presenter.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_presenter.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/daily_numbers_card.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/financial_movimentations_card.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/onboarding_card.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/services_quantity_chart.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/last_week_earn_chart.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/services_value_chart.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/subscription_home_card.dart';
import 'package:driver_hub_partner/features/home/view/pages/home/widget/wallet_card.dart';
import 'package:driver_hub_partner/features/home/view/widgets/home_error_widget.dart';
import 'package:driver_hub_partner/features/home/view/widgets/loading/home_body_loading.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var presenter = context.read<HomePresenter>();
    var onboardingPresenter = context.read<OnboardingPresenter>();
    var subscribePresenter = context.read<SubscriptionPresenter>();
    return DHPullToRefresh(
      onRefresh: context.read<HomePresenter>().load,
      key: UniqueKey(),
      child: SingleChildScrollView(
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
                        left: 20, top: 20, bottom: 12, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Olá, ${presenter.homeResponseDto.data.partnerData.name}')
                            .title1_bold(),
                        const SizedBox(
                          height: 24,
                        ),
                        subscribePresenter.isSubscribed
                            ? BlocProvider(
                                create: (context) =>
                                    SubscriptionPresenter()..start(),
                                child: SubscriptionHomeCard(
                                  daysTrialLeft: presenter.homeResponseDto.data
                                      .partnerData.daysTrialLeft,
                                ))
                            : const SizedBox.shrink(),
                        !onboardingPresenter.isAllCompletedOnboarding(
                                presenter.homeResponseDto.data.partnerData)
                            ? BlocProvider.value(
                                value: onboardingPresenter,
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    child: const OnboardingCardWidget()))
                            : const SizedBox.shrink(),
                        state is FinancialLoadadedState
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: WalletCardWidget(presenter: presenter))
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: DHSkeleton(
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                        // state is FinancialLoadadedState
                        //     ? FinancialMovimentationsCard(
                        //         transactions: presenter
                        //                 .financialInfoDto.data.transactions ??
                        //             List.empty(),
                        //       )
                        //     : DHSkeleton(
                        //         child: Container(
                        //           width: double.infinity,
                        //           height: 500,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(12),
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //       ),
                        DailyNumbersCard(presenter: presenter),
                        LastWeekEarnChart(
                          presenter: presenter,
                        ),
                        ServicesValueChart(
                          presenter: presenter,
                        ),

                        ServicesQuantityChart(
                          presenter: presenter,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    )),
              ]
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
