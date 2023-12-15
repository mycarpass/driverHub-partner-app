import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';

import 'package:flutter/material.dart';

class SalesListItemWidget extends StatelessWidget {
  const SalesListItemWidget({
    super.key,
    required this.solicitationDataDto,
  });

  final SalesDto solicitationDataDto;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.accentColor),
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
                    const Text("Cliente:").body_regular(),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(solicitationDataDto.client.personName
                            .getFirstAndLastName())
                        .body_bold(),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Valor pago:").body_regular(),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(solicitationDataDto.servicesValuePaidSum.priceInReal)
                        .body_bold(),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Criado em:").body_regular(),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(solicitationDataDto.friendlyDate).body_bold(),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Pago com:").body_regular(),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(solicitationDataDto.paymentType?.value ??
                            "Não informado")
                        .body_bold(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
