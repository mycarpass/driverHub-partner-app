// ignore_for_file: sized_box_for_whitespace

import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_pull_to_refresh.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/loading/schedules_body_loading.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/schedules_list_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dh_ui_kit/view/widgets/tabs/dh_contained_tab_bar.dart';

class SchedulesView extends StatelessWidget {
  const SchedulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SchedulesPresenter>(
          create: (BuildContext context) => SchedulesPresenter()..load(),
        )
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<SchedulesPresenter, DHState>(
              builder: (context, state) => DHPullToRefresh(
                  onRefresh: context.read<SchedulesPresenter>().load,
                  key: UniqueKey(),
                  child: BlocBuilder<SchedulesPresenter, DHState>(
                      builder: (context, state) {
                    var presenter = context.read<SchedulesPresenter>();
                    return Stack(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is DHLoadingState) ...[
                          const SchedulesBodyLoading()
                        ] else if (state is DHErrorState) ...[
                          const SchedulesErrorWidget()
                        ] else ...[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 0, bottom: 12, right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Agendamentos').title1_bold(),
                                ],
                              )),
                          DHContainedTabBar(
                            marginTop: 50,
                            tabTexts: const [
                              Text("Pendentes"),
                              Text("Agendados"),
                              Text("Concluídos")
                            ],
                            views: [
                              SingleChildScrollView(
                                  child: ScheduledListBodyWidget(
                                schedules: presenter
                                    .schedulesResponseDto.data.schedulesPending,
                              )),
                              SingleChildScrollView(
                                  child: ScheduledListBodyWidget(
                                schedules: presenter.schedulesResponseDto.data
                                    .schedulesAccepted,
                              )),
                              SingleChildScrollView(
                                  child: ScheduledListBodyWidget(
                                schedules: presenter
                                    .schedulesResponseDto.data.schedulesDone,
                              )),
                            ],
                          ),
                        ]
                      ],
                    );
                  })));
        },
      ),
    );
  }
}
