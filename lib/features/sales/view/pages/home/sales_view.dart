// ignore_for_file: sized_box_for_whitespace

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_pull_to_refresh.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_presenter.dart';
import 'package:driver_hub_partner/features/sales/presenter/sales_presenter.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/bottomsheets/create_sale_bottomsheet.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/calendars/sales_calendar_widget.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/loading/sales_body_loading.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/sales_error_widget.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/sales_list_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/header/tab_header.dart';
import 'package:driver_hub_partner/features/user_feedback/user_feedback_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/widgets/tabs/dh_contained_tab_bar.dart';

class SalesView extends StatefulWidget {
  const SalesView({super.key});

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<SalesPresenter>(
          create: (BuildContext context) => SalesPresenter()..load(),
        ),
        BlocProvider<SubscriptionPresenter>(
          create: (BuildContext context) => SubscriptionPresenter()..start(),
        )
      ],
      child: Builder(
        builder: (context) {
          return DHPullToRefresh(
            onRefresh: context.read<SalesPresenter>().load,
            key: UniqueKey(),
            child: BlocBuilder<SalesPresenter, DHState>(
              builder: (context, state) {
                var presenter = context.read<SalesPresenter>();
                return Stack(
                  children: [
                    if (state is DHLoadingState) ...[
                      const SalesBodyLoading()
                    ] else if (state is DHErrorState) ...[
                      SalesErrorWidget(
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
                                addButtonIsVisible: context
                                    .read<SubscriptionPresenter>()
                                    .isSubscribed,
                                onPressed: () async {
                                  //
                                  //
                                  //

                                  if (!context
                                      .read<SubscriptionPresenter>()
                                      .isSubscribed) {
                                    context
                                        .read<SubscriptionPresenter>()
                                        .openPayWall(context);
                                  } else {
                                    bool? isSaleCreated =
                                        await showModalBottomSheet<bool>(
                                      context: context,
                                      showDragHandle: true,
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          CreateSaleBottomSheet(),
                                    );

                                    if (isSaleCreated != null &&
                                        isSaleCreated) {
                                      DHSnackBar().showSnackBar(
                                          "Parabéns!",
                                          "Sua nova venda foi registrada",
                                          DHSnackBarType.success);
                                      presenter.load();
                                    }
                                  }
                                },
                                title: "Vendas",
                                subtitle:
                                    "${presenter.filteredList.length} cadastradas",
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
                          const SalesCalendarWidget(),
                          SingleChildScrollView(
                            child: SalesListWidget(
                              sales: presenter.salesResponseDto.sales,
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
