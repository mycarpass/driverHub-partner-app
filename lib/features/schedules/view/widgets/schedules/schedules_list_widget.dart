import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:driver_hub_partner/features/home/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/view/resources/schedules_resources.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/schedules/solicitation_list_item_widget.dart';
import 'package:flutter/material.dart';

class ScheduledListBodyWidget extends StatelessWidget {
  const ScheduledListBodyWidget({required this.schedules, super.key});

  final List<ScheduleDataDto> schedules;

  @override
  Widget build(BuildContext context) {
    // var presenter = context.read<ScheduleSolicitationPresenter>();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: schedules.isEmpty
            ? Center(
                child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image.asset(SchedulesResources.schedulesEmptyState)),
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 32),
                    itemCount: schedules.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: AppColor.textTertiaryColor,
                    ),
                    itemBuilder: (context, index) => SolicitationListItemWidget(
                      solicitationDataDto: schedules[index],
                    ),
                  ),
                ],
              ));
  }
}
