// ignore_for_file: sized_box_for_whitespace

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/bottomsheet/dh_date_picker_bottom_sheet.dart';
import 'package:dh_ui_kit/view/widgets/dh_text_field.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_pull_to_refresh.dart';
import 'package:driver_hub_partner/features/home/presenter/subscription_presenter.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/card_date_read_only.dart';
import 'package:driver_hub_partner/features/schedules/view/pages/home/ligh_dh_date_picker.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_bottom_sheet.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/header/tab_header.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/loading/schedules_body_loading.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/calendar_schedules_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/schedules_list_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/widgets/tabs/dh_contained_tab_bar.dart';

class SchedulesView extends StatefulWidget {
  const SchedulesView({super.key});

  @override
  State<SchedulesView> createState() => _SchedulesViewState();
}

class _SchedulesViewState extends State<SchedulesView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<SchedulesPresenter>(
          create: (BuildContext context) => SchedulesPresenter()..load(),
        ),
        BlocProvider<SubscriptionPresenter>(
          create: (BuildContext context) => SubscriptionPresenter()..start(),
        )
      ],
      child: Builder(
        builder: (context) {
          return DHPullToRefresh(
            onRefresh: context.read<SchedulesPresenter>().load,
            key: UniqueKey(),
            child: BlocBuilder<SchedulesPresenter, DHState>(
              // buildWhen: (previous, current) => current is! FilteredListState,
              builder: (context, state) {
                var presenter = context.read<SchedulesPresenter>();
                return Stack(
                  children: [
                    if (state is DHLoadingState) ...[
                      const SchedulesBodyLoading()
                    ] else if (state is DHErrorState) ...[
                      const SchedulesErrorWidget()
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, bottom: 12, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<SubscriptionPresenter, DHState>(
                                builder: (context, state) => TabViewHeader(
                                      onPressed: () {
                                        // NO MERGE - ALTERAR DONOTHINGACTION POR CHAMADA DE TELA DE CADASTRAR AGENDAMENTO
                                        false
                                            // !context
                                            //         .read<SubscriptionPresenter>()
                                            //         .isSubscribed
                                            ? context
                                                .read<SubscriptionPresenter>()
                                                .openPayWall(context)
                                            : showModalBottomSheet(
                                                context: context,
                                                showDragHandle: true,
                                                builder: (context) =>
                                                    CreateScheduleBottomSheet(),
                                              );
                                      },
                                      addButtonIsVisible: context
                                          .read<SubscriptionPresenter>()
                                          .isSubscribed,
                                      title: "Agenda",
                                      subtitle:
                                          "${presenter.filteredList.length} agendamentos esse mês",
                                    )),
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
                          CalendarScheduledBodyWidget(
                            schedules:
                                presenter.schedulesResponseDto.data.schedules,
                          ),

                          // BlocBuilder<SchedulesPresenter, DHState>(
                          //     builder: (context, state) {
                          //   return SingleChildScrollView(
                          //     child: MonthSwiperWidget(
                          //       selectedMonth: presenter.selectedMonth,
                          //       onChanged: (_) {
                          //         presenter.filterListByDate(_);
                          //       },
                          //     ),
                          //   );
                          // }),
                          SingleChildScrollView(
                              child: ScheduledListBodyWidget(
                            schedules:
                                presenter.schedulesResponseDto.data.schedules,
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
