import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/service/dto/pos_sales_response_dto.dart';
import 'package:driver_hub_partner/features/pos_sales/router/pos_sales_router.dart';

import 'package:flutter/material.dart';

class PosSalesListItemWidget extends StatelessWidget {
  const PosSalesListItemWidget({
    super.key,
    required this.posSalesDto,
  });

  final PosSalesDto posSalesDto;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            padding: const MaterialStatePropertyAll(EdgeInsets.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0)),
        onPressed: () {
          Navigator.of(context).pushNamed(
            PosSalesRoutes.posSalesDetail,
            arguments: posSalesDto,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColor.backgroundTertiary,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(posSalesDto.client.personName
                                .getFirstAndLastName())
                            .body_bold(),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.home_repair_service,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(posSalesDto.service.serviceName).body_regular(
                            style: const TextStyle(
                                color: AppColor.textSecondaryColor)),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              !posSalesDto.isMadeContact
                                  ? CustomIcons.dhWhatsapp
                                  : Icons.check_circle_outline_rounded,
                              color: !posSalesDto.isMadeContact
                                  ? AppColor.iconPrimaryColor
                                  : AppColor.accentColor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(!posSalesDto.isMadeContact
                                    ? "Aguardando contato"
                                    : "Contato realizado")
                                .body_regular(
                                    style: TextStyle(
                                        color: !posSalesDto.isMadeContact
                                            ? AppColor.textTertiaryColor
                                            : AppColor.accentColor))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
