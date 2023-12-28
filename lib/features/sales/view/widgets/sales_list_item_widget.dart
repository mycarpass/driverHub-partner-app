import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/sales/router/sales_router.dart';

import 'package:flutter/material.dart';

class SalesListItemWidget extends StatelessWidget {
  const SalesListItemWidget({
    super.key,
    required this.solicitationDataDto,
  });

  final SalesDto solicitationDataDto;

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
            SalesRoutes.salesDetail,
            arguments: solicitationDataDto,
          );

          // DHSnackBar().showSnackBar(
          //     "😅 Ops..",
          //     "Estamos trabalhando para liberar os detalhes da venda nos próximos dias, aguarde... :)",
          //     DHSnackBarType.warning);
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
                        Text(solicitationDataDto.client.personName
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
                        Text("${solicitationDataDto.services.length} serviço(s)")
                            .body_regular(),
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
                            const Icon(
                              Icons.monetization_on_outlined,
                              color: AppColor.accentColor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text("Total de ${solicitationDataDto.servicesValuePaidSum.priceInReal}")
                                .body_regular(
                                    style: const TextStyle(
                                        color: AppColor.textSecondaryColor))
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                              border: Border.all(color: AppColor.borderColor)),
                          child: Row(
                            children: [
                              Icon(
                                solicitationDataDto.iconPaymentType(),
                                size: 16,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(solicitationDataDto.paymentType?.value ??
                                      "Não informado")
                                  .caption2_regular()
                            ],
                          ),
                        )
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
