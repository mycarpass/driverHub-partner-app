import 'package:dh_ui_kit/view/consts/colors.dart';
import 'package:dh_ui_kit/view/custom_icons/my_flutter_app_icons.dart';
import 'package:dh_ui_kit/view/extensions/text_extension.dart';
import 'package:dh_ui_kit/view/widgets/dh_app_bar.dart';
import 'package:driver_hub_partner/features/services/interactor/service/dto/partner_services_response_dto.dart';
import 'package:driver_hub_partner/features/services/presenter/details/service_details_presenter.dart';
import 'package:driver_hub_partner/features/services/presenter/services_register_presenter.dart';
import 'package:driver_hub_partner/features/services/view/widgets/bottomsheets/service_register_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesDetailsView extends StatefulWidget {
  const ServicesDetailsView({
    super.key,
  });

  @override
  State<ServicesDetailsView> createState() => _ServicesDetailsViewState();
}

class _ServicesDetailsViewState extends State<ServicesDetailsView> {
  @override
  Widget build(BuildContext context) {
    PartnerServiceDto serviceDto =
        ModalRoute.of(context)?.settings.arguments as PartnerServiceDto;

    var presenter = context.read<ServiceDetailsPresenter>();

    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar().backButton(),
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
                      const Text("Detalhes do serviço").label1_bold(),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(),
                      DetailsCellWidget(
                          items: [serviceDto.name], title: "Nome do serviço"),
                      DetailsCellWidget(items: [
                        serviceDto.description ?? "Descrição não informada"
                      ], title: "Descrição"),
                      DetailsCellWidget(
                          items: [serviceDto.friendlyTime],
                          title: "Tempo de execução"),
                      const DetailsCellWidget(
                          items: ["1 dia"], title: "Pós venda:"),
                      const DetailsCellWidget(
                          items: ["12 vezes"], title: "Ja foi feito:"),
                      const DetailsCellWidget(
                          items: ["R\$ 100,00"], title: "Total em vendas:"),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () async {
                              bool? isServiceRegistered =
                                  await showModalBottomSheet<bool?>(
                                context: context,
                                showDragHandle: true,
                                isScrollControlled: true,
                                builder: (_) => BlocProvider(
                                  create: (context) =>
                                      ServicesRegisterPresenter()..load(),
                                  child: ServiceRegisterBottomSheet.update(
                                      serviceDto),
                                ),
                              );
                              if (isServiceRegistered != null &&
                                  isServiceRegistered) {
                                // ignore: use_build_context_synchronously
                                // homePresenter.load();
                              }
                            },
                            child: Text("Editar serviço")),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text("Preços").label1_bold(),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.white,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              CustomIcons.dhCar,
                                              color: AppColor.accentColor,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      serviceDto.prices[index]
                                                          .carBodyType.value,
                                                    ).label1_bold(),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  serviceDto.prices[index].price
                                                      .priceInReal,
                                                ).label1_bold(),
                                                Row(
                                                  children: [
                                                    Text("Quantidade: ")
                                                        .body_regular(),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text("120").body_bold(),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Rendeu: ")
                                                        .body_regular(),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text("R\$ 100,00")
                                                        .body_bold(),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 16,
                                ),
                            itemCount: serviceDto.prices.length),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
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
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                height: 4,
              ),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(items[index]).label1_bold(),
                  index == 1 && iconButton != null
                      ? iconButton!
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
