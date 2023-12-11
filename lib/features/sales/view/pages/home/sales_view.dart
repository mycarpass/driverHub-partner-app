// ignore_for_file: sized_box_for_whitespace

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_pull_to_refresh.dart';
import 'package:driver_hub_partner/features/sales/presenter/sales_presenter.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/loading/sales_body_loading.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/sales_error_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/header/tab_header.dart';
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
        )
      ],
      child: Builder(
        builder: (context) {
          return DHPullToRefresh(
            onRefresh: context.read<SalesPresenter>().load,
            key: UniqueKey(),
            child: BlocBuilder<SalesPresenter, DHState>(
              builder: (context, state) {
                //var presenter = context.read<SalesPresenter>();
                return Stack(
                  children: [
                    if (state is DHLoadingState) ...[
                      const SalesBodyLoading()
                    ] else if (state is DHErrorState) ...[
                      const SalesErrorWidget()
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 0, bottom: 12, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabViewHeader(
                              onPressed: () {},
                              title: "Vendas",
                              subtitle: "0 cadastradas",
                            ),
                          ],
                        ),
                      ),
                      DHContainedTabBar(
                        marginTop: 80,
                        tabTexts: const [Text("Calendário"), Text("Lista")],
                        views: [Container(), Container()],
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
