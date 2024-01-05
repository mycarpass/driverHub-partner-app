import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/receipt/receipt_schedule_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScheduleReceipt extends StatefulWidget {
  const ScheduleReceipt({super.key, required this.entity});

  final ReceiptScheduleEntity entity;

  @override
  // ignore: library_private_types_in_public_api
  _ScheduleReceiptState createState() => _ScheduleReceiptState();
}

class _ScheduleReceiptState extends State<ScheduleReceipt> {
  DateTime dateSelected = DateTime.now();

  String? url;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(color: AppColor.borderColor, width: 1.5)),
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    widget.entity.partnerLogo != null
                        ? SizedBox(
                            width: 48,
                            height: 48,
                            child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(48)),
                                child: Image.network(
                                  widget.entity.partnerLogo!,
                                  fit: BoxFit.cover,
                                )))
                        : CircleAvatar(
                            backgroundColor: AppColor.borderColor,
                            child: Text(
                              widget.entity.getInitialsName(),
                              overflow: TextOverflow.ellipsis,
                            ).label1_regular(
                                style: const TextStyle(
                                    color: AppColor.textSecondaryColor)),
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.entity.partnerName,
                          textAlign: TextAlign.center,
                        ).caption1_bold(
                            style: const TextStyle(
                                color: AppColor.textPrimaryColor)),
                        const Text(
                          'Comprovante de agendamento',
                          textAlign: TextAlign.center,
                        ).caption1_regular(
                            style: const TextStyle(
                                color: AppColor.textSecondaryColor)),
                      ],
                    )
                  ],
                ),
                const Divider(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cliente',
                      textAlign: TextAlign.center,
                    ).caption1_bold(
                        style: const TextStyle(
                            color: AppColor.textSecondaryColor)),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(children: [
                      const Icon(
                        Icons.person_outline,
                        size: 20,
                        color: AppColor.iconPrimaryColor,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.entity.customerName,
                        textAlign: TextAlign.center,
                      ).caption1_bold(
                          style: const TextStyle(
                              color: AppColor.textSecondaryColor)),
                    ]),
                    widget.entity.vehicle != null
                        ? Row(children: [
                            const Icon(
                              CustomIcons.dhCar2,
                              size: 20,
                              color: AppColor.iconPrimaryColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              widget.entity.vehicle?.model ?? "",
                              textAlign: TextAlign.center,
                            ).caption1_regular(
                                style: const TextStyle(
                                    color: AppColor.textSecondaryColor)),
                          ])
                        : const SizedBox.shrink()
                  ],
                ),
                const Divider(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data e Horário',
                      textAlign: TextAlign.center,
                    ).caption1_bold(
                        style: const TextStyle(
                            color: AppColor.textSecondaryColor)),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 20,
                          color: AppColor.iconPrimaryColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.entity.scheduleDate,
                          textAlign: TextAlign.center,
                        ).caption1_regular(
                            style: const TextStyle(
                                color: AppColor.textSecondaryColor)),
                      ],
                    )
                  ],
                ),
                const Divider(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Serviços',
                      textAlign: TextAlign.center,
                    ).caption1_bold(
                        style: const TextStyle(
                            color: AppColor.textSecondaryColor)),
                    const SizedBox(
                      height: 4,
                    ),
                    ListView.builder(
                      itemCount: widget.entity.services.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Row(
                        children: [
                          const Text(
                            '•',
                            textAlign: TextAlign.center,
                          ).caption1_regular(
                              style: const TextStyle(
                                  color: AppColor.textSecondaryColor)),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.entity.services[index],
                            textAlign: TextAlign.center,
                          ).caption1_regular(
                              style: const TextStyle(
                                  color: AppColor.textSecondaryColor)),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Valor total',
                      textAlign: TextAlign.center,
                    ).caption1_bold(
                        style: const TextStyle(
                            color: AppColor.textSecondaryColor)),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on_outlined,
                          size: 20,
                          color: AppColor.iconPrimaryColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.entity.total.priceInReal,
                          textAlign: TextAlign.center,
                        ).caption1_bold(
                            style: const TextStyle(
                                color: AppColor.textSecondaryColor)),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      "lib/assets/images/LogoBlack.svg",
                      height: 14,
                    )),
              ]),
        ));
  }
}
