// ignore_for_file: sized_box_for_whitespace

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_pull_to_refresh.dart';
import 'package:driver_hub_partner/features/customers/presenter/customers_presenter.dart';
import 'package:driver_hub_partner/features/customers/view/pages/home/customers_list_widget.dart';
import 'package:driver_hub_partner/features/customers/view/widgets/bottomsheets/customer_register_bottom_sheet.dart';
import 'package:driver_hub_partner/features/customers/view/widgets/customers_error_widget.dart';
import 'package:driver_hub_partner/features/customers/view/widgets/loading/customers_body_loading.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/header/tab_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/widgets/tabs/dh_contained_tab_bar.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({super.key});

  @override
  State<CustomersView> createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<CustomersPresenter>(
          create: (BuildContext context) => CustomersPresenter()..load(),
        )
      ],
      child: Builder(
        builder: (context) {
          return DHPullToRefresh(
            onRefresh: context.read<CustomersPresenter>().load,
            key: UniqueKey(),
            child: BlocBuilder<CustomersPresenter, DHState>(
              builder: (context, state) {
                var presenter = context.read<CustomersPresenter>();
                return Stack(
                  children: [
                    if (state is DHLoadingState) ...[
                      const CustomersBodyLoading()
                    ] else if (state is DHErrorState) ...[
                      const CustomersErrorWidget()
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 0, bottom: 12, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabViewHeader(
                              onPressed: () async {
                                bool? isCustomerRegistered =
                                    await showModalBottomSheet<bool?>(
                                  context: context,
                                  showDragHandle: true,
                                  isScrollControlled: true,
                                  builder: (_) => CustomerRegisterBottomSheet(),
                                );

                                if (isCustomerRegistered != null &&
                                    isCustomerRegistered) {
                                  presenter.load();
                                }
                              },
                              title: "Clientes",
                              subtitle:
                                  "${presenter.customersResponseDto.customers.length} cadastrados",
                            ),
                          ],
                        ),
                      ),
                      DHContainedTabBar(
                        marginTop: 80,
                        tabTexts: const [
                          Text("Todos"),
                          Text("Assinantes"),
                        ],
                        views: [
                          SingleChildScrollView(
                              child: CustomersListBodyWidget(
                            customers: presenter.customersResponseDto.customers,
                          )),
                          SingleChildScrollView(
                              child: CustomersListBodyWidget(
                            customers: presenter.subscribers,
                          )),
                        ],
                      ),
                    ]
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
