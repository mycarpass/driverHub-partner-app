import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/commom_objects/person_name.dart';
import 'package:driver_hub_partner/features/commom_objects/phone_value.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/bottomsheets/create_sale_bottomsheet.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerDetailsParam {
  final PersonName personName;
  final PhoneValue phoneValue;
  final String customerId;
  final CustomerStatus customerStatus;
  final String? createdAt;

  CustomerDetailsParam(
      {required this.personName,
      required this.phoneValue,
      required this.customerId,
      required this.customerStatus,
      this.createdAt});

  static fromCustomerDto(CustomerDto customerDto) {
    return CustomerDetailsParam(
        personName: customerDto.name,
        phoneValue: customerDto.phone,
        customerId: customerDto.customerId.toString(),
        customerStatus: customerDto.status);
  }

  CustomerDto toCustomerDto() {
    return CustomerDto(
        customerId: int.parse(customerId),
        status: customerStatus,
        name: personName,
        phone: phoneValue,
        isSubscribed: false);
  }
}

class CustomerDetailsWidget extends StatelessWidget {
  const CustomerDetailsWidget({
    super.key,
    required this.customerDetailsParams,
    required this.onSaleCreated,
    required this.onScheduleCreated,
  });

  final CustomerDetailsParam customerDetailsParams;
  final Function onSaleCreated;
  final Function onScheduleCreated;

  void openUrl(Uri uri) async {
    await canLaunchUrl(uri) ? _launchInBrowser(uri) : null;
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //const Text('Cliente').label2_regular(),
        const SizedBox(
          height: 16,
        ),
        Center(
            child: SizedBox(
                height: 90,
                width: 90,
                child: CircleAvatar(
                  backgroundColor: AppColor.supportColor,
                  child:
                      Text(customerDetailsParams.personName.getInitialsName())
                          .title2_regular(),
                ))),
        const SizedBox(
          height: 16,
        ),
        Text(customerDetailsParams.personName.name).body_bold(),
        const SizedBox(
          height: 4,
        ),
        Text(customerDetailsParams.phoneValue.value).body_regular(),
        const SizedBox(
          height: 4,
        ),
        customerDetailsParams.createdAt != null
            ? Text(customerDetailsParams.createdAt != null
                    ? 'Cliente desde ${customerDetailsParams.createdAt!}'
                    : "Não informado")
                .caption1_regular(
                    style: const TextStyle(color: AppColor.textTertiaryColor))
            : const SizedBox.shrink(),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 200,
          height: 40,
          child: TextButton(
            style: ButtonStyle(
                elevation: const MaterialStatePropertyAll(0.0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
            onPressed: () {
              Uri uri = Uri(
                host: "api.whatsapp.com",
                scheme: "https",
                path: "send",
                queryParameters: {
                  "phone":
                      "+55${customerDetailsParams.phoneValue.withoutSymbolValue}",
                  // "text":
                  //     "Olá, "
                },
              );

              openUrl(uri);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: AppColor.accentColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CustomIcons.dhWhatsapp,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Chamar no WhatsApp',
                    textAlign: TextAlign.center,
                  ).body_regular(
                      style: const TextStyle(color: AppColor.accentColor))
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0.0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
              onPressed: () async {
                bool? isSaleCreated = await showModalBottomSheet<bool>(
                  context: context,
                  showDragHandle: true,
                  isScrollControlled: true,
                  builder: (context) => CreateSaleBottomSheet(
                      selectedCustomer: customerDetailsParams.toCustomerDto()),
                );

                if (isSaleCreated != null && isSaleCreated) {
                  DHSnackBar().showSnackBar("Uhuuu",
                      "Sua nova venda foi registrada", DHSnackBarType.success);
                  onSaleCreated();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      8,
                    ),
                  ),
                  border: Border.all(
                    color: AppColor.textTertiaryColor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_shopping_cart_outlined,
                      color: AppColor.textSecondaryColor,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Nova venda',
                      textAlign: TextAlign.center,
                    ).body_regular(
                      style: const TextStyle(
                        color: AppColor.textSecondaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            TextButton(
                style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0.0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
                onPressed: () async {
                  bool? isScheduleCreated = await showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    isScrollControlled: true,
                    builder: (context) => CreateScheduleBottomSheet(
                      selectedCustomer: customerDetailsParams.toCustomerDto(),
                    ),
                  );

                  if (isScheduleCreated != null && isScheduleCreated) {
                    // presenter.load();
                    DHSnackBar().showSnackBar(
                        "Sucesso!",
                        "Seu novo agendamento foi criado",
                        DHSnackBarType.success);
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: AppColor.textTertiaryColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: AppColor.textSecondaryColor,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Novo agendamento',
                          textAlign: TextAlign.center,
                        ).body_regular(
                            style: const TextStyle(
                                color: AppColor.textSecondaryColor))
                      ],
                    )))
          ],
        )
      ],
    );
  }
}
