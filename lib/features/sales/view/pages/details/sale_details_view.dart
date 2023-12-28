import 'package:dh_state_management/dh_state.dart';
import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:dh_ui_kit/view/widgets/loading/dh_skeleton.dart';
import 'package:driver_hub_partner/features/commom_objects/phone_value.dart';
import 'package:driver_hub_partner/features/customers/interactor/service/dto/enum/customer_status.dart';
import 'package:driver_hub_partner/features/customers/view/pages/detail/customer_details_view.dart';
import 'package:driver_hub_partner/features/customers/view/widgets/customer_details_widget.dart';
import 'package:driver_hub_partner/features/sales/interactor/service/dto/sales_response_dto.dart';
import 'package:driver_hub_partner/features/sales/presenter/detail/sale_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    SalesDto salesDto = ModalRoute.of(context)?.settings.arguments as SalesDto;

    var presenter = context.read<SaleDetailsPresenter>()
      ..load(salesDto.id.toString());

    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar().modalAppBar(
              title: "Venda",
              showHeaderIcon: false,
              doneButtonIsEnabled: false,
              backButtonsIsVisible: true,
              doneButtonText: 'Editar'),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Cliente").label1_bold(),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(),
                      BlocBuilder<SaleDetailsPresenter, DHState>(
                          builder: (context, state) {
                        if (state is DHLoadingState) {
                          return Padding(
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
                          );
                        }
                        return CustomerDetailsWidget(
                          onSaleCreated: () {},
                          onScheduleCreated: () {},
                          customerDetailsParams: CustomerDetailsParam(
                              personName: salesDto.client.personName,
                              phoneValue:
                                  PhoneValue(value: salesDto.client.phone),
                              customerId:
                                  presenter.saleDetailsDto.data.client.id,
                              customerStatus: CustomerStatus.verified),
                        );
                      }),
                      const SizedBox(
                        height: 12,
                      ),
                      const DetailsCellWidget(
                          items: ["Não informado"], title: "Veículo"),
                      const SizedBox(
                        height: 32,
                      ),
                      const Text("Serviços da venda").label1_bold(),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 160,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.6,
                                  child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                salesDto.services[index]
                                                    .serviceName,
                                              ).body_bold(),
                                              IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () {})
                                            ],
                                          ),
                                          const Text("Veículo Não informado")
                                              .caption1_regular(
                                                  style: const TextStyle(
                                                      color: AppColor
                                                          .textSecondaryColor)),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Preço: ${salesDto.services[index].value.priceInReal}",
                                              ),
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
                            itemCount: salesDto.services.length),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Resumo").label1_bold(),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(),
                      BlocBuilder<SaleDetailsPresenter, DHState>(
                          builder: (context, state) => state is DHLoadingState
                              ? Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: DHSkeleton(
                                        child: Container(
                                          height: 560,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    DetailsCellWidget(
                                      items: [
                                        presenter.saleDetailsDto.data.createdAt
                                      ],
                                      title: "Data",
                                    ),
                                    DetailsCellWidget(
                                      items: [
                                        presenter.saleDetailsDto.data
                                            .discountValue.priceInReal
                                      ],
                                      title: "Desconto",
                                    ),
                                    DetailsCellWidget(
                                      items: [
                                        presenter.saleDetailsDto.data
                                            .subTotalPaid.priceInReal
                                      ],
                                      title: "Sub-Total",
                                    ),
                                    DetailsCellWidget(
                                      items: [
                                        presenter.saleDetailsDto.data
                                            .totalAmountPaid.priceInReal
                                      ],
                                      title: "Total",
                                    ),
                                    DetailsCellWidget(
                                      items: [
                                        presenter.saleDetailsDto.data
                                                .paymentType?.value ??
                                            "Não informado"
                                      ],
                                      title: "Forma de pagamento",
                                    ),
                                  ],
                                ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
