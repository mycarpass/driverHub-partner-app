// ignore_for_file: sized_box_for_whitespace

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_pull_to_refresh.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_presenter.dart';
import 'package:driver_hub_partner/features/pos_sales/presenter/pos_sales_presenter.dart';
import 'package:driver_hub_partner/features/pos_sales/view/widgets/calendars/pos_sales_calendar_widget.dart';
import 'package:driver_hub_partner/features/pos_sales/view/widgets/loading/pos_sales_body_loading.dart';
import 'package:driver_hub_partner/features/pos_sales/view/widgets/pos_sales_error_widget.dart';
import 'package:driver_hub_partner/features/pos_sales/view/widgets/pos_sales_list_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/header/tab_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/widgets/tabs/dh_contained_tab_bar.dart';

class PosSalesView extends StatefulWidget {
  const PosSalesView({super.key});

  @override
  State<PosSalesView> createState() => _PosSalesViewState();
}

class _PosSalesViewState extends State<PosSalesView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<PosSalesPresenter>(
          create: (BuildContext context) => PosSalesPresenter()..load(),
        ),
        BlocProvider<SubscriptionPresenter>(
          create: (BuildContext context) => SubscriptionPresenter()..start(),
        )
      ],
      child: Builder(
        builder: (context) {
          return DHPullToRefresh(
            onRefresh: context.read<PosSalesPresenter>().load,
            key: UniqueKey(),
            child: BlocBuilder<PosSalesPresenter, DHState>(
              builder: (context, state) {
                var presenter = context.read<PosSalesPresenter>();
                return Stack(
                  children: [
                    if (state is DHLoadingState) ...[
                      const PosSalesBodyLoading()
                    ] else if (state is DHErrorState) ...[
                      PosSalesErrorWidget(
                        reload: presenter.load,
                      )
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 12, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<SubscriptionPresenter, DHState>(
                              builder: (context, state) => TabViewHeader(
                                onRefresh: () async {
                                  presenter.load();
                                },
                                onPressed: () {},
                                allButtonsIsVisible: false,
                                title: "Pós-vendas",
                                subtitle:
                                    "${presenter.filteredList.length} oportunidades de pós-venda",
                              ),
                            ),
                          ],
                        ),
                      ),
                      DHContainedTabBar(
                        marginTop: 92,
                        tabTexts: const [
                          Text("Calendário"),
                          Text("Lista"),
                        ],
                        views: [
                          const PosSalesCalendarWidget(),
                          SingleChildScrollView(
                            child: PosSalesListWidget(
                              posSales: presenter.posSalesResponseDto.posSales,
                            ),
                          )
                        ],
                      ),
                    ],
                    //  const SubscriptionEndedWidget()
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
