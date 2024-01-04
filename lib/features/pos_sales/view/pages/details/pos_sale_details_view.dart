import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_skeleton.dart';
import 'package:driver_hub_partner/features/commom_objects/extensions/date_extensions.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/customers/router/customers_router.dart';
import 'package:driver_hub_partner/features/customers/router/params/customer_detail_param.dart';
import 'package:driver_hub_partner/features/pos_sales/interactor/service/dto/pos_sales_response_dto.dart';
import 'package:driver_hub_partner/features/pos_sales/presenter/detail/pos_sale_detail_presenter.dart';
import 'package:driver_hub_partner/features/sales/router/sales_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class PosSaleDetailsView extends StatefulWidget {
  const PosSaleDetailsView({
    super.key,
  });

  @override
  State<PosSaleDetailsView> createState() => _PosSaleDetailsViewState();
}

class _PosSaleDetailsViewState extends State<PosSaleDetailsView> {
  late final PosSalesDto posSalesDto;

  @override
  void didChangeDependencies() {
    posSalesDto = ModalRoute.of(context)?.settings.arguments as PosSalesDto;
    super.didChangeDependencies();
  }

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
    //String id = ModalRoute.of(context)?.settings.arguments as String;

    var presenter = context.read<PosSaleDetailsPresenter>();

    return Builder(
      builder: (context) {
        return BlocBuilder<PosSaleDetailsPresenter, DHState>(
            builder: (context, state) {
          return Scaffold(
            appBar: AppBar().modalAppBar(
              title: "Pós-venda",
              showHeaderIcon: false,
              backButtonsIsVisible: true,
              doneButtonText: '',
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: BlocBuilder<PosSaleDetailsPresenter, DHState>(
                      builder: (context, state) {
                    if (state is DHLoadingState) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: DHSkeleton(
                                child: Container(
                                  height: 260,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: DHSkeleton(
                                child: Container(
                                  height: 660,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text("Cliente").body_regular(),
                          // const SizedBox(
                          //   height: 12,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: CircleAvatar(
                                        backgroundColor: AppColor.supportColor,
                                        child: Text(posSalesDto
                                                .client.personName
                                                .getInitialsName())
                                            .label2_regular(),
                                      )),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(posSalesDto.client.personName.name)
                                          .body_bold(),
                                      Text(posSalesDto.client.phone.value)
                                          .body_regular(),
                                    ],
                                  )
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      CustomerRoutes.detail,
                                      arguments: CustomerDetailParams(
                                        customerDto: CustomerDto(
                                            vehicle: posSalesDto.client.vehicle,
                                            customerId: posSalesDto.client.id,
                                            phone: posSalesDto.client.phone,
                                            status: CustomerStatus.verified,
                                            isSubscribed: false,
                                            name:
                                                posSalesDto.client.personName),
                                      ),
                                    );
                                  },
                                  child: Row(children: [
                                    const Text('Ver cliente').caption1_regular(
                                        style: const TextStyle(
                                            color:
                                                AppColor.textSecondaryColor)),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Icon(Icons.open_in_new,
                                        color: AppColor.iconPrimaryColor,
                                        size: 16),
                                  ]))
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text('Veículo do cliente').caption1_regular(),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(children: [
                            Text(posSalesDto.client.vehicle?.make ??
                                    "Não informado")
                                .body_regular(),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(posSalesDto.client.vehicle?.nickname ?? "")
                                .body_regular()
                          ]),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Serviço que gerou a oportunidade')
                              .caption1_regular(),
                          const SizedBox(
                            height: 4,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  SalesRoutes.salesDetail,
                                  arguments: posSalesDto.saleId.toString());
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    posSalesDto.service.serviceName,
                                  ).body_bold(),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Valor cobrado")
                                          .caption1_regular(
                                              style: const TextStyle(
                                                  color: AppColor
                                                      .textSecondaryColor)),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        posSalesDto.service.value.priceInReal,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Data do serviço').caption1_regular(),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(posSalesDto.saleDate
                                  .formatDate('dd/MM/yyyy', 'pt_BR'))
                              .body_regular(),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Data para o pós-venda')
                              .caption1_regular(),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(posSalesDto.posSaleDate
                                  .formatDate('dd/MM/yyyy', 'pt_BR'))
                              .body_bold(
                                  style: const TextStyle(
                                      color: AppColor.textSecondaryColor)),
                          const SizedBox(
                            height: 24,
                          ),
                          BlocBuilder<PosSaleDetailsPresenter, DHState>(
                              builder: (context, state) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              hoverColor:
                                                  AppColor.accentHoverColor,
                                              side: const BorderSide(
                                                  color: AppColor.accentColor),
                                              checkColor:
                                                  AppColor.backgroundColor,
                                              activeColor: AppColor.accentColor,
                                              value: posSalesDto.isMadeContact,
                                              onChanged: (value) {
                                                posSalesDto.isMadeContact =
                                                    value ?? false;
                                                presenter.changeMadeContact(
                                                    value ?? false,
                                                    posSalesDto.id);
                                              },
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Contato realizado")
                                                    .body_regular(
                                                        style: const TextStyle(
                                                            color: AppColor
                                                                .textPrimaryColor)),
                                                Text("(fazer em ${posSalesDto.posSaleDate.formatDate('dd/MM/yyyy', 'pt_BR')})")
                                                    .caption1_regular(
                                                        style: const TextStyle(
                                                            color: AppColor
                                                                .textTertiaryColor)),
                                              ],
                                            )
                                          ],
                                        )),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Center(
                                            child: SizedBox(
                                          width: 200,
                                          height: 40,
                                          child: TextButton(
                                            style: ButtonStyle(
                                                elevation:
                                                    const MaterialStatePropertyAll(
                                                        0.0),
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                padding:
                                                    const MaterialStatePropertyAll(
                                                        EdgeInsets.zero)),
                                            onPressed: () {
                                              Uri uri = Uri(
                                                host: "api.whatsapp.com",
                                                scheme: "https",
                                                path: "send",
                                                queryParameters: {
                                                  "phone":
                                                      "+55${posSalesDto.client.phone.withoutSymbolValue}",
                                                  // "text":
                                                  //     "Olá, "
                                                },
                                              );

                                              openUrl(uri);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(8)),
                                                  border: Border.all(
                                                      color: AppColor
                                                          .accentColor)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                      style: const TextStyle(
                                                          color: AppColor
                                                              .accentColor))
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                      ])),
                          const SizedBox(
                            height: 48,
                          ),

                          // const Text('Total').caption1_regular(),
                          // const SizedBox(
                          //   height: 4,
                          // ),
                          // Text(presenter.saleDetailsDto.data.totalAmountPaid
                          //         .priceInReal)
                          //     .label2_bold(
                          //         style: const TextStyle(
                          //             color: AppColor.accentColor)),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // const Text("Serviços da venda").label1_bold(),
                          // Text("Total de ${presenter.saleDetailsDto.data.services.length} serviço(s)")
                          //     .body_regular(),
                          // const SizedBox(
                          //   height: 12,
                          // ),

                          // SizedBox(
                          //   height: 120,
                          //   child: ListView.separated(
                          //       scrollDirection: Axis.horizontal,
                          //       itemBuilder: (context, index) => SizedBox(
                          //             width: MediaQuery.sizeOf(context).width *
                          //                 0.5,
                          //             child: Card(
                          //               color: Colors.white,
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(12.0),
                          //                 child: Column(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text(
                          //                       presenter
                          //                           .saleDetailsDto
                          //                           .data
                          //                           .services[index]
                          //                           .serviceName,
                          //                     ).body_bold(),
                          //                     Column(
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                       children: [
                          //                         const Text("Valor cobrado")
                          //                             .caption1_regular(
                          //                                 style: const TextStyle(
                          //                                     color: AppColor
                          //                                         .textSecondaryColor)),
                          //                         const SizedBox(
                          //                           height: 4,
                          //                         ),
                          //                         Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                           children: [
                          //                             Text(
                          //                               presenter
                          //                                   .saleDetailsDto
                          //                                   .data
                          //                                   .services[index]
                          //                                   .chargedPrice
                          //                                   .priceInReal,
                          //                             ),
                          //                           ],
                          //                         )
                          //                       ],
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //       separatorBuilder: (context, index) =>
                          //           const SizedBox(
                          //             width: 8,
                          //           ),
                          //       itemCount: presenter
                          //           .saleDetailsDto.data.services.length),
                          // ),
                          // const SizedBox(
                          //   height: 12,
                          // ),
                        ],
                      );
                    }
                  }),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
