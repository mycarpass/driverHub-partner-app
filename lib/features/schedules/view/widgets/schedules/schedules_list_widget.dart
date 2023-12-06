import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/presenter/schedules_presenter.dart';
import 'package:driver_hub_partner/features/schedules/view/resources/schedules_resources.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/emptystate/empty_state_list.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/month/month_swiper_widget.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/solicitation_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduledListBodyWidget extends StatefulWidget {
  const ScheduledListBodyWidget({required this.schedules, super.key});

  final List<ScheduleDataDto> schedules;

  @override
  State<ScheduledListBodyWidget> createState() =>
      _ScheduledListBodyWidgetState();
}

class _ScheduledListBodyWidgetState extends State<ScheduledListBodyWidget> {
  @override
  Widget build(BuildContext context) {
    var presenter = context.read<SchedulesPresenter>();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child:
            BlocBuilder<SchedulesPresenter, DHState>(builder: (context, state) {
          return Column(children: [
            MonthSwiperWidget(
                selectedMonth: presenter.selectedMonth,
                onChanged: (_) {
                  presenter.filterListByDate(_);
                }),
            widget.schedules.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        SchedulesResources.schedulesEmptyState,
                      ),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        presenter.filteredList.isEmpty
                            ? const EmptyStateList(
                                text:
                                    'Nenhum agendamento encontrado para o mês selecionado.',
                              )
                            : ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: 32),
                                itemCount: presenter.filteredList.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  color: AppColor.textTertiaryColor,
                                ),
                                itemBuilder: (context, index) =>
                                    SolicitationListItemWidget(
                                  solicitationDataDto:
                                      presenter.filteredList[index],
                                ),
                              ),
                      ])
          ]);
        }));
  }
}
