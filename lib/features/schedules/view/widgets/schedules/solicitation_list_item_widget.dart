import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/schedules/interactor/service/dto/schedules_response_dto.dart';
import 'package:driver_hub_partner/features/schedules/router/params/schedule_detail_param.dart';
import 'package:driver_hub_partner/features/schedules/router/schedules_router.dart';
import 'package:flutter/material.dart';

class SolicitationListItemWidget extends StatelessWidget {
  const SolicitationListItemWidget({
    super.key,
    required this.solicitationDataDto,
  });

  final ScheduleDataDto solicitationDataDto;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0)),
      onPressed: () => Navigator.pushNamed(
        context,
        SchedulesRoutes.scheduleDetail,
        arguments:
            ScheduleDetailParams(scheduleId: solicitationDataDto.scheduleId),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.backgroundTertiary,
              child: Text(
                solicitationDataDto.client.getInitialsName(),
                overflow: TextOverflow.ellipsis,
              ).label1_regular(),
            ),
            const SizedBox(
              width: 24,
            ),
            Flexible(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(solicitationDataDto.client.getFirstAndLastName())
                      .body_bold(),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(solicitationDataDto.vehicle?.nickname ??
                          "Veículo não cadastrado")
                      .body_regular(),

                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(solicitationDataDto.scheduleDate).body_bold(
                        style: TextStyle(
                            color: AppColor.textPrimaryColor.withOpacity(0.8)),
                      ),
                      solicitationDataDto.canShowSelectedHour()
                          ? Text(" - ${solicitationDataDto.getSelectecHour()}")
                              .body_bold(
                                  style: TextStyle(
                                      color: AppColor.textPrimaryColor
                                          .withOpacity(0.8)))
                          : const SizedBox.shrink()
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    Container(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        decoration: BoxDecoration(
                            color: solicitationDataDto
                                .fetchTagColor()
                                .withOpacity(0.1),
                            border: Border.all(
                                width: 0.5,
                                color: solicitationDataDto.fetchTagColor()),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(solicitationDataDto.getIcon(),
                                  size: 16,
                                  color: solicitationDataDto.fetchTagColor()),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(solicitationDataDto.statusFriendly)
                                  .caption2_regular()
                            ]))
                  ])
                  // Text(solicitationDataDto.statusFriendly).body_regular(
                  //     style:
                  //         const TextStyle(color: AppColor.textTertiaryColor)),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColor.iconPrimaryColor,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
