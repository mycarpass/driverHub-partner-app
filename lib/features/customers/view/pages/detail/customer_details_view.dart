import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_skeleton.dart';
import 'package:dh_ui_kit/view/widgets/snack_bar/dh_snack_bar.dart';
import 'package:driver_hub_partner/features/customers/presenter/cutomer_register_presenter.dart';
import 'package:driver_hub_partner/features/customers/presenter/details/customer_details_presenter.dart';
import 'package:driver_hub_partner/features/customers/router/params/customer_detail_param.dart';
import 'package:driver_hub_partner/features/customers/view/widgets/bottomsheets/customer_register_bottom_sheet.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/bottomsheets/create_sale_bottomsheet.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerDetailsView extends StatefulWidget {
  const CustomerDetailsView({
    super.key,
  });

  @override
  State<CustomerDetailsView> createState() => _CustomerDetailsViewState();
}

class _CustomerDetailsViewState extends State<CustomerDetailsView> {
  @override
  Widget build(BuildContext context) {
    CustomerDetailParams customerDetailParams =
        ModalRoute.of(context)?.settings.arguments as CustomerDetailParams;

    var presenter = context.read<CustomerDetailsPresenter>()
      ..load(customerDetailParams.customerDto.customerId.toString());

    return BlocBuilder<CustomerDetailsPresenter, DHState>(
      builder: (context, state) => Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar().modalAppBar(
                backButtonsIsVisible: true,
                title: 'Cliente',
                showHeaderIcon: false,
                doneButtonIsEnabled: true,
                doneButtonText: 'Editar',
                onDonePressed: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    isScrollControlled: true,
                    builder: (context) => CustomerRegisterBottomSheet.update(
                      customerDetailParams.customerDto,
                    ),
                  );
                }),
            body: SafeArea(
                child: state is DHLoadingState
                    ? SingleChildScrollView(
                        child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: DHSkeleton(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 450,
                                      width: double.infinity,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: DHSkeleton(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //const Text("Detalhes do cliente").label1_bold(),
                                  // const SizedBox(
                                  //   height: 12,
                                  // ),
                                  //const Divider(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                backgroundColor:
                                                    AppColor.supportColor,
                                                child: Text(customerDetailParams
                                                        .customerDto
                                                        .getInitialsName())
                                                    .title2_regular(),
                                              ))),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(customerDetailParams
                                              .customerDto.name)
                                          .body_bold(),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(customerDetailParams
                                              .customerDto.phone.value)
                                          .body_regular(),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(presenter.customerDetailsDto.data
                                                      .createdAt !=
                                                  null
                                              ? 'Cliente desde ${presenter.customerDetailsDto.data.createdAt!}'
                                              : presenter
                                                      .customerDetailsDto
                                                      .data
                                                      .salesHistory
                                                      .isNotEmpty
                                                  ? 'Cliente desde ${presenter.customerDetailsDto.data.salesHistory.first.saleDate}'
                                                  : "Nenhum serviço realizado ainda")
                                          .caption1_regular(
                                              style: const TextStyle(
                                                  color: AppColor
                                                      .textTertiaryColor)),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        width: 200,
                                        height: 40,
                                        child: TextButton(
                                          style: ButtonStyle(
                                              elevation:
                                                  const MaterialStatePropertyAll(
                                                      0.0),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
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
                                                    "+55${customerDetailParams.customerDto.phone.withoutSymbolValue}",
                                                // "text":
                                                //     "Olá, "
                                              },
                                            );
                                            presenter.openUrl(uri);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                                border: Border.all(
                                                    color:
                                                        AppColor.accentColor)),
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
                                      ),
                                      const SizedBox(height: 12),
                                      // Text('Ações').body_regular(),
                                      // const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
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
                                              onPressed: () async {
                                                bool? isSaleCreated =
                                                    await showModalBottomSheet<
                                                        bool>(
                                                  context: context,
                                                  showDragHandle: true,
                                                  isScrollControlled: true,
                                                  builder: (context) =>
                                                      CreateSaleBottomSheet(
                                                    selectedCustomer:
                                                        customerDetailParams
                                                            .customerDto,
                                                  ),
                                                );

                                                if (isSaleCreated != null &&
                                                    isSaleCreated) {
                                                  DHSnackBar().showSnackBar(
                                                      "Uhuuu",
                                                      "Sua nova venda foi registrada",
                                                      DHSnackBarType.success);
                                                  presenter.load(
                                                    customerDetailParams
                                                        .customerDto.customerId
                                                        .toString(),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .textTertiaryColor)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .add_shopping_cart_outlined,
                                                        color: AppColor
                                                            .textSecondaryColor,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      const Text(
                                                        'Nova venda',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ).body_regular(
                                                          style: const TextStyle(
                                                              color: AppColor
                                                                  .textSecondaryColor))
                                                    ],
                                                  ))),
                                          TextButton(
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
                                              onPressed: () async {
                                                bool? isScheduleCreated =
                                                    await showModalBottomSheet(
                                                  context: context,
                                                  showDragHandle: true,
                                                  isScrollControlled: true,
                                                  builder: (context) =>
                                                      CreateScheduleBottomSheet(
                                                          selectedCustomer:
                                                              customerDetailParams
                                                                  .customerDto),
                                                );

                                                if (isScheduleCreated != null &&
                                                    isScheduleCreated) {
                                                  // presenter.load();
                                                  DHSnackBar().showSnackBar(
                                                      "Sucesso!",
                                                      "Seu novo agendamento foi criado",
                                                      DHSnackBarType.success);
                                                }
                                              },
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .textTertiaryColor)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        color: AppColor
                                                            .textSecondaryColor,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      const Text(
                                                        'Novo agendamento',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ).body_regular(
                                                          style: const TextStyle(
                                                              color: AppColor
                                                                  .textSecondaryColor))
                                                    ],
                                                  )))
                                        ],
                                      )
                                    ],
                                  ),
                                  // DetailsCellWidget(
                                  //   items: [
                                  //     customerDetailParams.customerDto.name,
                                  //     customerDetailParams.customerDto.phone.value
                                  //   ],
                                  //   title: "Cliente",
                                  //   iconButton: IconButton(
                                  //     onPressed: () {
                                  //       Uri uri = Uri(
                                  //         host: "api.whatsapp.com",
                                  //         scheme: "https",
                                  //         path: "send",
                                  //         queryParameters: {
                                  //           "phone":
                                  //               "+55${customerDetailParams.customerDto.phone.withoutSymbolValue}",
                                  //           // "text":
                                  //           //     "Olá, "
                                  //         },
                                  //       );
                                  //       presenter.openUrl(uri);
                                  //     },
                                  //     icon: const Icon(
                                  //       Icons.chat,
                                  //       color: AppColor.accentColor,
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DetailsCellWidget(items: [
                                    customerDetailParams
                                            .customerDto.vehicle?.name ??
                                        "Não informado"
                                  ], title: "Veículo do cliente"),
                                  // DetailsCellWidget(items: [
                                  //   presenter.customerDetailsDto.data.createdAt !=
                                  //           null
                                  //       ? presenter
                                  //           .customerDetailsDto.data.createdAt!
                                  //       : presenter.customerDetailsDto.data
                                  //               .salesHistory.isNotEmpty
                                  //           ? presenter.customerDetailsDto.data
                                  //               .salesHistory.first.saleDate
                                  //           : "Nenhum serviço realizado ainda"
                                  // ], title: "Cliente desde"),

                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     TextButton(
                                  //       onPressed: () {
                                  //         showModalBottomSheet<bool?>(
                                  //           context: context,
                                  //           showDragHandle: true,
                                  //           isScrollControlled: true,
                                  //           builder: (_) => BlocProvider(
                                  //             create: (context) =>
                                  //                 CustomerRegisterPresenter(),
                                  //             child: CustomerRegisterBottomSheet
                                  //                 .update(
                                  //               customerDetailParams.customerDto,
                                  //             ),
                                  //           ),
                                  //         );
                                  //       },
                                  //       child: const Text(
                                  //         "Editar dados do cliente",
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),

                                  const Text("Histórico de vendas")
                                      .label1_bold(),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      const Text("Total de ").label2_regular(
                                          style: const TextStyle(
                                              color:
                                                  AppColor.textTertiaryColor)),
                                      Text(presenter.customerDetailsDto.data
                                              .salesHistory.length
                                              .toString())
                                          .label2_bold(),
                                      const Text(" vendas realizadas")
                                          .label2_regular(
                                              style: const TextStyle(
                                                  color: AppColor
                                                      .textTertiaryColor)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("Somando ").label2_regular(
                                          style: const TextStyle(
                                              color:
                                                  AppColor.textTertiaryColor)),
                                      Text(presenter.customerDetailsDto.data
                                              .totalSold.priceInReal)
                                          .label2_bold(),
                                      const Text(" recebidos").label2_regular(
                                          style: const TextStyle(
                                              color:
                                                  AppColor.textTertiaryColor)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),

                                  // DetailsCellWidget(items: [
                                  //   presenter
                                  //       .customerDetailsDto.data.salesHistory.length
                                  //       .toString()
                                  // ], title: "Quantidade de vendas"),
                                  // DetailsCellWidget(items: [
                                  //   presenter.customerDetailsDto.data.totalSold
                                  //       .priceInReal
                                  // ], title: "Total em vendas"),
                                  SizedBox(
                                    height: 130,
                                    child: BlocBuilder<CustomerDetailsPresenter,
                                        DHState>(builder: (context, state) {
                                      if (state is! DHLoadingState) {
                                        return ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              Container(
                                                  width: 200,
                                                  margin: const EdgeInsets.only(
                                                      top: 2,
                                                      left: 4,
                                                      right: 8,
                                                      bottom: 8),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                        Colors.white,
                                                      ),
                                                    ),
                                                    onPressed: () {},
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                presenter
                                                                    .customerDetailsDto
                                                                    .data
                                                                    .salesHistory[
                                                                        index]
                                                                    .saleDate,
                                                              ).body_regular(),
                                                              Text(
                                                                presenter
                                                                    .customerDetailsDto
                                                                    .data
                                                                    .salesHistory[
                                                                        index]
                                                                    .totalAmountPaid
                                                                    .priceInReal,
                                                              ).body_bold()
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          SizedBox(
                                                              height: 60,
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    presenter
                                                                        .customerDetailsDto
                                                                        .data
                                                                        .salesHistory[
                                                                            index]
                                                                        .getServicesRaw(),
                                                                  ).body_regular()))
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            width: 4,
                                          ),
                                          itemCount: presenter
                                              .customerDetailsDto
                                              .data
                                              .salesHistory
                                              .length,
                                        );
                                      } else {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: DHSkeleton(
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                                  ),

                                  // Align(
                                  //   alignment: Alignment.centerRight,
                                  //   child: TextButton(
                                  //     onPressed: () async {
                                  //       bool? isScheduleCreated =
                                  //           await showModalBottomSheet(
                                  //         context: context,
                                  //         showDragHandle: true,
                                  //         isScrollControlled: true,
                                  //         builder: (context) =>
                                  //             CreateScheduleBottomSheet(
                                  //                 selectedCustomer:
                                  //                     customerDetailParams
                                  //                         .customerDto),
                                  //       );

                                  //       if (isScheduleCreated != null &&
                                  //           isScheduleCreated) {
                                  //         // presenter.load();
                                  //         DHSnackBar().showSnackBar(
                                  //             "Sucesso!",
                                  //             "Seu novo agendamento foi criado",
                                  //             DHSnackBarType.success);
                                  //       }
                                  //     },
                                  //     child: const Text("Criar agendamento"),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
          );
        },
      ),
    );
  }
}

class DetailsCellWidget extends StatelessWidget {
  const DetailsCellWidget(
      {super.key, required this.items, required this.title, this.iconButton});

  final List<String> items;
  final String title;
  final IconButton? iconButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title).caption1_regular(
                style: const TextStyle(color: AppColor.textSecondaryColor)),
            const SizedBox(
              height: 8,
            ),
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 4,
              ),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(items[index]).label1_regular(),
                  index == 1 && iconButton != null
                      ? iconButton!
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
