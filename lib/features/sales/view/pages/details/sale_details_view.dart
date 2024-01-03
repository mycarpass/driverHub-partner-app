import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_skeleton.dart';
import 'package:driver_hub_partner/features/commom_objects/payment_type.dart';
import 'package:driver_hub_partner/features/commom_objects/phone_value.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/customers_response_dto.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/customers/router/customers_router.dart';
import 'package:driver_hub_partner/features/customers/router/params/customer_detail_param.dart';
import 'package:driver_hub_partner/features/customers/view/pages/detail/customer_details_view.dart';
import 'package:driver_hub_partner/features/customers/view/widgets/customer_details_widget.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/sales/presenter/detail/sale_detail_presenter.dart';
import 'package:driver_hub_partner/features/sales/view/widgets/bottomsheets/update/update_sale_bottomsheet.dart';
import 'package:driver_hub_partner/features/schedules/view/widgets/bottomsheets/create_schedule/create_schedule_presenter.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/services_response_dto.dart';
import 'package:driver_hub_partner/features/services/router/services_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SaleDetailsView extends StatefulWidget {
  const SaleDetailsView({
    super.key,
  });

  @override
  State<SaleDetailsView> createState() => _SaleDetailsViewState();
}

class _SaleDetailsViewState extends State<SaleDetailsView> {
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)?.settings.arguments as String;

    var presenter = context.read<SaleDetailsPresenter>()..load(id);

    return Builder(
      builder: (context) {
        return BlocBuilder<SaleDetailsPresenter, DHState>(
            builder: (context, state) {
          return Scaffold(
            appBar: AppBar().modalAppBar(
              title: "Venda",
              showHeaderIcon: false,
              //TODO Fix null check
              doneButtonIsEnabled: false,
              onDonePressed: state is DHSuccessState &&
                      presenter.saleDetailsDto.data.scheduleId != null
                  ? () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return AlterSaleBottomSheet(
                            serviceList:
                                presenter.saleDetailsDto.toServiceDtoList(),
                            saleDate: DateFormat("dd/mm/yyy").parse(
                              presenter.saleDetailsDto.data.saleDate,
                            ),
                            paymentType:
                                presenter.saleDetailsDto.data.paymentType ??
                                    PaymentType.creditCard,
                            selectedCustomer: CustomerDto(
                              customerId: int.parse(
                                  presenter.saleDetailsDto.data.client.id),
                              status: CustomerStatus.verified,
                              name: presenter.saleDetailsDto.data.client.name,
                              phone: PhoneValue(
                                value:
                                    presenter.saleDetailsDto.data.client.phone,
                              ),
                              isSubscribed: true,
                            ),
                          );
                        },
                      );
                    }
                  : () => DoNothingAction(),
              backButtonsIsVisible: true,
              doneButtonText: 'Editar',
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: BlocBuilder<SaleDetailsPresenter, DHState>(
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
                                        child: Text(presenter
                                                .saleDetailsDto.data.client.name
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
                                      Text(presenter.saleDetailsDto.data.client
                                              .name.name)
                                          .body_bold(),
                                      Text(presenter
                                              .saleDetailsDto.data.client.phone)
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
                                            vehicle: presenter.saleDetailsDto
                                                .data.client.vehicle,
                                            customerId: int.parse(presenter
                                                .saleDetailsDto.data.client.id),
                                            phone: PhoneValue(
                                                value: presenter.saleDetailsDto
                                                    .data.client.phone),
                                            status: CustomerStatus.verified,
                                            isSubscribed: false,
                                            name: presenter.saleDetailsDto.data
                                                .client.name),
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
                            Text(presenter.saleDetailsDto.data.client.vehicle
                                        ?.make ??
                                    "Não informado")
                                .body_regular(),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(presenter.saleDetailsDto.data.client.vehicle
                                        ?.nickname ??
                                    "")
                                .body_regular()
                          ]),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Data da venda').caption1_regular(),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(presenter.saleDetailsDto.data.saleDate)
                              .body_regular(),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Forma de pagamento').caption1_regular(),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                border:
                                    Border.all(color: AppColor.borderColor)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  presenter.saleDetailsDto.data.paymentType
                                          ?.iconPaymentType() ??
                                      CustomIcons.dhCanceled,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(presenter.saleDetailsDto.data.paymentType
                                            ?.value ??
                                        "Não informado")
                                    .caption2_regular()
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Desconto').caption1_regular(),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(presenter.saleDetailsDto.data.discountValue
                                  .priceInReal)
                              .body_regular(),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Sub-total').caption1_regular(),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(presenter
                                  .saleDetailsDto.data.subTotalPaid.priceInReal)
                              .body_regular(),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text('Total').caption1_regular(),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(presenter.saleDetailsDto.data.totalAmountPaid
                                  .priceInReal)
                              .label2_bold(
                                  style: const TextStyle(
                                      color: AppColor.accentColor)),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text("Serviços da venda").label1_bold(),
                          Text("Total de ${presenter.saleDetailsDto.data.services.length} serviço(s)")
                              .body_regular(),
                          const SizedBox(
                            height: 12,
                          ),

                          SizedBox(
                            height: 120,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.5,
                                      child: Card(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                presenter
                                                    .saleDetailsDto
                                                    .data
                                                    .services[index]
                                                    .serviceName,
                                              ).body_bold(),
                                              Column(
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
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        presenter
                                                            .saleDetailsDto
                                                            .data
                                                            .services[index]
                                                            .chargedPrice
                                                            .priceInReal,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 8,
                                    ),
                                itemCount: presenter
                                    .saleDetailsDto.data.services.length),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
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
