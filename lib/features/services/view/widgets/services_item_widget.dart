import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:driver_hub_partner/features/services/router/services_router.dart';
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
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0)),
      onPressed: () {
        Navigator.of(context)
            .pushNamed(ServicesRoutes.servicesDetail, arguments: serviceDto);
        // DHSnackBar().showSnackBar(
        //     "😅 Ops..",
        //     "Estamos trabalhando para liberar os detalhes do serviço nos próximos dias, aguarde... :)",
        //     DHSnackBarType.warning);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColor.backgroundTertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
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
