import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:flutter/material.dart';

class ServiceItemWidget extends StatelessWidget {
  const ServiceItemWidget({
    super.key,
    required this.serviceDto,
  });

  final PartnerServiceDto serviceDto;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0)),
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   radius: 20,
                //   backgroundColor: AppColor.backgroundTransparent,
                //   child: Text(
                //     customerDto.getInitialsName(),
                //     overflow: TextOverflow.ellipsis,
                //   ).caption1_bold(),
                // ),
                // const SizedBox(
                //   width: 20,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    serviceDto.isLiveOnApp
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                            decoration: const BoxDecoration(
                                color: AppColor.supportColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            child: Row(children: [
                              const Icon(
                                Icons.visibility_outlined,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              const Text('Visível').caption2_bold()
                            ]),
                          )
                        : const SizedBox.shrink(),
                    Row(
                      children: [
                        Text(serviceDto.name).body_bold(),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text("Já fez ${serviceDto.quantityDoneServices} vendas")
                        .body_regular(),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on_outlined,
                          size: 16,
                          color: AppColor.accentColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text("Ganhou no total ${serviceDto.totalAmountBilling}")
                            .caption1_regular()
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            const Icon(
              Icons.chevron_right,
              color: AppColor.iconPrimaryColor,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
